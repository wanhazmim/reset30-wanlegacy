import React, { useState, useRef } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, Animated } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { LinearGradient } from 'expo-linear-gradient';
import { Ionicons } from '@expo/vector-icons';
import { useApp } from '../context/AppContext';
import { UNITS } from '../data/courses';
import { C, R, S, UNIT_COLORS } from '../theme';

const UNIT_ICONS = { u1: 'globe-outline', u2: 'color-palette-outline', u3: 'flash-outline' };

function LessonCard({ lesson, index, unit, status, onPress }) {
  const scaleAnim = useRef(new Animated.Value(1)).current;

  const onPressIn = () => Animated.spring(scaleAnim, { toValue: 0.97, useNativeDriver: true }).start();
  const onPressOut = () => Animated.spring(scaleAnim, { toValue: 1, useNativeDriver: true }).start();

  const uc = UNIT_COLORS[unit.id] || UNIT_COLORS.u1;
  const isDone = status === 'done';
  const isLocked = status === 'locked';

  return (
    <Animated.View style={{ transform: [{ scale: scaleAnim }] }}>
      <TouchableOpacity
        style={[styles.lessonCard, isDone && styles.lessonDone, isLocked && styles.lessonLocked]}
        onPress={onPress}
        onPressIn={onPressIn}
        onPressOut={onPressOut}
        disabled={isLocked}
        activeOpacity={1}
      >
        {/* Number circle */}
        <View style={[styles.lessonNum, {
          backgroundColor: isDone ? C.success : isLocked ? C.border : uc.primary,
        }]}>
          {isDone
            ? <Ionicons name="checkmark" size={16} color="#fff" />
            : isLocked
              ? <Ionicons name="lock-closed" size={14} color={C.textMuted} />
              : <Text style={styles.lessonNumText}>{index + 1}</Text>
          }
        </View>

        {/* Content */}
        <View style={{ flex: 1 }}>
          <Text style={[styles.lessonTitle, isLocked && { color: C.textMuted }]} numberOfLines={1}>
            {lesson.title}
          </Text>
          <Text style={styles.lessonDesc} numberOfLines={1}>{lesson.desc}</Text>
          {!isLocked && (
            <View style={styles.lessonMeta}>
              <Ionicons name="time-outline" size={12} color={C.textMuted} />
              <Text style={styles.lessonMetaText}>~5 min</Text>
              <View style={styles.dot} />
              <Text style={styles.lessonMetaText}>{lesson.slides?.length || 3} slaid</Text>
            </View>
          )}
        </View>

        {/* XP badge */}
        <View style={[styles.xpBadge, {
          backgroundColor: isDone ? C.successBg : isLocked ? C.bg : uc.bg,
        }]}>
          <Ionicons name="star" size={11} color={isDone ? C.success : isLocked ? C.textMuted : uc.primary} />
          <Text style={[styles.xpBadgeText, { color: isDone ? C.success : isLocked ? C.textMuted : uc.primary }]}>
            {lesson.xpReward}
          </Text>
        </View>
      </TouchableOpacity>
    </Animated.View>
  );
}

export default function LearningPathScreen({ navigation }) {
  const { completedLessons } = useApp();
  const [activeIdx, setActiveIdx] = useState(0);
  const unit = UNITS[activeIdx];
  const uc = UNIT_COLORS[unit?.id] || UNIT_COLORS.u1;

  const getLessonStatus = (lesson, index) => {
    if (completedLessons.includes(lesson.id)) return 'done';
    const allPrevDone = unit.lessons.slice(0, index).every(l => completedLessons.includes(l.id));
    return (index === 0 || allPrevDone) ? 'open' : 'locked';
  };

  const doneLessons = unit.lessons.filter(l => completedLessons.includes(l.id)).length;
  const pct = unit.lessons.length > 0 ? (doneLessons / unit.lessons.length) * 100 : 0;

  return (
    <SafeAreaView style={styles.safe} edges={['top']}>
      {/* Header */}
      <LinearGradient colors={uc.gradient} style={styles.header}>
        <Text style={styles.headerTitle}>Laluan Belajar</Text>
        <Text style={styles.headerSub}>Pilih topik dan mula belajar</Text>

        {/* Tabs */}
        <ScrollView horizontal showsHorizontalScrollIndicator={false} contentContainerStyle={styles.tabs}>
          {UNITS.map((u, i) => {
            const active = activeIdx === i;
            return (
              <TouchableOpacity key={u.id} style={[styles.tab, active && styles.tabActive]} onPress={() => setActiveIdx(i)} activeOpacity={0.8}>
                <Ionicons name={UNIT_ICONS[u.id] || 'book-outline'} size={15} color={active ? uc.primary : 'rgba(255,255,255,0.7)'} />
                <Text style={[styles.tabText, active && { color: uc.primary }]}>{u.title}</Text>
              </TouchableOpacity>
            );
          })}
        </ScrollView>
      </LinearGradient>

      <ScrollView contentContainerStyle={styles.content} showsVerticalScrollIndicator={false}>
        {/* Unit banner */}
        <View style={[styles.unitBanner, { borderColor: uc.primary + '30' }]}>
          <View style={[styles.unitIconBig, { backgroundColor: uc.bg }]}>
            <Ionicons name={UNIT_ICONS[unit.id] || 'book'} size={30} color={uc.primary} />
          </View>
          <View style={{ flex: 1 }}>
            <Text style={[styles.unitBannerTitle, { color: uc.primary }]}>{unit.title}</Text>
            <Text style={styles.unitBannerSub}>{unit.subtitle}</Text>
            <View style={styles.unitProgressRow}>
              <View style={styles.unitProgressBg}>
                <View style={[styles.unitProgressFill, { width: `${pct}%`, backgroundColor: uc.primary }]} />
              </View>
              <Text style={[styles.unitProgressPct, { color: uc.primary }]}>{Math.round(pct)}%</Text>
            </View>
          </View>
        </View>

        <View style={styles.completedRow}>
          <Ionicons name="checkmark-circle" size={15} color={C.success} />
          <Text style={styles.completedText}>{doneLessons} daripada {unit.lessons.length} pelajaran selesai</Text>
        </View>

        {unit.lessons.map((lesson, idx) => (
          <LessonCard
            key={lesson.id}
            lesson={lesson}
            index={idx}
            unit={unit}
            status={getLessonStatus(lesson, idx)}
            onPress={() => navigation.navigate('Lesson', { lessonId: lesson.id })}
          />
        ))}
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safe: { flex: 1, backgroundColor: C.bg },
  header: { paddingTop: 12, paddingBottom: 0, paddingHorizontal: 20 },
  headerTitle: { fontSize: 22, fontWeight: '800', color: '#fff', marginBottom: 2 },
  headerSub: { fontSize: 13, color: 'rgba(255,255,255,0.75)', marginBottom: 16 },
  tabs: { flexDirection: 'row', gap: 8, paddingBottom: 16 },
  tab: { flexDirection: 'row', alignItems: 'center', gap: 6, paddingHorizontal: 14, paddingVertical: 8, borderRadius: R.full, backgroundColor: 'rgba(255,255,255,0.15)' },
  tabActive: { backgroundColor: '#fff' },
  tabText: { fontSize: 13, fontWeight: '700', color: 'rgba(255,255,255,0.8)' },

  content: { padding: 16, paddingBottom: 40 },
  unitBanner: { backgroundColor: C.surface, borderRadius: R.lg, padding: 16, flexDirection: 'row', gap: 14, marginBottom: 12, borderWidth: 1, ...S.sm },
  unitIconBig: { width: 60, height: 60, borderRadius: R.md, alignItems: 'center', justifyContent: 'center' },
  unitBannerTitle: { fontSize: 16, fontWeight: '800', marginBottom: 3 },
  unitBannerSub: { fontSize: 12, color: C.textSub, marginBottom: 10 },
  unitProgressRow: { flexDirection: 'row', alignItems: 'center', gap: 8 },
  unitProgressBg: { flex: 1, height: 6, backgroundColor: C.border, borderRadius: R.full, overflow: 'hidden' },
  unitProgressFill: { height: '100%', borderRadius: R.full },
  unitProgressPct: { fontSize: 12, fontWeight: '700' },

  completedRow: { flexDirection: 'row', alignItems: 'center', gap: 6, marginBottom: 12 },
  completedText: { fontSize: 13, color: C.textSub, fontWeight: '600' },

  lessonCard: { backgroundColor: C.surface, borderRadius: R.md, padding: 14, flexDirection: 'row', alignItems: 'center', gap: 12, marginBottom: 10, ...S.sm },
  lessonDone: { backgroundColor: '#F0FDF4', borderWidth: 1, borderColor: '#BBF7D0' },
  lessonLocked: { opacity: 0.55 },
  lessonNum: { width: 38, height: 38, borderRadius: 19, alignItems: 'center', justifyContent: 'center', flexShrink: 0 },
  lessonNumText: { color: '#fff', fontWeight: '800', fontSize: 14 },
  lessonTitle: { fontSize: 14, fontWeight: '700', color: C.text, marginBottom: 2 },
  lessonDesc: { fontSize: 12, color: C.textSub, marginBottom: 4 },
  lessonMeta: { flexDirection: 'row', alignItems: 'center', gap: 5 },
  lessonMetaText: { fontSize: 11, color: C.textMuted, fontWeight: '500' },
  dot: { width: 3, height: 3, borderRadius: 2, backgroundColor: C.textMuted },
  xpBadge: { flexDirection: 'row', alignItems: 'center', gap: 3, borderRadius: R.sm, paddingHorizontal: 8, paddingVertical: 5, flexShrink: 0 },
  xpBadgeText: { fontSize: 12, fontWeight: '700' },
});
