import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/course_provider.dart';
import '../models/lesson_model.dart';
import '../widgets/hearts_widget.dart';
import '../widgets/exercise_widget.dart';
import '../widgets/learn_slides_widget.dart';

class LessonScreen extends StatefulWidget {
  final String lessonId;

  const LessonScreen({super.key, required this.lessonId});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  bool _showingSlides = true;
  int _currentExerciseIndex = 0;
  int _correctCount = 0;
  bool _showingFeedback = false;
  bool _lastAnswerCorrect = false;
  bool _lessonComplete = false;
  bool _noHearts = false;
  bool _waitingForNext = false;

  Lesson? _lesson;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final courseProvider = context.read<CourseProvider>();
      final lesson = courseProvider.getLessonById(widget.lessonId);
      setState(() {
        _lesson = lesson;
        // Skip slides phase if no slides defined
        if (lesson != null && lesson.slides.isEmpty) {
          _showingSlides = false;
        }
      });
    });
  }

  void _onAnswer(bool correct) async {
    final userProvider = context.read<UserProvider>();
    setState(() {
      _lastAnswerCorrect = correct;
      _showingFeedback = true;
      if (correct) _correctCount++;
    });

    if (!correct) {
      await userProvider.loseHeart();
      if (userProvider.hearts <= 0) {
        setState(() => _noHearts = true);
        return;
      }
    }
    // Award small XP for each correct answer and mark user active
    if (correct) {
      await userProvider.addXP(5);
      await userProvider.markActiveNow();
    }
  }

  void _next() {
    if (_lesson == null) return;
    if (_noHearts) return;

    setState(() {
      _showingFeedback = false;
      _waitingForNext = false;
    });

    if (_currentExerciseIndex < _lesson!.exercises.length - 1) {
      setState(() => _currentExerciseIndex++);
    } else {
      _completeLesson();
    }
  }

  Future<void> _completeLesson() async {
    final userProvider = context.read<UserProvider>();
    final newAchievements =
        await userProvider.completeLesson(widget.lessonId);
    setState(() => _lessonComplete = true);

    if (newAchievements.isNotEmpty && mounted) {
      _showAchievementDialog(newAchievements);
    }
  }

  void _showAchievementDialog(List<String> ids) {
    final isBM = context.read<UserProvider>().language == 'bm';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isBM ? '🏆 Pencapaian Baharu!' : '🏆 New Achievement!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ids.map((id) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text('• $id', style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isBM ? 'Hebat!' : 'Awesome!'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final isBM = userProvider.language == 'bm';
    final theme = Theme.of(context);

    if (_lesson == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final lesson = _lesson!;
    final progress = (_currentExerciseIndex + (_showingFeedback ? 1 : 0)) /
        lesson.exercises.length;

    // Show learning slides first
    if (_showingSlides && lesson.slides.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => _showQuitDialog(context, isBM),
          ),
          title: Text(
            isBM ? lesson.titleBM : lesson.titleEN,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: LearnSlidesWidget(
          slides: lesson.slides,
          isBM: isBM,
          onComplete: () => setState(() => _showingSlides = false),
        ),
      );
    }

    if (_lessonComplete) {
      return _CompletionScreen(
        lesson: lesson,
        correctCount: _correctCount,
        isBM: isBM,
        xpEarned: lesson.xpReward,
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _showQuitDialog(context, isBM),
        ),
        title: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                  backgroundColor: theme.colorScheme.surfaceVariant,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      theme.colorScheme.primary),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${_currentExerciseIndex + 1}/${lesson.exercises.length}',
              style: theme.textTheme.labelLarge,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: HeartsWidget(hearts: userProvider.hearts, size: 18),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Exercise type label
                      _ExerciseTypeLabel(
                        type: lesson.exercises[_currentExerciseIndex].type,
                        isBM: isBM,
                      ),
                      const SizedBox(height: 16),
                      // Exercise content — key forces rebuild when index changes
                      KeyedSubtree(
                        key: ValueKey(_currentExerciseIndex),
                        child: ExerciseWidget(
                          exercise: lesson.exercises[_currentExerciseIndex],
                          language: isBM ? 'bm' : 'en',
                          onAnswer: (correct) {
                            _onAnswer(correct);
                          },
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // No hearts overlay
          if (_noHearts)
            _NoHeartsOverlay(
              isBM: isBM,
              onWait: () async {
                await userProvider.refillHearts();
                setState(() => _noHearts = false);
              },
              onQuit: () => Navigator.of(context).pop(),
            ),

          // Feedback bottom sheet
          if (_showingFeedback && !_noHearts)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _FeedbackPanel(
                isCorrect: _lastAnswerCorrect,
                isBM: isBM,
                explanation: isBM
                    ? lesson.exercises[_currentExerciseIndex].explanationBM
                    : lesson.exercises[_currentExerciseIndex].explanationEN,
                onNext: _next,
                isLast: _currentExerciseIndex == lesson.exercises.length - 1,
              ),
            ),
        ],
      ),
    );
  }

  void _showQuitDialog(BuildContext context, bool isBM) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isBM ? 'Keluar Pelajaran?' : 'Quit Lesson?'),
        content: Text(
          isBM
              ? 'Kemajuan anda tidak akan disimpan.'
              : 'Your progress will not be saved.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isBM ? 'Teruskan' : 'Continue'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              isBM ? 'Keluar' : 'Quit',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseTypeLabel extends StatelessWidget {
  final String type;
  final bool isBM;

  const _ExerciseTypeLabel({required this.type, required this.isBM});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String label;
    String emoji;

    switch (type) {
      case 'mcq':
        label = isBM ? 'Pilihan Berganda' : 'Multiple Choice';
        emoji = '🔘';
      case 'truefalse':
        label = isBM ? 'Betul atau Salah' : 'True or False';
        emoji = '✅';
      case 'fillblank':
        label = isBM ? 'Isi Tempat Kosong' : 'Fill in the Blank';
        emoji = '✏️';
      case 'arrange':
        label = isBM ? 'Susun Kod' : 'Arrange Code';
        emoji = '🔀';
      default:
        label = '';
        emoji = '';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedbackPanel extends StatelessWidget {
  final bool isCorrect;
  final bool isBM;
  final String explanation;
  final VoidCallback onNext;
  final bool isLast;

  const _FeedbackPanel({
    required this.isCorrect,
    required this.isBM,
    required this.explanation,
    required this.onNext,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final color = isCorrect ? Colors.green : Colors.red;
    final bgColor = isCorrect ? Colors.green.shade50 : Colors.red.shade50;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(top: BorderSide(color: color, width: 2)),
        boxShadow: [
          BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, -4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: color,
                size: 28,
              ),
              const SizedBox(width: 10),
              Text(
                isCorrect
                    ? (isBM ? 'Betul! 🎉' : 'Correct! 🎉')
                    : (isBM ? 'Salah 😔' : 'Wrong 😔'),
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            explanation,
            style: TextStyle(
                color: isCorrect
                    ? Colors.green.shade800
                    : Colors.red.shade800,
                height: 1.5),
          ),
          const SizedBox(height: 14),
          ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              isLast
                  ? (isBM ? 'Selesai! 🎉' : 'Finish! 🎉')
                  : (isBM ? 'Seterusnya →' : 'Next →'),
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _NoHeartsOverlay extends StatelessWidget {
  final bool isBM;
  final VoidCallback onWait;
  final VoidCallback onQuit;

  const _NoHeartsOverlay({
    required this.isBM,
    required this.onWait,
    required this.onQuit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('💔', style: TextStyle(fontSize: 56)),
                const SizedBox(height: 16),
                Text(
                  isBM ? 'Habis Nyawa!' : 'Out of Hearts!',
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  isBM
                      ? 'Nyawa anda telah habis. Tunggu sebentar atau keluar dan kembali semula esok!'
                      : 'You have run out of hearts. Wait a moment or come back tomorrow!',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: onWait,
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  label: Text(
                    isBM ? 'Isi Semula Nyawa (Demo)' : 'Refill Hearts (Demo)',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: onQuit,
                  child: Text(
                    isBM ? 'Keluar Pelajaran' : 'Quit Lesson',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CompletionScreen extends StatefulWidget {
  final Lesson lesson;
  final int correctCount;
  final bool isBM;
  final int xpEarned;

  const _CompletionScreen({
    required this.lesson,
    required this.correctCount,
    required this.isBM,
    required this.xpEarned,
  });

  @override
  State<_CompletionScreen> createState() => _CompletionScreenState();
}

class _CompletionScreenState extends State<_CompletionScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    _scale = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = widget.lesson.exercises.length;
    final accuracy = total > 0 ? (widget.correctCount / total * 100).round() : 0;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: _scale,
                  child: const Text('🎉', style: TextStyle(fontSize: 80)),
                ),
                const SizedBox(height: 24),
                Text(
                  widget.isBM ? 'Tahniah!' : 'Congratulations!',
                  style: theme.textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.isBM
                      ? 'Anda telah menyelesaikan\n"${widget.lesson.titleBM}"'
                      : 'You completed\n"${widget.lesson.titleEN}"',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 36),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ResultStat(
                      emoji: '⭐',
                      value: '+${widget.xpEarned}',
                      label: 'XP',
                      color: Colors.amber,
                    ),
                    _ResultStat(
                      emoji: '✅',
                      value: '${widget.correctCount}/$total',
                      label: widget.isBM ? 'Betul' : 'Correct',
                      color: Colors.green,
                    ),
                    _ResultStat(
                      emoji: '🎯',
                      value: '$accuracy%',
                      label: widget.isBM ? 'Tepat' : 'Accuracy',
                      color: Colors.blue,
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(
                    widget.isBM ? 'Teruskan! 🚀' : 'Continue! 🚀',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultStat extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;
  final Color color;

  const _ResultStat({
    required this.emoji,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 32)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w900, color: color),
        ),
        Text(label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withOpacity(0.6))),
      ],
    );
  }
}
