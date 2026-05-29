import 'package:flutter/material.dart';
import '../models/lesson_model.dart';

class LearnSlidesWidget extends StatefulWidget {
  final List<LearnSlide> slides;
  final bool isBM;
  final VoidCallback onComplete;

  const LearnSlidesWidget({
    super.key,
    required this.slides,
    required this.isBM,
    required this.onComplete,
  });

  @override
  State<LearnSlidesWidget> createState() => _LearnSlidesWidgetState();
}

class _LearnSlidesWidgetState extends State<LearnSlidesWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentPage < widget.slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      widget.onComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLast = _currentPage == widget.slides.length - 1;

    return Column(
      children: [
        // Dot indicators
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.slides.length, (i) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: i == _currentPage ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: i == _currentPage
                      ? theme.colorScheme.primary
                      : theme.colorScheme.primary.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
        ),

        // Slide pages
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.slides.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, i) {
              final slide = widget.slides[i];
              return _SlideCard(
                slide: slide,
                isBM: widget.isBM,
              );
            },
          ),
        ),

        // Button
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: ElevatedButton(
            onPressed: _next,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              backgroundColor:
                  isLast ? Colors.green : theme.colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            child: Text(
              isLast
                  ? (widget.isBM ? 'Mula Latihan! 🎯' : 'Start Exercises! 🎯')
                  : (widget.isBM ? 'Seterusnya →' : 'Next →'),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SlideCard extends StatelessWidget {
  final LearnSlide slide;
  final bool isBM;

  const _SlideCard({required this.slide, required this.isBM});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = isBM ? slide.titleBM : slide.titleEN;
    final body = isBM ? slide.bodyBM : slide.bodyEN;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Emoji illustration
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  slide.emoji,
                  style: const TextStyle(fontSize: 52),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Title
          Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Body text
          Text(
            body,
            style: theme.textTheme.bodyLarge?.copyWith(height: 1.65),
            textAlign: TextAlign.center,
          ),

          // Code example
          if (slide.codeExample != null) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                slide.codeExample!,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                  color: Color(0xFFCDD6F4),
                  height: 1.6,
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
