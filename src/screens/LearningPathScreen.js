import React, { useState } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useApp } from '../context/AppContext';
import { UNITS } from '../data/courses';

export default function LearningPathScreen({ navigation }) {
  const { completedLessons } = useApp();
  const [activeIdx, setActiveIdx] = useState(0);
  const unit = UNITS[activeIdx];

  const getLessonStatus = (lesson, index) => {
    if (completedLessons.includes(lesson.id)) return 'done';
    const allPrevDone = unit.lessons.slice(0, index).every(l => completedLessons.includes(l.id));
    return (index === 0 || allPrevDone) ? 'open' : 'locked';
  };

  const unitDone = unit.lessons.filter(l => completedLessons.includes(l.id)).length;
  const unitPct = unit.lessons.length > 0 ? (unitDone / unit.lessons.length) * 100 : 0;

  return (
    <SafeAreaView style={styles.safe} edges={['top']}>
      <View style={[styles.header, { backgroundColor: unit.color }]}>
        <Text style={styles.headerTitle}>📚 Laluan Belajar</Text>
        <Text style={styles.headerSub}>Pilih topik dan mula belajar</Text>
      </View>

      <View style={[styles.tabsWrap, { backgroundColor: unit.color }]}>
        <ScrollView horizontal showsHorizontalScrollIndicator={false} contentContainerStyle={styles.tabs}>
          {UNITS.map((u, i) => (
            <TouchableOpacity key={u.id} style={[styles.tab, activeIdx === i && styles.tabActive]} onPress={() => setActiveIdx(i)}>
              <Text style={styles.tabEmoji}>{u.emoji}</Text>
              <Text style={[styles.tabText, activeIdx === i && styles.tabTextActive]}>{u.title}</Text>
            </TouchableOpacity>
          ))}
        </ScrollView>
      </View>

      <ScrollView contentContainerStyle={styles.content} showsVerticalScrollIndicator={false}>
        <View style={[styles.unitBanner, { backgroundColor: unit.lightColor || '#F0FDF4' }]}>
          <View style={{ flex: 1 }}>
            <Text style={[styles.unitBannerTitle, { color: unit.color }]}>{unit.emoji} {unit.title}</Text>
            <Text style={styles.unitBannerSub}>{unit.subtitle}</Text>
            <View style={styles.unitBarWrap}>
              <View style={styles.unitBarBg}>
                <View style={[styles.unitBarFill, { width: `${unitPct}%`, backgroundColor: unit.color }]} />
              </View>
              <Text style={[styles.unitBarPct, { color: unit.color }]}>{Math.round(unitPct)}%</Text>
            </View>
          </View>
          <Text style={{ fontSize: 50 }}>{unit.emoji}</Text>
        </View>

        <Text style={styles.sectionLabel}>{unitDone}/{unit.lessons.length} Pelajaran Selesai</Text>

        {unit.lessons.map((lesson, idx) => {
          const status = getLessonStatus(lesson, idx);
          return (
            <TouchableOpacity
              key={lesson.id}
              style={[styles.lessonCard, status === 'done' && styles.lessonDone, status === 'locked' && styles.lessonLocked]}
              onPress={() => status !== 'locked' && navigation.navigate('Lesson', { lessonId: lesson.id })}
              disabled={status === 'locked'}
              activeOpacity={0.75}
            >
              <View style={[styles.lessonBullet, { backgroundColor: status === 'done' ? '#059669' : status === 'locked' ? '#D1D5DB' : unit.color }]}>
                <Text style={styles.lessonBulletText}>{status === 'done' ? '✓' : status === 'locked' ? '🔒' : String(idx + 1)}</Text>
              </View>
              <View style={{ flex: 1 }}>
                <Text style={[styles.lessonTitle, status === 'locked' && { color: '#9CA3AF' }]}>{lesson.title}</Text>
                <Text style={styles.lessonDesc}>{lesson.desc}</Text>
              </View>
              <View style={[styles.xpChip, { backgroundColor: status === 'done' ? '#ECFDF5' : '#F3F4F6' }]}>
                <Text style={{ fontSize: 11, fontWeight: '700', color: status === 'done' ? '#059669' : '#9CA3AF' }}>
                  {status === 'done' ? '✅ ' : ''}{lesson.xpReward} XP
                </Text>
              </View>
            </TouchableOpacity>
          );
        })}
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safe: { flex: 1, backgroundColor: '#F9FAFB' },
  header: { paddingTop: 12, paddingBottom: 12, paddingHorizontal: 20 },
  headerTitle: { fontSize: 22, fontWeight: 'bold', color: '#fff' },
  headerSub: { fontSize: 13, color: 'rgba(255,255,255,0.8)', marginTop: 2 },
  tabsWrap: { paddingBottom: 12 },
  tabs: { paddingHorizontal: 12, gap: 8 },
  tab: { flexDirection: 'row', alignItems: 'center', paddingHorizontal: 14, paddingVertical: 8, borderRadius: 20, backgroundColor: 'rgba(255,255,255,0.15)', gap: 6 },
  tabActive: { backgroundColor: '#fff' },
  tabEmoji: { fontSize: 16 },
  tabText: { fontSize: 13, fontWeight: '600', color: 'rgba(255,255,255,0.8)' },
  tabTextActive: { color: '#0D9488' },
  content: { padding: 16, paddingBottom: 40 },
  unitBanner: { borderRadius: 18, padding: 18, flexDirection: 'row', alignItems: 'center', marginBottom: 16 },
  unitBannerTitle: { fontSize: 18, fontWeight: 'bold', marginBottom: 4 },
  unitBannerSub: { fontSize: 13, color: '#6B7280', marginBottom: 10 },
  unitBarWrap: { flexDirection: 'row', alignItems: 'center', gap: 8 },
  unitBarBg: { flex: 1, height: 6, backgroundColor: 'rgba(0,0,0,0.1)', borderRadius: 3, overflow: 'hidden' },
  unitBarFill: { height: '100%', borderRadius: 3 },
  unitBarPct: { fontSize: 12, fontWeight: 'bold' },
  sectionLabel: { fontSize: 13, fontWeight: '600', color: '#6B7280', marginBottom: 12 },
  lessonCard: { backgroundColor: '#fff', borderRadius: 14, padding: 14, flexDirection: 'row', alignItems: 'center', marginBottom: 10, elevation: 2, shadowColor: '#000', shadowOpacity: 0.05, shadowRadius: 5, shadowOffset: { width: 0, height: 2 } },
  lessonDone: { backgroundColor: '#F0FDF4', borderWidth: 1, borderColor: '#BBF7D0' },
  lessonLocked: { opacity: 0.55 },
  lessonBullet: { width: 36, height: 36, borderRadius: 18, alignItems: 'center', justifyContent: 'center', marginRight: 12 },
  lessonBulletText: { color: '#fff', fontWeight: 'bold', fontSize: 14 },
  lessonTitle: { fontSize: 15, fontWeight: '700', color: '#111827', marginBottom: 2 },
  lessonDesc: { fontSize: 12, color: '#6B7280' },
  xpChip: { borderRadius: 8, paddingHorizontal: 8, paddingVertical: 5 },
});
