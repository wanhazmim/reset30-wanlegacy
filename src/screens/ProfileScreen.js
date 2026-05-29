import React from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, Alert } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { LinearGradient } from 'expo-linear-gradient';
import { Ionicons } from '@expo/vector-icons';
import { useApp } from '../context/AppContext';
import { UNITS } from '../data/courses';
import { C, R, S, UNIT_COLORS } from '../theme';

const ACHIEVEMENTS = [
  { id: 'a1', icon: 'rocket', title: 'Langkah Pertama', desc: '1 pelajaran', type: 'lessons', req: 1, color: C.primary },
  { id: 'a2', icon: 'star',   title: 'Bintang Muda',   desc: '5 pelajaran', type: 'lessons', req: 5, color: C.gold },
  { id: 'a3', icon: 'flame',  title: 'Pelajar Setia',  desc: '10 pelajaran',type: 'lessons', req: 10, color: C.orange },
  { id: 'a4', icon: 'shield-checkmark', title: 'Konsisten', desc: '3 hari streak', type: 'streak', req: 3, color: C.success },
  { id: 'a5', icon: 'diamond',title: 'Disiplin',       desc: '7 hari streak', type: 'streak', req: 7, color: C.violet },
  { id: 'a6', icon: 'trophy', title: 'Juara Kod',      desc: 'Semua selesai', type: 'all',    req: 0, color: C.gold },
];

function StatBox({ icon, value, label, color, bg }) {
  return (
    <View style={[styles.statBox, { backgroundColor: bg }]}>
      <View style={[styles.statIconWrap, { backgroundColor: color + '20' }]}>
        <Ionicons name={icon} size={18} color={color} />
      </View>
      <Text style={[styles.statVal, { color }]}>{value}</Text>
      <Text style={styles.statLbl}>{label}</Text>
    </View>
  );
}

function AchCard({ ach, earned }) {
  return (
    <View style={[styles.achCard, !earned && styles.achLocked]}>
      {earned && (
        <View style={[styles.achCheckmark, { backgroundColor: ach.color }]}>
          <Ionicons name="checkmark" size={10} color="#fff" />
        </View>
      )}
      <View style={[styles.achIconWrap, { backgroundColor: earned ? ach.color + '20' : C.bg }]}>
        <Ionicons name={ach.icon} size={26} color={earned ? ach.color : C.textMuted} />
      </View>
      <Text style={[styles.achTitle, !earned && { color: C.textMuted }]}>{ach.title}</Text>
      <Text style={styles.achDesc}>{ach.desc}</Text>
    </View>
  );
}

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
      <ScrollView contentContainerStyle={styles.scroll} showsVerticalScrollIndicator={false}>

        {/* ── HERO ── */}
        <LinearGradient colors={[C.primary, C.primaryDark]} style={styles.hero}>
          <View style={styles.avatarRing}>
            <View style={styles.avatar}>
              <Text style={styles.avatarText}>{initial}</Text>
            </View>
          </View>
          <Text style={styles.heroName}>{userName || 'Pelajar'}</Text>
          <View style={styles.heroBadges}>
            <View style={styles.heroBadge}>
              <Ionicons name="flash" size={13} color={C.gold} />
              <Text style={styles.heroBadgeText}>Level {level}</Text>
            </View>
            <View style={styles.heroBadge}>
              <Ionicons name="flame" size={13} color="#FF6B6B" />
              <Text style={styles.heroBadgeText}>{streak} Hari</Text>
            </View>
          </View>
          <View style={styles.xpBarWrap}>
            <View style={styles.xpBarBg}>
              <View style={[styles.xpBarFill, { width: `${(xpInLevel / 200) * 100}%` }]} />
            </View>
            <Text style={styles.xpBarLabel}>{xpInLevel}/200 XP</Text>
          </View>
        </LinearGradient>

        {/* ── STATS ── */}
        <View style={styles.statsGrid}>
          <StatBox icon="star"            value={xp}          label="Total XP"  color={C.gold}    bg={C.goldLight} />
          <StatBox icon="book"            value={doneCount}   label="Selesai"   color={C.primary} bg={C.primaryBg} />
          <StatBox icon="heart"           value={hearts}      label="Nyawa"     color={C.danger}  bg={C.dangerBg} />
          <StatBox icon="trophy"          value={level}       label="Level"     color={C.violet}  bg={C.violetBg} />
        </View>

        {/* ── ACHIEVEMENTS ── */}
        <View style={styles.section}>
          <View style={styles.sectionHeader}>
            <Ionicons name="ribbon" size={18} color={C.gold} />
            <Text style={styles.sectionTitle}>Pencapaian</Text>
            <Text style={styles.sectionCount}>{ACHIEVEMENTS.filter(isEarned).length}/{ACHIEVEMENTS.length}</Text>
          </View>
          <View style={styles.achGrid}>
            {ACHIEVEMENTS.map(ach => (
              <AchCard key={ach.id} ach={ach} earned={isEarned(ach)} />
            ))}
          </View>
        </View>

        {/* ── UNIT PROGRESS ── */}
        <View style={styles.section}>
          <View style={styles.sectionHeader}>
            <Ionicons name="bar-chart" size={18} color={C.primary} />
            <Text style={styles.sectionTitle}>Kemajuan Topik</Text>
          </View>
          {UNITS.map(unit => {
            const uc = UNIT_COLORS[unit.id] || UNIT_COLORS.u1;
            const d = unit.lessons.filter(l => completedLessons.includes(l.id)).length;
            const p = unit.lessons.length > 0 ? (d / unit.lessons.length) * 100 : 0;
            return (
              <View key={unit.id} style={styles.unitCard}>
                <View style={[styles.unitIconBox, { backgroundColor: uc.bg }]}>
                  <Text style={{ fontSize: 22 }}>{unit.emoji}</Text>
                </View>
                <View style={{ flex: 1 }}>
                  <View style={styles.unitRow}>
                    <Text style={styles.unitTitle}>{unit.title}</Text>
                    <Text style={[styles.unitPct, { color: uc.primary }]}>{Math.round(p)}%</Text>
                  </View>
                  <View style={styles.unitBar}>
                    <View style={[styles.unitBarFill, { width: `${p}%`, backgroundColor: uc.primary }]} />
                  </View>
                  <Text style={styles.unitCount}>{d}/{unit.lessons.length} pelajaran selesai</Text>
                </View>
              </View>
            );
          })}
        </View>

        {/* ── RESET ── */}
        <TouchableOpacity style={styles.resetBtn} onPress={() =>
          Alert.alert('Reset Kemajuan', 'Ini tidak boleh dibatalkan. Pasti?', [
            { text: 'Batal', style: 'cancel' },
            { text: 'Reset', style: 'destructive', onPress: resetProgress },
          ])}>
          <Ionicons name="refresh-circle-outline" size={18} color={C.danger} />
          <Text style={styles.resetBtnText}>Reset Semua Kemajuan</Text>
        </TouchableOpacity>

      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safe: { flex: 1, backgroundColor: C.bg },
  scroll: { paddingBottom: 40 },

  hero: { paddingTop: 20, paddingBottom: 28, alignItems: 'center', paddingHorizontal: 24 },
  avatarRing: { width: 96, height: 96, borderRadius: 48, padding: 3, backgroundColor: 'rgba(255,255,255,0.3)', marginBottom: 12 },
  avatar: { flex: 1, borderRadius: 45, backgroundColor: 'rgba(255,255,255,0.2)', alignItems: 'center', justifyContent: 'center' },
  avatarText: { fontSize: 40, fontWeight: '800', color: '#fff' },
  heroName: { fontSize: 24, fontWeight: '800', color: '#fff', marginBottom: 10 },
  heroBadges: { flexDirection: 'row', gap: 8, marginBottom: 16 },
  heroBadge: { flexDirection: 'row', alignItems: 'center', gap: 5, backgroundColor: 'rgba(255,255,255,0.2)', borderRadius: R.full, paddingHorizontal: 12, paddingVertical: 5 },
  heroBadgeText: { color: '#fff', fontWeight: '700', fontSize: 13 },
  xpBarWrap: { width: '100%', gap: 6 },
  xpBarBg: { height: 8, backgroundColor: 'rgba(255,255,255,0.2)', borderRadius: R.full, overflow: 'hidden' },
  xpBarFill: { height: '100%', backgroundColor: '#fff', borderRadius: R.full },
  xpBarLabel: { color: 'rgba(255,255,255,0.7)', fontSize: 11, textAlign: 'right' },

  statsGrid: { flexDirection: 'row', flexWrap: 'wrap', padding: 12, gap: 10 },
  statBox: { width: '47%', borderRadius: R.md, padding: 14, alignItems: 'center', ...S.xs },
  statIconWrap: { width: 36, height: 36, borderRadius: R.sm, alignItems: 'center', justifyContent: 'center', marginBottom: 8 },
  statVal: { fontSize: 22, fontWeight: '800', marginBottom: 2 },
  statLbl: { fontSize: 11, color: C.textMuted, fontWeight: '600' },

  section: { backgroundColor: C.surface, marginHorizontal: 12, borderRadius: R.lg, padding: 16, marginBottom: 12, ...S.sm },
  sectionHeader: { flexDirection: 'row', alignItems: 'center', gap: 8, marginBottom: 14 },
  sectionTitle: { fontSize: 15, fontWeight: '700', color: C.text, flex: 1 },
  sectionCount: { fontSize: 13, fontWeight: '700', color: C.textMuted },

  achGrid: { flexDirection: 'row', flexWrap: 'wrap', gap: 10 },
  achCard: { width: '30%', flex: 1, backgroundColor: C.surface, borderRadius: R.md, padding: 12, alignItems: 'center', borderWidth: 1, borderColor: C.border, position: 'relative' },
  achLocked: { backgroundColor: C.surfaceAlt, borderColor: C.divider },
  achCheckmark: { position: 'absolute', top: 6, right: 6, width: 16, height: 16, borderRadius: 8, alignItems: 'center', justifyContent: 'center' },
  achIconWrap: { width: 52, height: 52, borderRadius: 26, alignItems: 'center', justifyContent: 'center', marginBottom: 8 },
  achTitle: { fontSize: 11, fontWeight: '700', color: C.text, textAlign: 'center', marginBottom: 2 },
  achDesc: { fontSize: 10, color: C.textMuted, textAlign: 'center' },

  unitCard: { flexDirection: 'row', alignItems: 'center', gap: 12, marginBottom: 12 },
  unitIconBox: { width: 48, height: 48, borderRadius: R.sm, alignItems: 'center', justifyContent: 'center', flexShrink: 0 },
  unitRow: { flexDirection: 'row', justifyContent: 'space-between', marginBottom: 6 },
  unitTitle: { fontSize: 13, fontWeight: '700', color: C.text },
  unitPct: { fontSize: 13, fontWeight: '700' },
  unitBar: { height: 6, backgroundColor: C.border, borderRadius: R.full, overflow: 'hidden', marginBottom: 4 },
  unitBarFill: { height: '100%', borderRadius: R.full },
  unitCount: { fontSize: 11, color: C.textMuted, fontWeight: '500' },

  resetBtn: { flexDirection: 'row', alignItems: 'center', justifyContent: 'center', gap: 8, marginHorizontal: 12, borderRadius: R.md, borderWidth: 1.5, borderColor: C.danger, paddingVertical: 13 },
  resetBtnText: { color: C.danger, fontWeight: '700', fontSize: 14 },
});
