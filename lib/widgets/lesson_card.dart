import 'package:flutter/material.dart';
import '../models/lesson_model.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;
  final bool isCompleted;
  final bool isUnlocked;
  final VoidCallback? onTap;
  final Color unitColor;

  const LessonCard({
    super.key,
    required this.lesson,
    required this.isCompleted,
    required this.isUnlocked,
    this.onTap,
    this.unitColor = Colors.teal,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color cardColor;
    String statusEmoji;
    if (isCompleted) {
      cardColor = Colors.green.shade100;
      statusEmoji = '✅';
    } else if (isUnlocked) {
      cardColor = theme.colorScheme.surface;
      statusEmoji = lesson.emoji;
    } else {
      cardColor = theme.colorScheme.surfaceVariant.withOpacity(0.5);
      statusEmoji = '🔒';
    }

    return Card(
      elevation: isUnlocked && !isCompleted ? 2 : 0,
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isUnlocked && !isCompleted
            ? BorderSide(color: unitColor, width: 1.5)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: isUnlocked ? onTap : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Text(statusEmoji, style: const TextStyle(fontSize: 26)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.titleBM,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isUnlocked
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.onSurface.withOpacity(0.45),
                      ),
                    ),
                    Text(
                      lesson.descBM,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.55),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (isUnlocked && !isCompleted) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: unitColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '+${lesson.xpReward} XP',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
