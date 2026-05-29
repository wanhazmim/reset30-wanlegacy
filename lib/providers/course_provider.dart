import 'package:flutter/material.dart';
import '../models/lesson_model.dart';
import '../data/course_data.dart';

class CourseProvider extends ChangeNotifier {
  List<Unit> get units => allUnits;

  Unit? getUnitById(String id) {
    try {
      return allUnits.firstWhere((u) => u.id == id);
    } catch (_) {
      return null;
    }
  }

  Lesson? getLessonById(String id) {
    for (final unit in allUnits) {
      for (final lesson in unit.lessons) {
        if (lesson.id == id) return lesson;
      }
    }
    return null;
  }

  /// A lesson is unlocked if it is the first lesson of its unit OR
  /// the immediately preceding lesson in that unit is completed.
  bool isLessonUnlocked(String lessonId, List<String> completedLessons) {
    for (final unit in allUnits) {
      final idx = unit.lessons.indexWhere((l) => l.id == lessonId);
      if (idx == -1) continue;
      if (idx == 0) return true; // first lesson of unit is always unlocked
      final prevLesson = unit.lessons[idx - 1];
      return completedLessons.contains(prevLesson.id);
    }
    return false;
  }

  /// Returns the next unlocked-but-not-yet-completed lesson, or null.
  Lesson? getNextLesson(List<String> completedLessons) {
    for (final unit in allUnits) {
      for (int i = 0; i < unit.lessons.length; i++) {
        final lesson = unit.lessons[i];
        if (!completedLessons.contains(lesson.id) &&
            isLessonUnlocked(lesson.id, completedLessons)) {
          return lesson;
        }
      }
    }
    return null;
  }

  int totalLessons() {
    return allUnits.fold(0, (sum, u) => sum + u.lessons.length);
  }
}
