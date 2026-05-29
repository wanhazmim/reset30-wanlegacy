import 'package:flutter/material.dart';
import '../models/lesson_model.dart';

// ─────────────────────────────────────────────────────────────
// MCQ Exercise
// ─────────────────────────────────────────────────────────────
class McqExercise extends StatefulWidget {
  final Exercise exercise;
  final String language;
  final void Function(bool correct) onAnswer;

  const McqExercise({
    super.key,
    required this.exercise,
    required this.language,
    required this.onAnswer,
  });

  @override
  State<McqExercise> createState() => _McqExerciseState();
}

class _McqExerciseState extends State<McqExercise> {
  int? _selected;
  bool _answered = false;

  void _confirm() {
    if (_selected == null) return;
    final isCorrect = _selected.toString() == widget.exercise.correctAnswer;
    setState(() => _answered = true);
    widget.onAnswer(isCorrect);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isBM = widget.language == 'bm';
    final question = isBM ? widget.exercise.questionBM : widget.exercise.questionEN;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.exercise.codeSample != null) ...[
          _CodeBlock(code: widget.exercise.codeSample!),
          const SizedBox(height: 12),
        ],
        Text(
          question,
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w600, height: 1.4),
        ),
        const SizedBox(height: 20),
        ...List.generate(widget.exercise.options.length, (i) {
          final isSelected = _selected == i;
          final correct = int.tryParse(widget.exercise.correctAnswer);
          Color borderColor = theme.colorScheme.outline.withOpacity(0.5);
          Color bgColor = theme.colorScheme.surface;
          if (_answered) {
            if (i == correct) {
              borderColor = Colors.green;
              bgColor = Colors.green.shade50;
            } else if (isSelected && i != correct) {
              borderColor = Colors.red;
              bgColor = Colors.red.shade50;
            }
          } else if (isSelected) {
            borderColor = theme.colorScheme.primary;
            bgColor = theme.colorScheme.primaryContainer.withOpacity(0.3);
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: _answered
                  ? null
                  : () => setState(() => _selected = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: borderColor, width: 2),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.surfaceVariant,
                      ),
                      child: Center(
                        child: Text(
                          String.fromCharCode('A'.codeUnitAt(0) + i),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Colors.white
                                : theme.colorScheme.onSurfaceVariant,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.exercise.options[i],
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: 8),
        if (!_answered)
          ElevatedButton(
            onPressed: _selected != null ? _confirm : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              isBM ? 'Semak Jawapan' : 'Check Answer',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// True/False Exercise
// ─────────────────────────────────────────────────────────────
class TrueFalseExercise extends StatefulWidget {
  final Exercise exercise;
  final String language;
  final void Function(bool correct) onAnswer;

  const TrueFalseExercise({
    super.key,
    required this.exercise,
    required this.language,
    required this.onAnswer,
  });

  @override
  State<TrueFalseExercise> createState() => _TrueFalseExerciseState();
}

class _TrueFalseExerciseState extends State<TrueFalseExercise> {
  bool _answered = false;

  void _answer(bool value) {
    if (_answered) return;
    setState(() => _answered = true);
    final isCorrect = value.toString() == widget.exercise.correctAnswer;
    widget.onAnswer(isCorrect);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isBM = widget.language == 'bm';
    final question =
        isBM ? widget.exercise.questionBM : widget.exercise.questionEN;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.exercise.codeSample != null) ...[
          _CodeBlock(code: widget.exercise.codeSample!),
          const SizedBox(height: 12),
        ],
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer.withOpacity(0.25),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: theme.colorScheme.primary.withOpacity(0.3)),
          ),
          child: Text(
            question,
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w600, height: 1.4),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: _TFButton(
                label: isBM ? '✅  Betul' : '✅  True',
                color: Colors.green,
                onTap: _answered ? null : () => _answer(true),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _TFButton(
                label: isBM ? '❌  Salah' : '❌  False',
                color: Colors.red,
                onTap: _answered ? null : () => _answer(false),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TFButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _TFButton({
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: onTap == null ? color.withOpacity(0.3) : color,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: onTap == null ? color.withOpacity(0.6) : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Fill-in-the-Blank Exercise (simplified: pick the right word)
// correctAnswer = the correct word/phrase
// options = word choices
// ─────────────────────────────────────────────────────────────
class FillBlankExercise extends StatefulWidget {
  final Exercise exercise;
  final String language;
  final void Function(bool correct) onAnswer;

  const FillBlankExercise({
    super.key,
    required this.exercise,
    required this.language,
    required this.onAnswer,
  });

  @override
  State<FillBlankExercise> createState() => _FillBlankExerciseState();
}

class _FillBlankExerciseState extends State<FillBlankExercise> {
  String? _selected;
  bool _answered = false;

  void _confirm() {
    if (_selected == null) return;
    setState(() => _answered = true);
    final isCorrect = _selected == widget.exercise.correctAnswer;
    widget.onAnswer(isCorrect);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isBM = widget.language == 'bm';
    final question =
        isBM ? widget.exercise.questionBM : widget.exercise.questionEN;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.exercise.codeSample != null) ...[
          _CodeBlock(code: widget.exercise.codeSample!),
          const SizedBox(height: 12),
        ],
        Text(
          question,
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w600, height: 1.4),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isBM ? 'Jawapan: ' : 'Answer: ',
                style: theme.textTheme.bodyMedium,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: _selected != null
                      ? theme.colorScheme.primary.withOpacity(0.15)
                      : theme.colorScheme.surface,
                  border: Border.all(
                    color: _selected != null
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outline,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _selected ?? '______',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: widget.exercise.options.map((opt) {
            final isSelected = _selected == opt;
            Color bg;
            Color border;
            if (_answered) {
              if (opt == widget.exercise.correctAnswer) {
                bg = Colors.green.shade100;
                border = Colors.green;
              } else if (isSelected && opt != widget.exercise.correctAnswer) {
                bg = Colors.red.shade100;
                border = Colors.red;
              } else {
                bg = theme.colorScheme.surfaceVariant;
                border = theme.colorScheme.outline.withOpacity(0.4);
              }
            } else {
              bg = isSelected
                  ? theme.colorScheme.primaryContainer
                  : theme.colorScheme.surfaceVariant;
              border = isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline.withOpacity(0.4);
            }
            return GestureDetector(
              onTap: _answered ? null : () => setState(() => _selected = opt),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(
                    horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: bg,
                  border: Border.all(color: border, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  opt,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        if (!_answered)
          ElevatedButton(
            onPressed: _selected != null ? _confirm : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              isBM ? 'Semak Jawapan' : 'Check Answer',
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Arrange Exercise — tap blocks in the correct order
// options = list of code blocks to arrange
// correctAnswer = comma-joined correct order of indices, e.g. "0,2,1,3"
// ─────────────────────────────────────────────────────────────
class ArrangeExercise extends StatefulWidget {
  final Exercise exercise;
  final String language;
  final void Function(bool correct) onAnswer;

  const ArrangeExercise({
    super.key,
    required this.exercise,
    required this.language,
    required this.onAnswer,
  });

  @override
  State<ArrangeExercise> createState() => _ArrangeExerciseState();
}

class _ArrangeExerciseState extends State<ArrangeExercise> {
  final List<int> _arranged = [];
  bool _answered = false;

  void _tap(int idx) {
    if (_answered) return;
    if (_arranged.contains(idx)) {
      setState(() => _arranged.remove(idx));
    } else {
      setState(() => _arranged.add(idx));
    }
  }

  void _confirm() {
    if (_arranged.length != widget.exercise.options.length) return;
    setState(() => _answered = true);
    final userAnswer = _arranged.join(',');
    widget.onAnswer(userAnswer == widget.exercise.correctAnswer);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isBM = widget.language == 'bm';
    final question =
        isBM ? widget.exercise.questionBM : widget.exercise.questionEN;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          question,
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w600, height: 1.4),
        ),
        const SizedBox(height: 16),
        // Arranged so far
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 60),
          child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant.withOpacity(0.4),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.4),
                style: BorderStyle.solid),
          ),
          child: _arranged.isEmpty
              ? Center(
                  child: Text(
                    isBM
                        ? 'Ketik blok di bawah untuk menyusunnya...'
                        : 'Tap blocks below to arrange them...',
                    style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.5)),
                  ),
                )
              : Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _arranged.map((idx) {
                    return GestureDetector(
                      onTap: () => _tap(idx),
                      child: Chip(
                        label: Text(widget.exercise.options[idx]),
                        backgroundColor:
                            theme.colorScheme.primaryContainer,
                        deleteIcon: const Icon(Icons.close, size: 14),
                        onDeleted: () => _tap(idx),
                      ),
                    );
                  }).toList(),
                ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(widget.exercise.options.length, (i) {
            final isUsed = _arranged.contains(i);
            return GestureDetector(
              onTap: isUsed || _answered ? null : () => _tap(i),
              child: AnimatedOpacity(
                opacity: isUsed ? 0.3 : 1.0,
                duration: const Duration(milliseconds: 150),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: theme.colorScheme.outline.withOpacity(0.5)),
                  ),
                  child: Text(
                    widget.exercise.options[i],
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 24),
        if (!_answered)
          ElevatedButton(
            onPressed:
                _arranged.length == widget.exercise.options.length
                    ? _confirm
                    : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              isBM ? 'Semak Urutan' : 'Check Order',
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Dispatcher widget
// ─────────────────────────────────────────────────────────────
class ExerciseWidget extends StatelessWidget {
  final Exercise exercise;
  final String language;
  final void Function(bool correct) onAnswer;

  const ExerciseWidget({
    super.key,
    required this.exercise,
    required this.language,
    required this.onAnswer,
  });

  @override
  Widget build(BuildContext context) {
    switch (exercise.type) {
      case 'mcq':
        return McqExercise(
          exercise: exercise,
          language: language,
          onAnswer: onAnswer,
        );
      case 'truefalse':
        return TrueFalseExercise(
          exercise: exercise,
          language: language,
          onAnswer: onAnswer,
        );
      case 'fillblank':
        return FillBlankExercise(
          exercise: exercise,
          language: language,
          onAnswer: onAnswer,
        );
      case 'arrange':
        return ArrangeExercise(
          exercise: exercise,
          language: language,
          onAnswer: onAnswer,
        );
      default:
        return McqExercise(
          exercise: exercise,
          language: language,
          onAnswer: onAnswer,
        );
    }
  }
}

// ─────────────────────────────────────────────────────────────
// Shared helper
// ─────────────────────────────────────────────────────────────
class _CodeBlock extends StatelessWidget {
  final String code;
  const _CodeBlock({required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          color: Color(0xFFCDD6F4),
          fontSize: 13,
          height: 1.5,
        ),
      ),
    );
  }
}
