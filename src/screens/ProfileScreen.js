import React from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, Alert } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useApp } from '../context/AppContext';
import { UNITS } from '../data/courses';

const ACHIEVEMENTS = [
  { id: 'a1', emoji: '🎯', title: 'Langkah Pertama', desc: 'Selesaikan 1 pelajaran', type: 'lessons', req: 1 },
  { id: 'a2', emoji: '⭐', title: 'Bintang Muda', desc: '5 pelajaran selesai', type: 'lessons', req: 5 },
  { id: 'a3', emoji: '🔥', title: 'Pelajar Setia', desc: '10 pelajaran selesai', type: 'lessons', req: 10 },
  { id: 'a4', emoji: '💪', title: 'Konsisten', desc: 'Streak 3 hari', type: 'streak', req: 3 },
  { id: 'a5', emoji: '🌟', title: 'Disiplin', desc: 'Streak 7 hari', type: 'streak', req: 7 },
  { id: 'a6', emoji: '🏆', title: 'Juara Kod', desc: 'Semua pelajaran selesai', type: 'all', req: 0 },
];

export default function ProfileScreen() {
  const { userName, xp, level, streak, hearts, completedLessons, resetProgress } = useApp();
  const totalLessons = UNITS.reduce((s, u) => s + u.lessons.length, 0);
  const doneCount = completedLessons.length;
  const xpInLevel = xp % 200;
  const initial = (userName || 'P').charAt(0).toUpperCase();

  const isEarned = (ach) => {
    if (ach.type === 'streak') return streak >= ach.req;
    if (ach.type === 'all') return doneCount >= totalLessons && totalLessons > 0;
    return doneCount >= ach.req;
  };

  return (
    <SafeAreaView style={styles.safe} edges={['top']}>
      <ScrollView contentContainerStyle={styles.content} showsVerticalScrollIndicator={false}>
        <View style={styles.heroCard}>
          <View style={styles.avatar}><Text style={styles.avatarText}>{initial}</Text></View>
          <Text style={styles.name}>{userName || 'Pelajar'}</Text>
          <View style={styles.levelRow}>
            <View style={styles.levelBadge}><Text style={styles.levelBadgeText}>Level {level}</Text></View>
            <View style={[styles.levelBadge, { backgroundColor: 'rgba(255,255,255,0.15)' }]}>
              <Text style={styles.levelBadgeText}>🔥 {streak} hari</Text>
            </View>
          </View>
          <View style={styles.xpRow}>
            <Text style={styles.xpText}>{xpInLevel} / 200 XP</Text>
          </View>
          <View style={styles.xpBar}>
            <View style={[styles.xpBarFill, { width: `${(xpInLevel / 200) * 100}%` }]} />
          </View>
        </View>

        <View style={styles.statsRow}>
          {[
            { emoji: '⭐', val: String(xp), label: 'Total XP' },
            { emoji: '📖', val: String(doneCount), label: 'Pelajaran' },
            { emoji: '❤️', val: String(hearts), label: 'Nyawa' },
            { emoji: '🎖️', val: String(level), label: 'Level' },
          ].map((s, i) => (
            <View key={i} style={styles.statBox}>
              <Text style={{ fontSize: 22 }}>{s.emoji}</Text>
              <Text style={styles.statBoxVal}>{s.val}</Text>
              <Text style={styles.statBoxLabel}>{s.label}</Text>
            </View>
          ))}
        </View>

        <Text style={styles.sectionTitle}>🏅 Pencapaian</Text>
        <View style={styles.achGrid}>
          {ACHIEVEMENTS.map(ach => {
            const earned = isEarned(ach);
            return (
              <View key={ach.id} style={[styles.achCard, !earned && styles.achLocked]}>
                {earned && <View style={styles.achCheck}><Text style={{ fontSize: 10, color: '#fff', fontWeight: 'bold' }}>✓</Text></View>}
                <Text style={[styles.achEmoji, !earned && { opacity: 0.25 }]}>{ach.emoji}</Text>
                <Text style={[styles.achTitle, !earned && { color: '#9CA3AF' }]}>{ach.title}</Text>
                <Text style={styles.achDesc}>{ach.desc}</Text>
              </View>
            );
          })}
        </View>

        <Text style={styles.sectionTitle}>📊 Kemajuan Topik</Text>
        {UNITS.map(unit => {
          const d = unit.lessons.filter(l => completedLessons.includes(l.id)).length;
          const p = unit.lessons.length > 0 ? (d / unit.lessons.length) * 100 : 0;
          return (
            <View key={unit.id} style={styles.unitCard}>
              <View style={{ flexDirection: 'row', alignItems: 'center', marginBottom: 10 }}>
                <View style={[styles.unitIcon, { backgroundColor: unit.lightColor || '#F0FDF4' }]}>
                  <Text style={{ fontSize: 22 }}>{unit.emoji}</Text>
                </View>
                <View style={{ flex: 1 }}>
                  <Text style={styles.unitCardTitle}>{unit.title}</Text>
                  <Text style={styles.unitCardSub}>{d} / {unit.lessons.length} pelajaran</Text>
                </View>
                <Text style={[styles.unitPct, { color: unit.color }]}>{Math.round(p)}%</Text>
              </View>
              <View style={styles.unitBar}>
                <View style={[styles.unitBarFill, { width: `${p}%`, backgroundColor: unit.color }]} />
              </View>
            </View>
          );
        })}

        <TouchableOpacity style={styles.resetBtn} onPress={() => Alert.alert('Reset Kemajuan', 'Adakah kamu pasti? Ini tidak boleh dibatalkan.', [
          { text: 'Batal', style: 'cancel' },
          { text: 'Reset', style: 'destructive', onPress: resetProgress },
        ])}>
          <Text style={styles.resetBtnText}>🔄 Reset Semua Kemajuan</Text>
        </TouchableOpacity>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safe: { flex: 1, backgroundColor: '#F9FAFB' },
  content: { paddingBottom: 40 },
  heroCard: { backgroundColor: '#0D9488', paddingTop: 24, paddingBottom: 28, alignItems: 'center', paddingHorizontal: 20 },
  avatar: { width: 90, height: 90, borderRadius: 45, backgroundColor: 'rgba(255,255,255,0.2)', alignItems: 'center', justifyContent: 'center', marginBottom: 12, borderWidth: 3, borderColor: 'rgba(255,255,255,0.4)' },
  avatarText: { fontSize: 38, fontWeight: 'bold', color: '#fff' },
  name: { fontSize: 22, fontWeight: 'bold', color: '#fff', marginBottom: 10 },
  levelRow: { flexDirection: 'row', gap: 8, marginBottom: 14 },
  levelBadge: { backgroundColor: 'rgba(255,255,255,0.25)', paddingHorizontal: 14, paddingVertical: 5, borderRadius: 20 },
  levelBadgeText: { color: '#fff', fontWeight: '600', fontSize: 13 },
  xpRow: { marginBottom: 8 },
  xpText: { color: 'rgba(255,255,255,0.85)', fontSize: 13 },
  xpBar: { width: '80%', height: 8, backgroundColor: 'rgba(255,255,255,0.2)', borderRadius: 4, overflow: 'hidden' },
  xpBarFill: { height: '100%', backgroundColor: '#fff', borderRadius: 4 },
  statsRow: { flexDirection: 'row', margin: 16, backgroundColor: '#fff', borderRadius: 18, padding: 16, elevation: 3, shadowColor: '#000', shadowOpacity: 0.06, shadowRadius: 8, shadowOffset: { width: 0, height: 3 } },
  statBox: { flex: 1, alignItems: 'center' },
  statBoxVal: { fontSize: 20, fontWeight: 'bold', color: '#111827', marginTop: 4 },
  statBoxLabel: { fontSize: 10, color: '#9CA3AF', marginTop: 2, fontWeight: '600' },
  sectionTitle: { fontSize: 15, fontWeight: '700', color: '#111827', paddingHorizontal: 16, marginBottom: 12 },
  achGrid: { flexDirection: 'row', flexWrap: 'wrap', paddingHorizontal: 12, marginBottom: 24 },
  achCard: { width: '45%', margin: '2.5%', backgroundColor: '#fff', borderRadius: 14, padding: 14, alignItems: 'center', elevation: 2, shadowColor: '#000', shadowOpacity: 0.05, shadowRadius: 5, shadowOffset: { width: 0, height: 2 }, position: 'relative' },
  achLocked: { backgroundColor: '#F9FAFB' },
  achCheck: { position: 'absolute', top: 8, right: 8, width: 18, height: 18, borderRadius: 9, backgroundColor: '#059669', alignItems: 'center', justifyContent: 'center' },
  achEmoji: { fontSize: 32, marginBottom: 6 },
  achTitle: { fontSize: 13, fontWeight: '700', color: '#111827', textAlign: 'center', marginBottom: 2 },
  achDesc: { fontSize: 11, color: '#6B7280', textAlign: 'center' },
  unitCard: { backgroundColor: '#fff', marginHorizontal: 16, borderRadius: 14, padding: 14, marginBottom: 10, elevation: 2, shadowColor: '#000', shadowOpacity: 0.04, shadowRadius: 5, shadowOffset: { width: 0, height: 2 } },
  unitIcon: { width: 44, height: 44, borderRadius: 12, alignItems: 'center', justifyContent: 'center', marginRight: 12 },
  unitCardTitle: { fontSize: 14, fontWeight: '700', color: '#111827' },
  unitCardSub: { fontSize: 12, color: '#6B7280', marginTop: 2 },
  unitPct: { fontSize: 16, fontWeight: 'bold' },
  unitBar: { height: 6, backgroundColor: '#F3F4F6', borderRadius: 3, overflow: 'hidden' },
  unitBarFill: { height: '100%', borderRadius: 3 },
  resetBtn: { margin: 16, marginTop: 8, borderRadius: 14, borderWidth: 1.5, borderColor: '#EF4444', padding: 14, alignItems: 'center' },
  resetBtnText: { color: '#EF4444', fontWeight: '600', fontSize: 15 },
});
