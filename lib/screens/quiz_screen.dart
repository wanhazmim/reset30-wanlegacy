import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../providers/user_provider.dart';
import 'lesson_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, CourseProvider>(
      builder: (context, userProvider, courseProvider, _) {
        final isBM = userProvider.language == 'bm';
        final lessons = courseProvider.units
            .expand((u) => u.lessons)
            .toList();

        return Scaffold(
          appBar: AppBar(title: Text(isBM ? 'Kuiz' : 'Quizzes')),
          body: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: lessons.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, i) {
              final l = lessons[i];
              return ListTile(
                leading: Text(l.emoji, style: const TextStyle(fontSize: 26)),
                title: Text(isBM ? l.titleBM : l.titleEN),
                subtitle: Text(isBM ? l.descBM : l.descEN),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => LessonScreen(
                        lessonId: l.id,
                        startExercises: true,
                      ),
                    ));
                  },
                  child: Text(isBM ? 'Mulakan Kuiz' : 'Start Quiz'),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
