import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../data/course_data.dart';

class UserProvider extends ChangeNotifier {
  static const String _userKey = 'user_data';

  UserModel _user = UserModel();
  SharedPreferences? _prefs;

  UserModel get user => _user;

  bool get isFirstTime => _user.isFirstTime;
  String get name => _user.name;
  int get xp => _user.xp;
  int get hearts => _user.hearts;
  int get streak => _user.streak;
  bool get isDarkMode => _user.isDarkMode;
  String get language => _user.language;
  List<String> get completedLessons => _user.completedLessons;
  List<String> get unlockedAchievements => _user.unlockedAchievements;

  Future<void> init(SharedPreferences prefs) async {
    _prefs = prefs;
    final jsonString = prefs.getString(_userKey);
    if (jsonString != null) {
      try {
        _user = UserModel.fromJsonString(jsonString);
      } catch (_) {
        _user = UserModel();
      }
    }
    refillHeartsIfNewDay();
    checkAndUpdateStreak();
    notifyListeners();
  }

  Future<void> _save() async {
    await _prefs?.setString(_userKey, _user.toJsonString());
  }

  // ─── Onboarding ───────────────────────────────────────────────
  Future<void> completeOnboarding({required String name, required String language}) async {
    _user = _user.copyWith(
      name: name.trim().isEmpty ? 'Coder' : name.trim(),
      language: language,
      isFirstTime: false,
      challengeStartDate: DateTime.now(),
    );
    await _save();
    notifyListeners();
  }

  // ─── Profile ──────────────────────────────────────────────────
  Future<void> setName(String newName) async {
    _user = _user.copyWith(name: newName.trim().isEmpty ? 'Coder' : newName.trim());
    await _save();
    notifyListeners();
  }

  Future<void> setLanguage(String lang) async {
    _user = _user.copyWith(language: lang);
    await _save();
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    _user = _user.copyWith(isDarkMode: !_user.isDarkMode);
    await _save();
    notifyListeners();
  }

  // ─── Hearts ───────────────────────────────────────────────────
  Future<void> loseHeart() async {
    if (_user.hearts > 0) {
      _user = _user.copyWith(hearts: _user.hearts - 1);
      await _save();
      notifyListeners();
    }
  }

  void refillHeartsIfNewDay() {
    final now = DateTime.now();
    final last = _user.lastActiveDate;
    if (last == null || !_isSameDay(last, now)) {
      if (_user.hearts < 5) {
        _user = _user.copyWith(hearts: 5);
        _save();
      }
    }
  }

  Future<void> refillHearts() async {
    _user = _user.copyWith(hearts: 5);
    await _save();
    notifyListeners();
  }

  // ─── XP & Level ───────────────────────────────────────────────
  Future<void> addXP(int amount) async {
    final newXp = _user.xp + amount;
    final today = _dateKey(DateTime.now());
    final history = Map<String, int>.from(_user.dailyHistory);
    history[today] = (history[today] ?? 0) + amount;

    _user = _user.copyWith(xp: newXp, dailyHistory: history);
    await _save();
    notifyListeners();
  }

  int getLevel() {
    final level = _user.xp ~/ 200;
    return level.clamp(1, 10);
  }

  int xpToNextLevel() {
    final currentLevel = getLevel();
    if (currentLevel >= 10) return 0;
    return (currentLevel + 1) * 200 - _user.xp;
  }

  double levelProgress() {
    final currentLevel = getLevel();
    if (currentLevel >= 10) return 1.0;
    final levelStart = currentLevel * 200;
    final levelEnd = (currentLevel + 1) * 200;
    return ((_user.xp - levelStart) / (levelEnd - levelStart)).clamp(0.0, 1.0);
  }

  // ─── Streak ───────────────────────────────────────────────────
  bool getStreakStatus() {
    final last = _user.lastActiveDate;
    if (last == null) return false;
    return _isSameDay(last, DateTime.now());
  }

  void checkAndUpdateStreak() {
    final now = DateTime.now();
    final last = _user.lastActiveDate;
    if (last == null) return;

    final diff = _daysDiff(last, now);
    if (diff > 1) {
      // Missed a day — reset streak
      _user = _user.copyWith(streak: 0);
      _save();
    }
  }

  Future<void> _markActiveToday() async {
    final now = DateTime.now();
    final last = _user.lastActiveDate;
    int newStreak = _user.streak;

    if (last == null) {
      newStreak = 1;
    } else if (_isSameDay(last, now)) {
      // Already active today
    } else if (_daysDiff(last, now) == 1) {
      newStreak = _user.streak + 1;
    } else {
      newStreak = 1;
    }

    _user = _user.copyWith(streak: newStreak, lastActiveDate: now);
    await _save();
  }

  // ─── Lessons ──────────────────────────────────────────────────
  Future<List<String>> completeLesson(String lessonId) async {
    if (_user.completedLessons.contains(lessonId)) return [];

    final completed = List<String>.from(_user.completedLessons)..add(lessonId);
    _user = _user.copyWith(completedLessons: completed);

    // Find lesson XP reward
    int xpReward = 20;
    for (final unit in allUnits) {
      for (final lesson in unit.lessons) {
        if (lesson.id == lessonId) {
          xpReward = lesson.xpReward;
          break;
        }
      }
    }

    await addXP(xpReward);
    await _markActiveToday();

    final newAchievements = _checkAchievements(completed);
    await _save();
    notifyListeners();
    return newAchievements;
  }

  List<String> _checkAchievements(List<String> completed) {
    final newOnes = <String>[];
    final unlocked = List<String>.from(_user.unlockedAchievements);

    void tryUnlock(String id) {
      if (!unlocked.contains(id)) {
        unlocked.add(id);
        newOnes.add(id);
      }
    }

    if (completed.isNotEmpty) tryUnlock('first_lesson');
    if (completed.length >= 5) tryUnlock('lessons_5');
    if (completed.length >= 10) tryUnlock('lessons_10');

    final totalLessons = allUnits.fold<int>(0, (s, u) => s + u.lessons.length);
    if (completed.length >= totalLessons) tryUnlock('lessons_all');

    if (_user.streak >= 3) tryUnlock('streak_3');
    if (_user.streak >= 7) tryUnlock('streak_7');
    if (_user.streak >= 14) tryUnlock('streak_14');
    if (_user.streak >= 30) tryUnlock('streak_30');

    final level = getLevel();
    if (level >= 5) tryUnlock('level_5');

    if (_user.xp >= 500) tryUnlock('xp_500');

    if (newOnes.isNotEmpty) {
      _user = _user.copyWith(unlockedAchievements: unlocked);
    }
    return newOnes;
  }

  // ─── Progress ─────────────────────────────────────────────────
  Future<void> resetProgress() async {
    _user = UserModel(
      name: _user.name,
      language: _user.language,
      isDarkMode: _user.isDarkMode,
      isFirstTime: false,
    );
    await _save();
    notifyListeners();
  }

  List<MapEntry<String, int>> getLast30DaysXP() {
    final result = <MapEntry<String, int>>[];
    final now = DateTime.now();
    for (int i = 29; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final key = _dateKey(date);
      result.add(MapEntry(key, _user.dailyHistory[key] ?? 0));
    }
    return result;
  }

  int getTotalActiveDays() {
    return _user.dailyHistory.values.where((v) => v > 0).length;
  }

  // ─── Helpers ──────────────────────────────────────────────────
  String _dateKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  int _daysDiff(DateTime from, DateTime to) {
    final a = DateTime(from.year, from.month, from.day);
    final b = DateTime(to.year, to.month, to.day);
    return b.difference(a).inDays;
  }
}
