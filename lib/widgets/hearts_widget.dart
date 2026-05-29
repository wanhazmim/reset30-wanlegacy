import 'package:flutter/material.dart';

class HeartsWidget extends StatelessWidget {
  final int hearts;
  final int maxHearts;
  final double size;

  const HeartsWidget({
    super.key,
    required this.hearts,
    this.maxHearts = 5,
    this.size = 22,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxHearts, (i) {
        return Icon(
          i < hearts ? Icons.favorite : Icons.favorite_border,
          color: i < hearts ? Colors.red : Colors.grey.shade400,
          size: size,
        );
      }),
    );
  }
}
