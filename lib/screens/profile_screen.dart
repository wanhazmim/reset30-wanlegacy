import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/user_provider.dart';
import '../data/achievements_data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        final user = userProvider.user;
        final isBM = user.language == 'bm';
        final theme = Theme.of(context);
        final level = userProvider.getLevel();
        final levelProgress = userProvider.levelProgress();
        final xpToNext = userProvider.xpToNextLevel();

        // Avatar color from name
        final avatarColors = [
          Colors.teal,
          Colors.indigo,
          Colors.orange,
          Colors.purple,
          Colors.green,
          Colors.pink,
        ];
        final avatarColor =
            avatarColors[user.name.isEmpty ? 0 : user.name.codeUnitAt(0) % avatarColors.length];
        final avatarLetter =
            user.name.isEmpty ? 'C' : user.name[0].toUpperCase();

        final last30 = userProvider.getLast30DaysXP();
        final maxXp = last30.isEmpty
            ? 1
            : last30.map((e) => e.value).reduce((a, b) => a > b ? a : b);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              isBM ? 'Profil' : 'Profile',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Avatar + name
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 44,
                      backgroundColor: avatarColor,
                      child: Text(
                        avatarLetter,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      user.name.isEmpty ? 'Coder' : user.name,
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isBM ? 'Aras $level' : 'Level $level',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // XP Progress to next level
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isBM ? 'Kemajuan Aras' : 'Level Progress',
                            style: theme.textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          if (level < 10)
                            Text(
                              isBM
                                  ? '$xpToNext XP lagi ke Aras ${level + 1}'
                                  : '$xpToNext XP to Level ${level + 1}',
                              style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.primary),
                            )
                          else
                            Text(
                              isBM ? 'Aras Maksimum! 👑' : 'Max Level! 👑',
                              style: theme.textTheme.labelSmall?.copyWith(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: levelProgress,
                          minHeight: 14,
                          backgroundColor: theme.colorScheme.surfaceVariant,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              theme.colorScheme.primary),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${user.xp} XP ${isBM ? "terkumpul" : "total"}',
                        style: theme.textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Stats
              Row(
                children: [
                  Expanded(
                    child: _StatTile(
                      emoji: '⭐',
                      value: '${user.xp}',
                      label: isBM ? 'Jumlah XP' : 'Total XP',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _StatTile(
                      emoji: '📚',
                      value: '${user.completedLessons.length}',
                      label: isBM ? 'Pelajaran Selesai' : 'Lessons Done',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _StatTile(
                      emoji: '🔥',
                      value: '${user.streak}',
                      label: isBM ? 'Streak Terbaik' : 'Current Streak',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _StatTile(
                      emoji: '📅',
                      value: '${userProvider.getTotalActiveDays()}',
                      label: isBM ? 'Hari Aktif' : 'Active Days',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 30-day chart
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isBM ? 'XP 30 Hari Lepas' : 'Last 30 Days XP',
                        style: theme.textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 140,
                        child: LineChart(
                          LineChartData(
                            gridData: const FlGridData(show: false),
                            borderData: FlBorderData(show: false),
                            titlesData: FlTitlesData(
                              leftTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 5,
                                  getTitlesWidget: (value, meta) {
                                    if (value % 5 == 0) {
                                      return Text(
                                        '${value.toInt()}',
                                        style: const TextStyle(fontSize: 9),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),
                              ),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: List.generate(
                                  last30.length,
                                  (i) => FlSpot(
                                    i.toDouble(),
                                    last30[i].value.toDouble(),
                                  ),
                                ),
                                isCurved: true,
                                color: theme.colorScheme.primary,
                                barWidth: 3,
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: theme.colorScheme.primary
                                      .withOpacity(0.12),
                                ),
                                dotData: const FlDotData(show: false),
                              ),
                            ],
                            minY: 0,
                            maxY: maxXp > 0 ? maxXp.toDouble() + 10 : 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Achievements
              Text(
                isBM ? 'Pencapaian' : 'Achievements',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.85,
                children: allAchievements.map((ach) {
                  final unlocked =
                      user.unlockedAchievements.contains(ach.id);
                  return _AchievementTile(
                    achievement: ach,
                    unlocked: unlocked,
                    isBM: isBM,
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

class _StatTile extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;

  const _StatTile(
      {required this.emoji, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 4),
          Text(value,
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          Text(label,
              style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6))),
        ],
      ),
    );
  }
}

class _AchievementTile extends StatelessWidget {
  final Achievement achievement;
  final bool unlocked;
  final bool isBM;

  const _AchievementTile({
    required this.achievement,
    required this.unlocked,
    required this.isBM,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Tooltip(
      message: isBM ? achievement.descBM : achievement.descEN,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: unlocked
              ? Colors.amber.withOpacity(0.15)
              : theme.colorScheme.surfaceVariant.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: unlocked
                ? Colors.amber.withOpacity(0.6)
                : theme.colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorFiltered(
              colorFilter: unlocked
                  ? const ColorFilter.mode(
                      Colors.transparent, BlendMode.saturation)
                  : const ColorFilter.matrix([
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0, 0, 0, 0.4, 0,
                    ]),
              child: Text(
                achievement.emoji,
                style: const TextStyle(fontSize: 28),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              isBM ? achievement.titleBM : achievement.titleEN,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight:
                    unlocked ? FontWeight.bold : FontWeight.normal,
                color: unlocked
                    ? theme.colorScheme.onSurface
                    : theme.colorScheme.onSurface.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
