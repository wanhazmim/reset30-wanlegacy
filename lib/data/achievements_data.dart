class Achievement {
  final String id;
  final String titleBM;
  final String titleEN;
  final String emoji;
  final String descBM;
  final String descEN;

  const Achievement({
    required this.id,
    required this.titleBM,
    required this.titleEN,
    required this.emoji,
    required this.descBM,
    required this.descEN,
  });
}

const List<Achievement> allAchievements = [
  Achievement(
    id: 'first_lesson',
    emoji: '🎉',
    titleBM: 'Permulaan!',
    titleEN: 'First Step!',
    descBM: 'Tahniah! Anda telah menyelesaikan pelajaran pertama anda.',
    descEN: 'Congratulations! You completed your first lesson.',
  ),
  Achievement(
    id: 'streak_3',
    emoji: '🔥',
    titleBM: '3 Hari Berturut!',
    titleEN: '3-Day Streak!',
    descBM: 'Anda belajar selama 3 hari berturut-turut. Teruskan!',
    descEN: 'You learned for 3 consecutive days. Keep it up!',
  ),
  Achievement(
    id: 'streak_7',
    emoji: '⚡',
    titleBM: 'Seminggu Penuh!',
    titleEN: 'Full Week!',
    descBM: 'Anda belajar setiap hari selama seminggu. Luar biasa!',
    descEN: 'You learned every day for a full week. Incredible!',
  ),
  Achievement(
    id: 'streak_14',
    emoji: '🌟',
    titleBM: 'Dua Minggu Kuat!',
    titleEN: 'Two-Week Strong!',
    descBM: 'Anda telah konsisten selama 14 hari. Menakjubkan!',
    descEN: 'You have been consistent for 14 days. Amazing!',
  ),
  Achievement(
    id: 'streak_30',
    emoji: '👑',
    titleBM: 'Juara CODE30!',
    titleEN: 'CODE30 Champion!',
    descBM: 'Anda belajar setiap hari selama 30 hari penuh. Luar biasa!',
    descEN: 'You learned every single day for 30 full days. Outstanding!',
  ),
  Achievement(
    id: 'lessons_5',
    emoji: '📚',
    titleBM: 'Pelajar Rajin',
    titleEN: 'Eager Learner',
    descBM: 'Anda telah menyelesaikan 5 pelajaran. Teruskan belajar!',
    descEN: 'You have completed 5 lessons. Keep learning!',
  ),
  Achievement(
    id: 'lessons_10',
    emoji: '🎓',
    titleBM: 'Pelajar Tekun',
    titleEN: 'Dedicated Learner',
    descBM: 'Anda telah menyelesaikan 10 pelajaran. Tahniah!',
    descEN: 'You have completed 10 lessons. Congratulations!',
  ),
  Achievement(
    id: 'lessons_all',
    emoji: '🏅',
    titleBM: 'Juruteknik CODE30',
    titleEN: 'CODE30 Technician',
    descBM: 'Anda telah menyelesaikan semua pelajaran dalam CODE30!',
    descEN: 'You have completed all lessons in CODE30!',
  ),
  Achievement(
    id: 'level_5',
    emoji: '⭐',
    titleBM: 'Pakar Separuh Jalan',
    titleEN: 'Halfway Expert',
    descBM: 'Anda telah mencapai Aras 5. Separuh lagi untuk puncak!',
    descEN: 'You have reached Level 5. Halfway to the top!',
  ),
  Achievement(
    id: 'xp_500',
    emoji: '💎',
    titleBM: '500 XP Terkumpul!',
    titleEN: '500 XP Collected!',
    descBM: 'Anda telah mengumpul 500 mata XP. Teruskan momentum!',
    descEN: 'You have collected 500 XP points. Keep the momentum!',
  ),
];
