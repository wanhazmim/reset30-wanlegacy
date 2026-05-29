import React, { useEffect } from 'react';
import {
  View, Text, StyleSheet, ScrollView,
  TouchableOpacity, RefreshControl,
} from 'react-native';
import { useApp } from '../context/AppContext';
import { UNITS } from '../data/courses';

const QUOTES = [
  'Perjalanan seribu batu bermula dengan satu langkah.',
  'Setiap pakar pernah jadi pemula.',
  'Kod hari ini, kejayaan esok.',
  'Terus cuba, terus belajar!',
  'Jangan takut gagal. Takutlah tidak mencuba.',
];

export default function HomeScreen({ navigation }) {
  const { userName, xp, level, hearts, streak, completedLessons, checkNewDay } = useApp();

  useEffect(() => {
    checkNewDay();
  }, []);

  const totalLessons = UNITS.reduce((acc, u) => acc + u.lessons.length, 0);
  const doneCount = completedLessons.length;
  const progress = totalLessons > 0 ? doneCount / totalLessons : 0;
  const quote = QUOTES[new Date().getDay() % QUOTES.length];

  const nextLesson = (() => {
    for (const unit of UNITS) {
      for (const lesson of unit.lessons) {
        if (!completedLessons.includes(lesson.id)) return { lesson, unit };
      }
    }
    return null;
  })();

  const xpInLevel = xp % 200;
  const xpProgress = xpInLevel / 200;

  return (
    <ScrollView style={styles.root} contentContainerStyle={styles.content} showsVerticalScrollIndicator={false}>
      {/* Header */}
      <View style={styles.header}>
        <View>
          <Text style={styles.greeting}>Helo, {userName || 'Pelajar'} 👋</Text>
          <Text style={styles.subGreeting}>Teruskan semangat belajarmu!</Text>
        </View>
        <View style={styles.heartsWrap}>
          {Array.from({ length: 5 }).map((_, i) => (
            <Text key={i} style={{ fontSize: 18, opacity: i < hearts ? 1 : 0.25 }}>❤️</Text>
          ))}
        </View>
      </View>

      {/* Streak & XP */}
      <View style={styles.statsRow}>
        <View style={[styles.statCard, { backgroundColor: '#FFF7ED', borderColor: '#FED7AA' }]}>
          <Text style={styles.statEmoji}>🔥</Text>
          <Text style={[styles.statNum, { color: '#F59E0B' }]}>{streak}</Text>
          <Text style={styles.statLabel}>Hari</Text>
        </View>
        <View style={[styles.statCard, { backgroundColor: '#ECFDF5', borderColor: '#A7F3D0' }]}>
          <Text style={styles.statEmoji}>⭐</Text>
          <Text style={[styles.statNum, { color: '#059669' }]}>{xp}</Text>
          <Text style={styles.statLabel}>XP</Text>
        </View>
        <View style={[styles.statCard, { backgroundColor: '#EEF2FF', borderColor: '#C7D2FE' }]}>
          <Text style={styles.statEmoji}>🎖️</Text>
          <Text style={[styles.statNum, { color: '#6366F1' }]}>{level}</Text>
          <Text style={styles.statLabel}>Level</Text>
        </View>
      </View>

      {/* XP Bar */}
      <View style={styles.card}>
        <View style={styles.xpHeader}>
          <Text style={styles.cardTitle}>📈 Kemajuan Level {level}</Text>
          <Text style={styles.xpLabel}>{xpInLevel}/200 XP</Text>
        </View>
        <View style={styles.barBg}>
          <View style={[styles.barFill, { width: `${Math.min(xpProgress * 100, 100)}%` }]} />
        </View>
        <Text style={styles.xpNext}>Level {level + 1} dalam {200 - xpInLevel} XP lagi</Text>
      </View>

      {/* Progress */}
      <View style={styles.card}>
        <Text style={styles.cardTitle}>📚 Kemajuan Pelajaran</Text>
        <View style={styles.barBg}>
          <View style={[styles.barFill, { width: `${Math.min(progress * 100, 100)}%`, backgroundColor: '#059669' }]} />
        </View>
        <Text style={styles.progressLabel}>{doneCount} / {totalLessons} pelajaran selesai</Text>
      </View>

      {/* Continue */}
      {nextLesson ? (
        <View style={styles.card}>
          <Text style={styles.cardTitle}>▶️ Teruskan Belajar</Text>
          <TouchableOpacity
            style={styles.continueBtn}
            onPress={() => navigation.navigate('Lesson', { lessonId: nextLesson.lesson.id })}
          >
            <View style={styles.continueBtnInner}>
              <Text style={styles.continueLessonEmoji}>{nextLesson.lesson.emoji}</Text>
              <View style={{ flex: 1 }}>
                <Text style={styles.continueLessonTitle}>{nextLesson.lesson.title}</Text>
                <Text style={styles.continueLessonUnit}>{nextLesson.unit.title}</Text>
              </View>
              <View style={styles.xpBadge}>
                <Text style={styles.xpBadgeText}>+{nextLesson.lesson.xpReward} XP</Text>
              </View>
            </View>
          </TouchableOpacity>
        </View>
      ) : (
        <View style={[styles.card, { backgroundColor: '#ECFDF5' }]}>
          <Text style={{ fontSize: 32, textAlign: 'center' }}>🎉</Text>
          <Text style={styles.allDone}>Tahniah! Semua pelajaran selesai!</Text>
        </View>
      )}

      {/* Quote */}
      <View style={[styles.card, { backgroundColor: '#0D9488' }]}>
        <Text style={styles.quoteEmoji}>💬</Text>
        <Text style={styles.quoteText}>"{quote}"</Text>
      </View>

      {/* Quick Actions */}
      <Text style={styles.sectionTitle}>Aksi Cepat</Text>
      <View style={styles.quickRow}>
        <TouchableOpacity style={styles.quickCard} onPress={() => navigation.navigate('Learn')}>
          <Text style={styles.quickEmoji}>📖</Text>
          <Text style={styles.quickLabel}>Belajar</Text>
        </TouchableOpacity>
        <TouchableOpacity style={styles.quickCard} onPress={() => navigation.navigate('Leaderboard')}>
          <Text style={styles.quickEmoji}>🏆</Text>
          <Text style={styles.quickLabel}>Ranking</Text>
        </TouchableOpacity>
        <TouchableOpacity style={styles.quickCard} onPress={() => navigation.navigate('Profile')}>
          <Text style={styles.quickEmoji}>👤</Text>
          <Text style={styles.quickLabel}>Profil</Text>
        </TouchableOpacity>
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  root: { flex: 1, backgroundColor: '#F9FAFB' },
  content: { paddingHorizontal: 16, paddingBottom: 40, paddingTop: 56 },
  header: {
    flexDirection: 'row', justifyContent: 'space-between', alignItems: 'flex-start',
    marginBottom: 20,
  },
  greeting: { fontSize: 22, fontWeight: 'bold', color: '#111827' },
  subGreeting: { fontSize: 14, color: '#6B7280', marginTop: 2 },
  heartsWrap: { flexDirection: 'row', flexWrap: 'wrap', maxWidth: 90 },
  statsRow: { flexDirection: 'row', gap: 10, marginBottom: 16 },
  statCard: {
    flex: 1, borderRadius: 14, padding: 12, alignItems: 'center',
    borderWidth: 1,
  },
  statEmoji: { fontSize: 22, marginBottom: 4 },
  statNum: { fontSize: 22, fontWeight: 'bold' },
  statLabel: { fontSize: 11, color: '#6B7280', marginTop: 2 },
  card: {
    backgroundColor: '#fff', borderRadius: 16, padding: 16,
    marginBottom: 14, elevation: 2,
    shadowColor: '#000', shadowOpacity: 0.05, shadowRadius: 6,
    shadowOffset: { width: 0, height: 2 },
  },
  cardTitle: { fontSize: 15, fontWeight: '700', color: '#111827', marginBottom: 10 },
  xpHeader: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', marginBottom: 10 },
  xpLabel: { fontSize: 13, color: '#6B7280', fontWeight: '600' },
  barBg: { backgroundColor: '#E5E7EB', borderRadius: 8, height: 10, overflow: 'hidden', marginBottom: 6 },
  barFill: { backgroundColor: '#0D9488', height: '100%', borderRadius: 8 },
  xpNext: { fontSize: 12, color: '#9CA3AF', textAlign: 'right' },
  progressLabel: { fontSize: 12, color: '#9CA3AF', textAlign: 'right', marginTop: 4 },
  continueBtn: {
    backgroundColor: '#F0FDF4', borderRadius: 12, overflow: 'hidden',
  },
  continueBtnInner: {
    flexDirection: 'row', alignItems: 'center', padding: 12,
    borderLeftWidth: 4, borderLeftColor: '#059669',
  },
  continueLessonEmoji: { fontSize: 28, marginRight: 12 },
  continueLessonTitle: { fontSize: 15, fontWeight: '700', color: '#111827' },
  continueLessonUnit: { fontSize: 12, color: '#6B7280', marginTop: 2 },
  xpBadge: {
    backgroundColor: '#059669', borderRadius: 8,
    paddingHorizontal: 8, paddingVertical: 4,
  },
  xpBadgeText: { color: '#fff', fontWeight: 'bold', fontSize: 12 },
  allDone: { textAlign: 'center', fontSize: 16, fontWeight: '600', color: '#059669', marginTop: 8 },
  quoteEmoji: { fontSize: 20, marginBottom: 8 },
  quoteText: { fontSize: 15, color: '#fff', fontStyle: 'italic', lineHeight: 22 },
  sectionTitle: { fontSize: 16, fontWeight: '700', color: '#374151', marginBottom: 12 },
  quickRow: { flexDirection: 'row', gap: 12, marginBottom: 20 },
  quickCard: {
    flex: 1, backgroundColor: '#fff', borderRadius: 14, padding: 16,
    alignItems: 'center', elevation: 2,
    shadowColor: '#000', shadowOpacity: 0.05, shadowRadius: 4,
    shadowOffset: { width: 0, height: 2 },
  },
  quickEmoji: { fontSize: 28, marginBottom: 6 },
  quickLabel: { fontSize: 12, fontWeight: '600', color: '#374151' },
});
