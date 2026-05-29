import 'package:flutter/material.dart';

class XpBar extends StatelessWidget {
  final int current;
  final int total;
  final Color? color;
  final double height;
  final bool showLabel;

  const XpBar({
    super.key,
    required this.current,
    required this.total,
    this.color,
    this.height = 10,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final progress = total > 0 ? (current / total).clamp(0.0, 1.0) : 0.0;
    final barColor = color ?? Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLabel) ...[
          Text(
            '$current / $total XP',
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: barColor, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(height),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: height,
            backgroundColor: barColor.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(barColor),
          ),
        ),
      ],
    );
  }
}
