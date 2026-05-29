import React from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, Alert } from 'react-native';
import { useApp } from '../context/AppContext';
import { UNITS } from '../data/courses';

const ACHIEVEMENTS = [
  { id: 'first', emoji: '🎯', title: 'Langkah Pertama', desc: 'Selesaikan 1 pelajaran', req: 1 },
  { id: 'five', emoji: '⭐', title: 'Bintang Muda', desc: 'Selesaikan 5 pelajaran', req: 5 },
  { id: 'ten', emoji: '🔥', title: 'Pelajar Setia', desc: 'Selesaikan 10 pelajaran', req: 10 },
  { id: 'all', emoji: '🏆', title: 'Juara Kod', desc: 'Selesaikan semua pelajaran', req: 99 },
  { id: 'streak3', emoji: '💪', title: 'Konsisten', desc: '3 hari streak', req: 3, type: 'streak' },
  { id: 'streak7', emoji: '🌟', title: 'Disiplin', desc: '7 hari streak', req: 7, type: 'streak' },
];

export default function ProfileScreen({ navigation }) {
  const { userName, xp, level, streak, hearts, completedLessons, resetProgress } = useApp();

  const totalLessons = UNITS.reduce((acc, u) => acc + u.lessons.length, 0);
  const doneCount = completedLessons.length;
  const xpInLevel = xp % 200;

  const initial = (userName || 'P').charAt(0).toUpperCase();

  const handleReset = () => {
    Alert.alert(
      'Reset Kemajuan',
      'Adakah kamu pasti mahu reset semua kemajuan? Ini tidak boleh dibatalkan.',
      [
        { text: 'Batal', style: 'cancel' },
        {
          text: 'Reset', style: 'destructive',
          onPress: () => {
            resetProgress();
          },
        },
      ]
    );
  };

  return (
    <ScrollView style={styles.root} contentContainerStyle={styles.content} showsVerticalScrollIndicator={false}>
      {/* Profile Header */}
      <View style={styles.header}>
        <View style={styles.avatar}>
          <Text style={styles.avatarText}>{initial}</Text>
        </View>
        <Text style={styles.name}>{userName || 'Pelajar'}</Text>
        <View style={styles.levelBadge}>
          <Text style={styles.levelBadgeText}>Level {level} • Pelajar Kod</Text>
        </View>
      </View>

      {/* XP Bar */}
      <View style={styles.xpCard}>
        <View style={styles.xpRow}>
          <Text style={styles.xpAmount}>⭐ {xp} XP</Text>
          <Text style={styles.xpNext}>{xpInLevel}/200 XP ke Level {level + 1}</Text>
        </View>
        <View style={styles.barBg}>
          <View style={[styles.barFill, { width: `${Math.min((xpInLevel / 200) * 100, 100)}%` }]} />
        </View>
      </View>

      {/* Stats */}
      <View style={styles.statsRow}>
        <View style={styles.statItem}>
          <Text style={styles.statNum}>{doneCount}</Text>
          <Text style={styles.statLabel}>Pelajaran Selesai</Text>
        </View>
        <View style={styles.statDivider} />
        <View style={styles.statItem}>
          <Text style={styles.statNum}>{streak} 🔥</Text>
          <Text style={styles.statLabel}>Hari Streak</Text>
        </View>
        <View style={styles.statDivider} />
        <View style={styles.statItem}>
          <Text style={styles.statNum}>{hearts} ❤️</Text>
          <Text style={styles.statLabel}>Nyawa</Text>
        </View>
      </View>

      {/* Achievements */}
      <Text style={styles.sectionTitle}>🏅 Pencapaian</Text>
      <View style={styles.achievementsGrid}>
        {ACHIEVEMENTS.map(ach => {
          const earned = ach.type === 'streak'
            ? streak >= ach.req
            : (ach.req === 99 ? doneCount >= totalLessons : doneCount >= ach.req);
          return (
            <View key={ach.id} style={[styles.achCard, !earned && styles.achLocked]}>
              <Text style={[styles.achEmoji, !earned && { opacity: 0.3 }]}>{ach.emoji}</Text>
              <Text style={[styles.achTitle, !earned && styles.achLockedText]}>{ach.title}</Text>
              <Text style={styles.achDesc}>{ach.desc}</Text>
              {earned && <View style={styles.achBadge}><Text style={styles.achBadgeText}>✓</Text></View>}
            </View>
          );
        })}
      </View>

      {/* Progress by Unit */}
      <Text style={styles.sectionTitle}>📊 Kemajuan Mengikut Topik</Text>
      {UNITS.map(unit => {
        const done = unit.lessons.filter(l => completedLessons.includes(l.id)).length;
        const pct = unit.lessons.length > 0 ? (done / unit.lessons.length) * 100 : 0;
        return (
          <View key={unit.id} style={styles.unitProgress}>
            <View style={styles.unitProgressRow}>
              <Text style={styles.unitEmoji}>{unit.emoji}</Text>
              <Text style={styles.unitTitle}>{unit.title}</Text>
              <Text style={[styles.unitPct, { color: unit.color }]}>{Math.round(pct)}%</Text>
            </View>
            <View style={styles.unitBar}>
              <View style={[styles.unitBarFill, { width: `${pct}%`, backgroundColor: unit.color }]} />
            </View>
            <Text style={styles.unitCount}>{done} / {unit.lessons.length} pelajaran</Text>
          </View>
        );
      })}

      {/* Reset */}
      <TouchableOpacity style={styles.resetBtn} onPress={handleReset}>
        <Text style={styles.resetBtnText}>🔄 Reset Kemajuan</Text>
      </TouchableOpacity>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  root: { flex: 1, backgroundColor: '#F9FAFB' },
  content: { paddingBottom: 50 },
  header: {
    backgroundColor: '#0D9488', paddingTop: 52, paddingBottom: 30,
    alignItems: 'center',
  },
  avatar: {
    width: 84, height: 84, borderRadius: 42,
    backgroundColor: 'rgba(255,255,255,0.25)',
    alignItems: 'center', justifyContent: 'center', marginBottom: 12,
  },
  avatarText: { fontSize: 36, fontWeight: 'bold', color: '#fff' },
  name: { fontSize: 22, fontWeight: 'bold', color: '#fff', marginBottom: 6 },
  levelBadge: {
    backgroundColor: 'rgba(255,255,255,0.2)', borderRadius: 20,
    paddingHorizontal: 14, paddingVertical: 4,
  },
  levelBadgeText: { color: '#fff', fontWeight: '600', fontSize: 13 },
  xpCard: {
    backgroundColor: '#fff', margin: 16, borderRadius: 16, padding: 16,
    elevation: 2, shadowColor: '#000', shadowOpacity: 0.05, shadowRadius: 6,
    shadowOffset: { width: 0, height: 2 },
  },
  xpRow: { flexDirection: 'row', justifyContent: 'space-between', marginBottom: 10 },
  xpAmount: { fontSize: 18, fontWeight: 'bold', color: '#111827' },
  xpNext: { fontSize: 12, color: '#9CA3AF' },
  barBg: { height: 10, backgroundColor: '#E5E7EB', borderRadius: 5, overflow: 'hidden' },
  barFill: { height: '100%', backgroundColor: '#0D9488', borderRadius: 5 },
  statsRow: {
    flexDirection: 'row', backgroundColor: '#fff', marginHorizontal: 16,
    borderRadius: 16, padding: 16, marginBottom: 20, elevation: 2,
    shadowColor: '#000', shadowOpacity: 0.05, shadowRadius: 6,
    shadowOffset: { width: 0, height: 2 },
  },
  statItem: { flex: 1, alignItems: 'center' },
  statNum: { fontSize: 22, fontWeight: 'bold', color: '#111827' },
  statLabel: { fontSize: 11, color: '#6B7280', marginTop: 4, textAlign: 'center' },
  statDivider: { width: 1, backgroundColor: '#E5E7EB' },
  sectionTitle: { fontSize: 16, fontWeight: '700', color: '#111827', paddingHorizontal: 16, marginBottom: 12 },
  achievementsGrid: {
    flexDirection: 'row', flexWrap: 'wrap', paddingHorizontal: 12, marginBottom: 24,
  },
  achCard: {
    width: '45%', margin: '2.5%', backgroundColor: '#fff', borderRadius: 14, padding: 14,
    alignItems: 'center', elevation: 2, shadowColor: '#000', shadowOpacity: 0.05,
    shadowRadius: 4, shadowOffset: { width: 0, height: 2 },
    position: 'relative',
  },
  achLocked: { backgroundColor: '#F3F4F6' },
  achEmoji: { fontSize: 32, marginBottom: 6 },
  achTitle: { fontSize: 13, fontWeight: '700', color: '#111827', textAlign: 'center', marginBottom: 2 },
  achLockedText: { color: '#9CA3AF' },
  achDesc: { fontSize: 11, color: '#6B7280', textAlign: 'center' },
  achBadge: {
    position: 'absolute', top: 8, right: 8,
    backgroundColor: '#059669', width: 18, height: 18, borderRadius: 9,
    alignItems: 'center', justifyContent: 'center',
  },
  achBadgeText: { color: '#fff', fontSize: 10, fontWeight: 'bold' },
  unitProgress: {
    backgroundColor: '#fff', marginHorizontal: 16, borderRadius: 14,
    padding: 14, marginBottom: 10, elevation: 2,
    shadowColor: '#000', shadowOpacity: 0.04, shadowRadius: 4,
    shadowOffset: { width: 0, height: 2 },
  },
  unitProgressRow: { flexDirection: 'row', alignItems: 'center', marginBottom: 8 },
  unitEmoji: { fontSize: 20, marginRight: 8 },
  unitTitle: { flex: 1, fontSize: 14, fontWeight: '600', color: '#111827' },
  unitPct: { fontSize: 14, fontWeight: 'bold' },
  unitBar: { height: 6, backgroundColor: '#E5E7EB', borderRadius: 3, overflow: 'hidden', marginBottom: 4 },
  unitBarFill: { height: '100%', borderRadius: 3 },
  unitCount: { fontSize: 11, color: '#9CA3AF', textAlign: 'right' },
  resetBtn: {
    margin: 16, marginTop: 24, borderRadius: 14, borderWidth: 1.5,
    borderColor: '#EF4444', padding: 14, alignItems: 'center',
  },
  resetBtnText: { color: '#EF4444', fontWeight: '600', fontSize: 15 },
});
