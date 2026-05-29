import React, { useEffect, useRef } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, Animated, Dimensions } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { LinearGradient } from 'expo-linear-gradient';
import { Ionicons } from '@expo/vector-icons';
import { useApp } from '../context/AppContext';
import { UNITS } from '../data/courses';
import { C, R, S } from '../theme';

const { width } = Dimensions.get('window');

const QUOTES = [
  { text: 'Perjalanan seribu batu bermula dengan satu langkah.', author: 'Lao Tzu' },
  { text: 'Setiap pakar pernah jadi pemula.', author: 'Helen Hayes' },
  { text: 'Kod hari ini, kejayaan esok hari.', author: 'CODE30' },
  { text: 'Disiplin adalah jambatan antara matlamat dan pencapaian.', author: 'Jim Rohn' },
  { text: 'Terus cuba, terus belajar. Kegagalan adalah guru terbaik.', author: 'CODE30' },
  { text: 'Satu pelajaran sehari lebih baik dari seminggu berturut-turut.', author: 'CODE30' },
  { text: 'Jangan tunggu masa yang sesuai. Mulakan sekarang.', author: 'Napoleon Hill' },
];

function StatCard({ icon, value, label, color, bg }) {
  return (
    <View style={[styles.statCard, { backgroundColor: bg }]}>
      <View style={[styles.statIconWrap, { backgroundColor: color + '20' }]}>
        <Ionicons name={icon} size={18} color={color} />
      </View>
      <Text style={[styles.statValue, { color }]}>{value}</Text>
      <Text style={styles.statLabel}>{label}</Text>
    </View>
  );
}

function ProgressBar({ progress, color = C.primary, height = 10, style }) {
  const anim = useRef(new Animated.Value(0)).current;
  useEffect(() => {
    Animated.timing(anim, { toValue: progress, duration: 800, useNativeDriver: false }).start();
  }, [progress]);
  return (
    <View style={[styles.progressBg, { height }, style]}>
      <Animated.View style={[styles.progressFill, {
        width: anim.interpolate({ inputRange: [0, 1], outputRange: ['0%', '100%'] }),
        backgroundColor: color, height,
      }]} />
    </View>
  );
}

export default function HomeScreen({ navigation }) {
  const { userName, xp, level, hearts, streak, completedLessons, checkNewDay } = useApp();
  useEffect(() => { checkNewDay(); }, []);

  const totalLessons = UNITS.reduce((s, u) => s + u.lessons.length, 0);
  const doneCount = completedLessons.length;
  const xpInLevel = xp % 200;
  const xpPct = xpInLevel / 200;
  const quote = QUOTES[new Date().getDay() % QUOTES.length];
  const greeting = new Date().getHours() < 12 ? 'Selamat Pagi' : new Date().getHours() < 18 ? 'Selamat Petang' : 'Selamat Malam';

  const nextLesson = (() => {
    for (const unit of UNITS)
      for (const lesson of unit.lessons)
        if (!completedLessons.includes(lesson.id)) return { lesson, unit };
    return null;
  })();

  return (
    <SafeAreaView style={styles.safe} edges={['top']}>
      <ScrollView contentContainerStyle={styles.scroll} showsVerticalScrollIndicator={false}>

        {/* ── HERO GRADIENT HEADER ── */}
        <LinearGradient colors={[C.primary, C.primaryDark]} style={styles.hero}>
          <View style={styles.heroTop}>
            <View>
              <Text style={styles.heroGreeting}>{greeting} 👋</Text>
              <Text style={styles.heroName}>{userName || 'Pelajar'}</Text>
            </View>
            <View style={styles.heartsWrap}>
              {Array.from({ length: 5 }).map((_, i) => (
                <Ionicons key={i} name={i < hearts ? 'heart' : 'heart-outline'}
                  size={20} color={i < hearts ? '#FF6B6B' : 'rgba(255,255,255,0.3)'} />
              ))}
            </View>
          </View>

          {/* XP Level Progress */}
          <View style={styles.xpCard}>
            <View style={styles.xpCardRow}>
              <View style={styles.levelBadge}>
                <Ionicons name="flash" size={13} color={C.gold} />
                <Text style={styles.levelText}>Level {level}</Text>
              </View>
              <Text style={styles.xpLabel}>{xpInLevel} / 200 XP</Text>
            </View>
            <ProgressBar progress={xpPct} color={C.gold} height={8} style={{ borderRadius: R.full }} />
            <Text style={styles.xpNext}>{200 - xpInLevel} XP lagi ke Level {level + 1}</Text>
          </View>
        </LinearGradient>

        {/* ── STATS ROW ── */}
        <View style={styles.statsRow}>
          <StatCard icon="flame" value={streak} label="Hari Streak" color="#F97316" bg="#FFF7ED" />
          <StatCard icon="star" value={xp} label="XP" color={C.gold} bg={C.goldLight} />
          <StatCard icon="book" value={doneCount} label="Selesai" color={C.primary} bg={C.primaryBg} />
          <StatCard icon="ribbon" value={`${Math.round((doneCount/Math.max(totalLessons,1))*100)}%`} label="Kemajuan" color={C.violet} bg={C.violetBg} />
        </View>

        {/* ── CONTINUE LEARNING ── */}
        {nextLesson ? (
          <TouchableOpacity
            style={styles.continueWrap}
            onPress={() => navigation.navigate('Lesson', { lessonId: nextLesson.lesson.id })}
            activeOpacity={0.85}
          >
            <LinearGradient colors={[nextLesson.unit.color || C.primary, (nextLesson.unit.color || C.primary) + 'CC']}
              start={{ x: 0, y: 0 }} end={{ x: 1, y: 0 }} style={styles.continueCard}>
              <View style={styles.continueBadge}>
                <Ionicons name="play-circle" size={14} color="#fff" />
                <Text style={styles.continueBadgeText}>TERUSKAN</Text>
              </View>
              <Text style={styles.continueTitle}>{nextLesson.lesson.title}</Text>
              <Text style={styles.continueUnit}>{nextLesson.unit.title}</Text>
              <View style={styles.continueFooter}>
                <View style={styles.xpPill}>
                  <Ionicons name="star" size={12} color={C.gold} />
                  <Text style={styles.xpPillText}>+{nextLesson.lesson.xpReward} XP</Text>
                </View>
                <View style={styles.continueArrow}>
                  <Ionicons name="arrow-forward" size={18} color="#fff" />
                </View>
              </View>
            </LinearGradient>
          </TouchableOpacity>
        ) : (
          <LinearGradient colors={[C.success, '#059669']} style={styles.allDoneCard}>
            <Ionicons name="checkmark-circle" size={36} color="#fff" />
            <Text style={styles.allDoneText}>Tahniah! Semua pelajaran selesai!</Text>
          </LinearGradient>
        )}

        {/* ── UNIT PROGRESS ── */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Kemajuan Topik</Text>
          {UNITS.map(unit => {
            const d = unit.lessons.filter(l => completedLessons.includes(l.id)).length;
            const p = unit.lessons.length > 0 ? d / unit.lessons.length : 0;
            return (
              <View key={unit.id} style={styles.unitRow}>
                <View style={[styles.unitIconBox, { backgroundColor: unit.color + '15' }]}>
                  <Text style={{ fontSize: 20 }}>{unit.emoji}</Text>
                </View>
                <View style={{ flex: 1 }}>
                  <View style={styles.unitRowTop}>
                    <Text style={styles.unitName}>{unit.title}</Text>
                    <Text style={[styles.unitPct, { color: unit.color }]}>{Math.round(p * 100)}%</Text>
                  </View>
                  <ProgressBar progress={p} color={unit.color} height={6} style={{ borderRadius: R.full }} />
                  <Text style={styles.unitCount}>{d}/{unit.lessons.length} pelajaran</Text>
                </View>
              </View>
            );
          })}
        </View>

        {/* ── DAILY QUOTE ── */}
        <View style={styles.quoteCard}>
          <View style={styles.quoteIconWrap}>
            <Ionicons name="chatbubble-ellipses" size={20} color={C.primary} />
          </View>
          <Text style={styles.quoteText}>"{quote.text}"</Text>
          <Text style={styles.quoteAuthor}>— {quote.author}</Text>
        </View>

      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safe: { flex: 1, backgroundColor: C.bg },
  scroll: { paddingBottom: 32 },

  // Hero
  hero: { paddingTop: 16, paddingBottom: 24, paddingHorizontal: 20 },
  heroTop: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: 20 },
  heroGreeting: { fontSize: 14, color: 'rgba(255,255,255,0.75)', fontWeight: '500' },
  heroName: { fontSize: 24, fontWeight: '800', color: '#fff', marginTop: 2 },
  heartsWrap: { flexDirection: 'row', gap: 3, paddingTop: 4 },

  xpCard: { backgroundColor: 'rgba(255,255,255,0.15)', borderRadius: R.md, padding: 14 },
  xpCardRow: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', marginBottom: 10 },
  levelBadge: { flexDirection: 'row', alignItems: 'center', backgroundColor: 'rgba(255,255,255,0.2)', borderRadius: R.full, paddingHorizontal: 10, paddingVertical: 4, gap: 4 },
  levelText: { color: '#fff', fontWeight: '700', fontSize: 13 },
  xpLabel: { color: 'rgba(255,255,255,0.85)', fontSize: 13, fontWeight: '600' },
  progressBg: { backgroundColor: 'rgba(255,255,255,0.2)', borderRadius: R.full, overflow: 'hidden' },
  progressFill: { borderRadius: R.full },
  xpNext: { color: 'rgba(255,255,255,0.6)', fontSize: 11, marginTop: 6, textAlign: 'right' },

  // Stats
  statsRow: { flexDirection: 'row', paddingHorizontal: 16, paddingTop: 16, gap: 10, marginBottom: 4 },
  statCard: { flex: 1, borderRadius: R.md, padding: 12, alignItems: 'center', ...S.xs },
  statIconWrap: { width: 32, height: 32, borderRadius: R.sm, alignItems: 'center', justifyContent: 'center', marginBottom: 6 },
  statValue: { fontSize: 18, fontWeight: '800', lineHeight: 22 },
  statLabel: { fontSize: 10, color: C.textMuted, fontWeight: '600', marginTop: 2 },

  // Continue
  continueWrap: { margin: 16, borderRadius: R.lg, overflow: 'hidden', ...S.md },
  continueCard: { padding: 20 },
  continueBadge: { flexDirection: 'row', alignItems: 'center', gap: 5, backgroundColor: 'rgba(255,255,255,0.2)', alignSelf: 'flex-start', borderRadius: R.full, paddingHorizontal: 10, paddingVertical: 4, marginBottom: 10 },
  continueBadgeText: { color: '#fff', fontSize: 11, fontWeight: '800', letterSpacing: 0.5 },
  continueTitle: { fontSize: 20, fontWeight: '800', color: '#fff', marginBottom: 4 },
  continueUnit: { fontSize: 13, color: 'rgba(255,255,255,0.8)', marginBottom: 14 },
  continueFooter: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center' },
  xpPill: { flexDirection: 'row', alignItems: 'center', gap: 4, backgroundColor: 'rgba(255,255,255,0.2)', borderRadius: R.full, paddingHorizontal: 10, paddingVertical: 5 },
  xpPillText: { color: '#fff', fontWeight: '700', fontSize: 13 },
  continueArrow: { width: 36, height: 36, borderRadius: 18, backgroundColor: 'rgba(255,255,255,0.2)', alignItems: 'center', justifyContent: 'center' },

  allDoneCard: { margin: 16, borderRadius: R.lg, padding: 24, alignItems: 'center', gap: 10, ...S.md },
  allDoneText: { color: '#fff', fontWeight: '700', fontSize: 16, textAlign: 'center' },

  // Unit Progress
  section: { backgroundColor: C.surface, marginHorizontal: 16, borderRadius: R.lg, padding: 16, marginBottom: 14, ...S.sm },
  sectionTitle: { fontSize: 15, fontWeight: '700', color: C.text, marginBottom: 14 },
  unitRow: { flexDirection: 'row', alignItems: 'center', gap: 12, marginBottom: 14 },
  unitIconBox: { width: 44, height: 44, borderRadius: R.sm, alignItems: 'center', justifyContent: 'center' },
  unitRowTop: { flexDirection: 'row', justifyContent: 'space-between', marginBottom: 6 },
  unitName: { fontSize: 13, fontWeight: '600', color: C.text },
  unitPct: { fontSize: 13, fontWeight: '700' },
  unitCount: { fontSize: 11, color: C.textMuted, marginTop: 4 },

  // Quote
  quoteCard: { backgroundColor: C.surface, marginHorizontal: 16, borderRadius: R.lg, padding: 18, ...S.sm, borderLeftWidth: 4, borderLeftColor: C.primary },
  quoteIconWrap: { marginBottom: 10 },
  quoteText: { fontSize: 14, color: C.textSub, lineHeight: 22, fontStyle: 'italic', marginBottom: 8 },
  quoteAuthor: { fontSize: 12, color: C.textMuted, textAlign: 'right', fontWeight: '600' },
});
