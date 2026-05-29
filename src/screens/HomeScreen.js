import React, { useEffect } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useApp } from '../context/AppContext';
import { UNITS } from '../data/courses';

const QUOTES = [
  { text: 'Perjalanan seribu batu bermula dengan satu langkah.', author: 'Lao Tzu' },
  { text: 'Setiap pakar pernah jadi pemula.', author: 'Helen Hayes' },
  { text: 'Kod hari ini, kejayaan esok hari.', author: 'CODE30' },
  { text: 'Jangan tunggu masa yang sesuai. Mulakan sekarang.', author: 'Napoleon Hill' },
  { text: 'Disiplin adalah jambatan antara matlamat dan pencapaian.', author: 'Jim Rohn' },
  { text: 'Terus cuba, terus belajar. Kegagalan adalah guru terbaik.', author: 'CODE30' },
  { text: 'Satu pelajaran sehari jauh lebih baik dari satu minggu berturut-turut.', author: 'CODE30' },
];

export default function HomeScreen({ navigation }) {
  const { userName, xp, level, hearts, streak, completedLessons, checkNewDay } = useApp();
  useEffect(() => { checkNewDay(); }, []);

  const totalLessons = UNITS.reduce((s, u) => s + u.lessons.length, 0);
  const doneCount = completedLessons.length;
  const overallPct = totalLessons > 0 ? Math.round((doneCount / totalLessons) * 100) : 0;
  const xpInLevel = xp % 200;
  const quote = QUOTES[new Date().getDay() % QUOTES.length];
  const nextLesson = (() => {
    for (const unit of UNITS) for (const lesson of unit.lessons)
      if (!completedLessons.includes(lesson.id)) return { lesson, unit };
    return null;
  })();
  const greeting = new Date().getHours() < 12 ? 'Selamat Pagi' : new Date().getHours() < 18 ? 'Selamat Petang' : 'Selamat Malam';

  return (
    <SafeAreaView style={styles.safe} edges={['top']}>
      <ScrollView contentContainerStyle={styles.content} showsVerticalScrollIndicator={false}>
        <View style={styles.headerRow}>
          <View style={{ flex: 1 }}>
            <Text style={styles.greeting}>{greeting}, {userName || 'Pelajar'} 👋</Text>
            <Text style={styles.greetingSub}>Jom teruskan pembelajaran hari ini!</Text>
          </View>
          <View style={styles.heartsRow}>
            {Array.from({ length: 5 }).map((_, i) => (
              <Text key={i} style={{ fontSize: 16, opacity: i < hearts ? 1 : 0.2 }}>❤️</Text>
            ))}
          </View>
        </View>

        <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 16 }}>
          {[
            { emoji: '🔥', value: String(streak), label: 'Hari Streak', bg: '#FFF7ED', color: '#F59E0B' },
            { emoji: '⭐', value: String(xp), label: 'XP Terkumpul', bg: '#ECFDF5', color: '#059669' },
            { emoji: '🎖️', value: `Lvl ${level}`, label: 'Level', bg: '#EEF2FF', color: '#6366F1' },
            { emoji: '📖', value: `${doneCount}/${totalLessons}`, label: 'Pelajaran', bg: '#FFF1F2', color: '#E11D48' },
          ].map((s, i) => (
            <View key={i} style={[styles.statPill, { backgroundColor: s.bg }]}>
              <Text style={{ fontSize: 22, marginBottom: 4 }}>{s.emoji}</Text>
              <Text style={[styles.statValue, { color: s.color }]}>{s.value}</Text>
              <Text style={styles.statLabel}>{s.label}</Text>
            </View>
          ))}
        </ScrollView>

        <View style={styles.card}>
          <View style={styles.cardRow}>
            <Text style={styles.cardTitle}>🚀 Level {level}</Text>
            <Text style={styles.cardBadge}>{xpInLevel}/200 XP</Text>
          </View>
          <View style={styles.bar}><View style={[styles.barFill, { width: `${(xpInLevel / 200) * 100}%` }]} /></View>
          <Text style={styles.barNote}>{200 - xpInLevel} XP lagi untuk Level {level + 1}</Text>
        </View>

        <View style={styles.card}>
          <View style={styles.cardRow}>
            <Text style={styles.cardTitle}>📊 Kemajuan Keseluruhan</Text>
            <Text style={[styles.cardBadge, { color: '#059669', backgroundColor: '#ECFDF5' }]}>{overallPct}%</Text>
          </View>
          <View style={styles.bar}><View style={[styles.barFill, { width: `${overallPct}%`, backgroundColor: '#059669' }]} /></View>
          <View style={{ gap: 6, marginTop: 8 }}>
            {UNITS.map(unit => {
              const d = unit.lessons.filter(l => completedLessons.includes(l.id)).length;
              const p = unit.lessons.length > 0 ? (d / unit.lessons.length) * 100 : 0;
              return (
                <View key={unit.id} style={{ flexDirection: 'row', alignItems: 'center', gap: 8 }}>
                  <Text style={{ fontSize: 16, width: 22 }}>{unit.emoji}</Text>
                  <View style={{ flex: 1, height: 5, backgroundColor: '#F3F4F6', borderRadius: 3, overflow: 'hidden' }}>
                    <View style={{ height: '100%', width: `${p}%`, backgroundColor: unit.color, borderRadius: 3 }} />
                  </View>
                  <Text style={{ fontSize: 11, fontWeight: '600', color: '#6B7280', width: 32, textAlign: 'right' }}>{Math.round(p)}%</Text>
                </View>
              );
            })}
          </View>
        </View>

        {nextLesson ? (
          <View style={styles.card}>
            <Text style={styles.cardTitle}>▶️ Teruskan Belajar</Text>
            <TouchableOpacity
              style={[styles.continueCard, { borderLeftColor: nextLesson.unit.color }]}
              onPress={() => navigation.navigate('Lesson', { lessonId: nextLesson.lesson.id })}
              activeOpacity={0.8}
            >
              <Text style={{ fontSize: 30, marginRight: 12 }}>{nextLesson.lesson.emoji}</Text>
              <View style={{ flex: 1 }}>
                <Text style={{ fontSize: 15, fontWeight: '700', color: '#111827' }}>{nextLesson.lesson.title}</Text>
                <Text style={{ fontSize: 12, color: '#6B7280', marginTop: 2 }}>{nextLesson.unit.title}</Text>
              </View>
              <View style={[styles.xpPill, { backgroundColor: nextLesson.unit.color }]}>
                <Text style={{ color: '#fff', fontWeight: 'bold', fontSize: 12 }}>+{nextLesson.lesson.xpReward} XP</Text>
              </View>
            </TouchableOpacity>
          </View>
        ) : (
          <View style={[styles.card, { backgroundColor: '#ECFDF5', alignItems: 'center' }]}>
            <Text style={{ fontSize: 40, marginBottom: 8 }}>🎉</Text>
            <Text style={{ fontSize: 16, fontWeight: 'bold', color: '#059669' }}>Tahniah! Semua pelajaran selesai!</Text>
          </View>
        )}

        <View style={styles.quoteCard}>
          <Text style={{ fontSize: 20, marginBottom: 8 }}>💬</Text>
          <Text style={{ fontSize: 15, color: '#fff', fontStyle: 'italic', lineHeight: 22, marginBottom: 6 }}>"{quote.text}"</Text>
          <Text style={{ fontSize: 12, color: 'rgba(255,255,255,0.7)', textAlign: 'right' }}>— {quote.author}</Text>
        </View>

        <Text style={styles.sectionTitle}>Aksi Pantas</Text>
        <View style={{ flexDirection: 'row', gap: 10 }}>
          {[
            { icon: '📖', label: 'Mulakan\nPelajaran', screen: 'Learn', bg: '#F0FDFA' },
            { icon: '🏆', label: 'Papan\nRanking', screen: 'Leaderboard', bg: '#FFFBEB' },
            { icon: '👤', label: 'Profil\nSaya', screen: 'Profile', bg: '#EEF2FF' },
          ].map(item => (
            <TouchableOpacity key={item.screen} style={[styles.quickCard, { backgroundColor: item.bg }]}
              onPress={() => navigation.navigate(item.screen)} activeOpacity={0.75}>
              <Text style={{ fontSize: 28, marginBottom: 6 }}>{item.icon}</Text>
              <Text style={{ fontSize: 11, fontWeight: '600', color: '#374151', textAlign: 'center' }}>{item.label}</Text>
            </TouchableOpacity>
          ))}
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safe: { flex: 1, backgroundColor: '#F9FAFB' },
  content: { padding: 16, paddingBottom: 32 },
  headerRow: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: 16 },
  greeting: { fontSize: 20, fontWeight: 'bold', color: '#111827' },
  greetingSub: { fontSize: 13, color: '#6B7280', marginTop: 3 },
  heartsRow: { flexDirection: 'row', gap: 2 },
  statPill: { borderRadius: 16, paddingHorizontal: 14, paddingVertical: 12, marginRight: 10, alignItems: 'center', minWidth: 82 },
  statValue: { fontSize: 18, fontWeight: 'bold' },
  statLabel: { fontSize: 10, color: '#9CA3AF', marginTop: 2, fontWeight: '600' },
  card: { backgroundColor: '#fff', borderRadius: 18, padding: 16, marginBottom: 14, elevation: 3, shadowColor: '#000', shadowOpacity: 0.06, shadowRadius: 8, shadowOffset: { width: 0, height: 3 } },
  cardRow: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', marginBottom: 12 },
  cardTitle: { fontSize: 15, fontWeight: '700', color: '#111827' },
  cardBadge: { fontSize: 12, fontWeight: '700', color: '#0D9488', backgroundColor: '#F0FDFA', paddingHorizontal: 8, paddingVertical: 3, borderRadius: 8 },
  bar: { height: 10, backgroundColor: '#F3F4F6', borderRadius: 5, overflow: 'hidden', marginBottom: 8 },
  barFill: { height: '100%', backgroundColor: '#0D9488', borderRadius: 5 },
  barNote: { fontSize: 12, color: '#9CA3AF', textAlign: 'right' },
  continueCard: { backgroundColor: '#F9FAFB', borderRadius: 12, padding: 14, flexDirection: 'row', alignItems: 'center', borderLeftWidth: 4 },
  xpPill: { borderRadius: 10, paddingHorizontal: 10, paddingVertical: 5 },
  quoteCard: { backgroundColor: '#0D9488', borderRadius: 18, padding: 20, marginBottom: 16 },
  sectionTitle: { fontSize: 15, fontWeight: '700', color: '#111827', marginBottom: 10 },
  quickCard: { flex: 1, borderRadius: 16, padding: 14, alignItems: 'center', elevation: 2, shadowColor: '#000', shadowOpacity: 0.04, shadowRadius: 6, shadowOffset: { width: 0, height: 2 } },
});
