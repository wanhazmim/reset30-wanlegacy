import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/course_provider.dart';
import '../data/achievements_data.dart';
import '../constants/quotes.dart';
import '../widgets/hearts_widget.dart';
import '../widgets/stat_card.dart';
import 'lesson_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, CourseProvider>(
      builder: (context, userProvider, courseProvider, _) {
        final user = userProvider.user;
        final isBM = user.language == 'bm';
        final theme = Theme.of(context);

        // Daily quote based on day of year
        final dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year)).inDays;
        final quote = motivationalQuotes[dayOfYear % motivationalQuotes.length];

        // Next lesson
        final nextLesson =
            courseProvider.getNextLesson(user.completedLessons);
        final totalLessons = courseProvider.totalLessons();
        final completedCount = user.completedLessons.length;
        final pathProgress = totalLessons > 0
            ? completedCount / totalLessons
            : 0.0;

        // Today's date string
        final now = DateTime.now();
        final days = isBM
            ? ['Ahad', 'Isnin', 'Selasa', 'Rabu', 'Khamis', 'Jumaat', 'Sabtu']
            : ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
        final months = isBM
            ? ['Jan', 'Feb', 'Mac', 'Apr', 'Mei', 'Jun', 'Jul', 'Ogs', 'Sep', 'Okt', 'Nov', 'Dis']
            : ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        final dateStr =
            '${days[now.weekday % 7]}, ${now.day} ${months[now.month - 1]} ${now.year}';

        // Completed today
        final completedToday = userProvider.getStreakStatus();

        // Level
        final level = userProvider.getLevel();

        // Recent achievements
        final recentAchievements = user.unlockedAchievements.reversed
            .take(3)
            .map((id) {
              try {
                return allAchievements.firstWhere((a) => a.id == id);
              } catch (_) {
                return null;
              }
            })
            .whereType<Achievement>()
            .toList();

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'CODE30',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 24,
                color: theme.colorScheme.primary,
                letterSpacing: 2,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Row(
                  children: [
                    const Icon(Icons.local_fire_department,
                        color: Colors.orange, size: 22),
                    const SizedBox(width: 4),
                    Text(
                      '${user.streak}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              userProvider.refillHeartsIfNewDay();
              userProvider.checkAndUpdateStreak();
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Greeting
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isBM
                                ? 'Helo, ${user.name}! 👋'
                                : 'Hello, ${user.name}! 👋',
                            style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            dateStr,
                            style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.6)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isBM ? 'Aras $level' : 'Level $level',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Premium hero card
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary.withOpacity(0.18),
                        theme.colorScheme.primaryContainer.withOpacity(0.12),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: theme.colorScheme.primary.withOpacity(0.18)),
                  ),
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              isBM ? 'PRO' : 'PREMIUM',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              isBM
                                  ? 'Belajar coding seperti aplikasi terbaik di dunia.'
                                  : 'Learn code with the best premium experience.',
                              style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSurface),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        isBM
                            ? 'Kuasai kemahiran, bina streak, dan dapatkan ganjaran XP setiap hari.'
                            : 'Master skills, build your streak, and earn XP every day.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.8)),
                      ),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildFeatureChip(
                              context,
                              isBM ? 'Misi Harian' : 'Daily Mission'),
                          _buildFeatureChip(
                              context,
                              isBM ? 'Cabaran Kod' : 'Code Challenges'),
                          _buildFeatureChip(
                              context,
                              isBM ? 'Sesi Interaktif' : 'Interactive Sessions'),
                        ],
                      ),
                      const SizedBox(height: 18),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          isBM ? 'Terokai Premium' : 'Explore Premium',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Hearts + XP Row
                Row(
                  children: [
                    HeartsWidget(hearts: user.hearts),
                    const Spacer(),
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      '${user.xp} XP',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Stats row
                Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        emoji: '🔥',
                        value: '${user.streak}',
                        label: isBM ? 'Hari Streak' : 'Day Streak',
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: StatCard(
                        emoji: '📚',
                        value: '${user.completedLessons.length}',
                        label: isBM ? 'Pelajaran' : 'Lessons',
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: StatCard(
                        emoji: '⭐',
                        value: '$level',
                        label: isBM ? 'Aras' : 'Level',
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Daily goal card
                Card(
                  color: completedToday
                      ? Colors.green.shade50
                      : theme.colorScheme.primaryContainer.withOpacity(0.25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide(
                      color: completedToday
                          ? Colors.green
                          : theme.colorScheme.primary.withOpacity(0.4),
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Text(
                          completedToday ? '🎯' : '🎯',
                          style: const TextStyle(fontSize: 30),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isBM
                                    ? 'Matlamat Harian'
                                    : 'Daily Goal',
                                style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                completedToday
                                  ? (isBM
                                      ? 'Tugas pembelajaran hari ini selesai! ✅'
                                      : 'Today’s learning mission is done! ✅')
                                  : (isBM
                                      ? 'Capai misi harian: 1 pelajaran'
                                      : 'Hit today’s mission: 1 lesson'),
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        if (completedToday)
                          const Icon(Icons.check_circle,
                              color: Colors.green, size: 28),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Learning path card
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                  color: theme.colorScheme.primaryContainer.withOpacity(0.12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isBM ? 'Jalan Pembelajaran' : 'Learning Path',
                          style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          isBM
                              ? 'Kuasai HTML, CSS dan JavaScript secara bergaya.'
                              : 'Master HTML, CSS and JavaScript step by step.',
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 14),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: LinearProgressIndicator(
                            value: pathProgress,
                            minHeight: 12,
                            backgroundColor:
                                theme.colorScheme.surfaceVariant,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                theme.colorScheme.primary),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          isBM
                              ? 'Anda telah menyelesaikan $completedCount daripada $totalLessons pelajaran.'
                              : 'You completed $completedCount of $totalLessons lessons.',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Continue button
                if (nextLesson != null) ...[
                  Material(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(14),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              LessonScreen(lessonId: nextLesson.id),
                        ));
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Text(nextLesson.emoji,
                                style: const TextStyle(fontSize: 28)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isBM
                                        ? 'Teruskan Di Mana Anda Berhenti'
                                        : 'Continue Where You Left Off',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    isBM
                                        ? nextLesson.titleBM
                                        : nextLesson.titleEN,
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.85),
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios,
                                color: Colors.white, size: 18),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ] else ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.green.withOpacity(0.4)),
                    ),
                    child: Row(
                      children: [
                        const Text('🏆', style: TextStyle(fontSize: 28)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            isBM
                                ? 'Tahniah! Anda telah menyelesaikan semua pelajaran!'
                                : 'Congratulations! You have completed all lessons!',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Recent achievements
                if (recentAchievements.isNotEmpty) ...[
                  Text(
                    isBM ? 'Pencapaian Terbaru' : 'Recent Achievements',
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: recentAchievements.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, i) {
                        final a = recentAchievements[i];
                        return Container(
                          width: 130,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Colors.amber.withOpacity(0.5)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(a.emoji,
                                  style: const TextStyle(fontSize: 28)),
                              const SizedBox(height: 4),
                              Text(
                                isBM ? a.titleBM : a.titleEN,
                                style: theme.textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Motivational quote
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary.withOpacity(0.08),
                        theme.colorScheme.secondary.withOpacity(0.08),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: theme.colorScheme.primary.withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('💬', style: TextStyle(fontSize: 16)),
                          const SizedBox(width: 6),
                          Text(
                            isBM ? 'Kata-kata Hari Ini' : "Today's Quote",
                            style: theme.textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '"${isBM ? quote.textBM : quote.textEN}"',
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(fontStyle: FontStyle.italic, height: 1.5),
                      ),
                      const SizedBox(height: 6),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          '— ${quote.author}',
                          style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.55)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Simple leaderboard
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  color: theme.colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isBM ? 'Papan Pendahulu' : 'Leaderboard',
                          style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary),
                        ),
                        const SizedBox(height: 12),
                        ...[
                          {'name': isBM ? 'Kamu' : 'You', 'xp': user.xp, 'streak': user.streak, 'rank': 1},
                          {'name': isBM ? 'Aisyah' : 'Aisyah', 'xp': (user.xp + 40), 'streak': user.streak + 2, 'rank': 2},
                          {'name': isBM ? 'Imran' : 'Imran', 'xp': (user.xp + 20), 'streak': user.streak + 1, 'rank': 3},
                        ].map((item) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundColor: theme.colorScheme.primary.withOpacity(0.16),
                                  child: Text(
                                    '${item['rank']}',
                                    style: TextStyle(
                                        color: theme.colorScheme.primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['name'] as String,
                                        style: theme.textTheme.bodyLarge?.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${item['xp']} XP • ${item['streak']} ${isBM ? 'hari streak' : 'day streak'}',
                                        style: theme.textTheme.bodySmall?.copyWith(
                                            color: theme.colorScheme.onSurface.withOpacity(0.65)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildFeatureChip(BuildContext context, String text) {
  final theme = Theme.of(context);
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: theme.colorScheme.primary.withOpacity(0.14),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Text(
      text,
      style: theme.textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.onSurface,
      ),
    ),
  );
}
