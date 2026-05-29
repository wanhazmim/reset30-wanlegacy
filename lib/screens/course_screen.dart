import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/course_provider.dart';
import '../widgets/lesson_card.dart';
import 'lesson_screen.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  Color _hexToColor(String hex) {
    final h = hex.replaceAll('#', '');
    return Color(int.parse('FF$h', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, CourseProvider>(
      builder: (context, userProvider, courseProvider, _) {
        final isBM = userProvider.language == 'bm';
        final completedLessons = userProvider.completedLessons;
        final theme = Theme.of(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              isBM ? 'Kursus' : 'Course',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${completedLessons.length}/${courseProvider.totalLessons()}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                          fontSize: 15),
                    ),
                    Text(
                      isBM ? 'Selesai' : 'Done',
                      style: theme.textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: courseProvider.units.length,
            itemBuilder: (context, unitIndex) {
              final unit = courseProvider.units[unitIndex];
              final unitColor = _hexToColor(unit.color);
              final unitCompletedCount = unit.lessons
                  .where((l) => completedLessons.contains(l.id))
                  .length;
              final allDone = unitCompletedCount == unit.lessons.length;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Unit Header
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: unitColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: unitColor.withOpacity(0.5), width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Text(unit.emoji,
                            style: const TextStyle(fontSize: 32)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isBM ? unit.titleBM : unit.titleEN,
                                style: theme.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                isBM
                                    ? '$unitCompletedCount/${unit.lessons.length} pelajaran selesai'
                                    : '$unitCompletedCount/${unit.lessons.length} lessons done',
                                style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.6)),
                              ),
                            ],
                          ),
                        ),
                        if (allDone)
                          const Icon(Icons.emoji_events,
                              color: Colors.amber, size: 28),
                      ],
                    ),
                  ),

                  // Lessons
                  ...unit.lessons.map((lesson) {
                    final isCompleted = completedLessons.contains(lesson.id);
                    final isUnlocked = courseProvider.isLessonUnlocked(
                        lesson.id, completedLessons);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8, left: 8),
                      child: LessonCard(
                        lesson: lesson,
                        isCompleted: isCompleted,
                        isUnlocked: isUnlocked,
                        unitColor: unitColor,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) =>
                                LessonScreen(lessonId: lesson.id),
                          ));
                        },
                      ),
                    );
                  }),

                  const SizedBox(height: 16),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
