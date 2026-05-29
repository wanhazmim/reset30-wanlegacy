import 'dart:convert';

class UserModel {
  String name;
  int xp;
  int hearts; // max 5
  int streak;
  DateTime? lastActiveDate;
  DateTime? challengeStartDate;
  bool isDarkMode;
  String language; // 'bm' or 'en'
  List<String> completedLessons; // lesson IDs
  List<String> unlockedAchievements;
  Map<String, int> dailyHistory; // 'yyyy-MM-dd': xpEarned
  bool isFirstTime;

  UserModel({
    this.name = '',
    this.xp = 0,
    this.hearts = 5,
    this.streak = 0,
    this.lastActiveDate,
    this.challengeStartDate,
    this.isDarkMode = false,
    this.language = 'bm',
    List<String>? completedLessons,
    List<String>? unlockedAchievements,
    Map<String, int>? dailyHistory,
    this.isFirstTime = true,
  })  : completedLessons = completedLessons ?? [],
        unlockedAchievements = unlockedAchievements ?? [],
        dailyHistory = dailyHistory ?? {};

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String? ?? '',
      xp: json['xp'] as int? ?? 0,
      hearts: json['hearts'] as int? ?? 5,
      streak: json['streak'] as int? ?? 0,
      lastActiveDate: json['lastActiveDate'] != null
          ? DateTime.tryParse(json['lastActiveDate'] as String)
          : null,
      challengeStartDate: json['challengeStartDate'] != null
          ? DateTime.tryParse(json['challengeStartDate'] as String)
          : null,
      isDarkMode: json['isDarkMode'] as bool? ?? false,
      language: json['language'] as String? ?? 'bm',
      completedLessons: (json['completedLessons'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      unlockedAchievements: (json['unlockedAchievements'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      dailyHistory: (json['dailyHistory'] as Map<String, dynamic>?)
              ?.map((k, v) => MapEntry(k, v as int)) ??
          {},
      isFirstTime: json['isFirstTime'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'xp': xp,
      'hearts': hearts,
      'streak': streak,
      'lastActiveDate': lastActiveDate?.toIso8601String(),
      'challengeStartDate': challengeStartDate?.toIso8601String(),
      'isDarkMode': isDarkMode,
      'language': language,
      'completedLessons': completedLessons,
      'unlockedAchievements': unlockedAchievements,
      'dailyHistory': dailyHistory,
      'isFirstTime': isFirstTime,
    };
  }

  UserModel copyWith({
    String? name,
    int? xp,
    int? hearts,
    int? streak,
    DateTime? lastActiveDate,
    DateTime? challengeStartDate,
    bool? isDarkMode,
    String? language,
    List<String>? completedLessons,
    List<String>? unlockedAchievements,
    Map<String, int>? dailyHistory,
    bool? isFirstTime,
  }) {
    return UserModel(
      name: name ?? this.name,
      xp: xp ?? this.xp,
      hearts: hearts ?? this.hearts,
      streak: streak ?? this.streak,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
      challengeStartDate: challengeStartDate ?? this.challengeStartDate,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      language: language ?? this.language,
      completedLessons: completedLessons ?? List.from(this.completedLessons),
      unlockedAchievements:
          unlockedAchievements ?? List.from(this.unlockedAchievements),
      dailyHistory: dailyHistory ?? Map.from(this.dailyHistory),
      isFirstTime: isFirstTime ?? this.isFirstTime,
    );
  }

  String toJsonString() => jsonEncode(toJson());

  factory UserModel.fromJsonString(String jsonString) =>
      UserModel.fromJson(jsonDecode(jsonString) as Map<String, dynamic>);
}
