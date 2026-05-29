import React, { useState } from 'react';
import {
  View, Text, StyleSheet, ScrollView,
  TouchableOpacity, FlatList,
} from 'react-native';
import { useApp } from '../context/AppContext';
import { UNITS } from '../data/courses';

const TABS = [
  { id: 'u1', label: '🌐 HTML' },
  { id: 'u2', label: '🎨 CSS' },
  { id: 'u3', label: '⚡ JS' },
];

export default function LearningPathScreen({ navigation }) {
  const { completedLessons } = useApp();
  const [activeTab, setActiveTab] = useState('u1');

  const unit = UNITS.find(u => u.id === activeTab) || UNITS[0];

  const getLessonStatus = (lesson, index, lessons) => {
    if (completedLessons.includes(lesson.id)) return 'done';
    const allPrevDone = lessons.slice(0, index).every(l => completedLessons.includes(l.id));
    if (index === 0 || allPrevDone) return 'open';
    return 'locked';
  };

  const unitProgress = unit.lessons.filter(l => completedLessons.includes(l.id)).length;

  return (
    <View style={styles.root}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>📚 Laluan Belajar</Text>
        <Text style={styles.headerSub}>Pilih topik dan mulakan pelajaran</Text>
      </View>

      {/* Tabs */}
      <View style={styles.tabs}>
        {TABS.map(tab => (
          <TouchableOpacity
            key={tab.id}
            style={[styles.tab, activeTab === tab.id && styles.tabActive]}
            onPress={() => setActiveTab(tab.id)}
          >
            <Text style={[styles.tabText, activeTab === tab.id && styles.tabTextActive]}>
              {tab.label}
            </Text>
          </TouchableOpacity>
        ))}
      </View>

      <ScrollView contentContainerStyle={styles.content} showsVerticalScrollIndicator={false}>
        {/* Unit Header */}
        <View style={[styles.unitHeader, { backgroundColor: unit.color }]}>
          <Text style={styles.unitEmoji}>{unit.emoji}</Text>
          <View style={{ flex: 1 }}>
            <Text style={styles.unitTitle}>{unit.title}</Text>
            <Text style={styles.unitSub}>{unit.subtitle}</Text>
          </View>
          <Text style={styles.unitProgress}>{unitProgress}/{unit.lessons.length}</Text>
        </View>

        {/* Progress Bar */}
        <View style={styles.progressBarWrap}>
          <View style={styles.progressBarBg}>
            <View
              style={[
                styles.progressBarFill,
                { width: `${unit.lessons.length ? (unitProgress / unit.lessons.length) * 100 : 0}%`, backgroundColor: unit.color },
              ]}
            />
          </View>
        </View>

        {/* Lessons */}
        {unit.lessons.map((lesson, index) => {
          const status = getLessonStatus(lesson, index, unit.lessons);
          return (
            <TouchableOpacity
              key={lesson.id}
              style={[
                styles.lessonCard,
                status === 'done' && styles.lessonDone,
                status === 'locked' && styles.lessonLocked,
              ]}
              onPress={() => {
                if (status !== 'locked') {
                  navigation.navigate('Lesson', { lessonId: lesson.id });
                }
              }}
              disabled={status === 'locked'}
            >
              <View style={[styles.lessonNum, { backgroundColor: status === 'done' ? '#059669' : status === 'locked' ? '#D1D5DB' : unit.color }]}>
                <Text style={styles.lessonNumText}>
                  {status === 'done' ? '✓' : status === 'locked' ? '🔒' : (index + 1).toString()}
                </Text>
              </View>
              <View style={{ flex: 1 }}>
                <Text style={[styles.lessonTitle, status === 'locked' && styles.lockedText]}>
                  {lesson.title}
                </Text>
                <Text style={styles.lessonDesc}>{lesson.desc}</Text>
              </View>
              <View style={[styles.xpPill, { backgroundColor: status === 'done' ? '#ECFDF5' : '#F3F4F6' }]}>
                <Text style={[styles.xpPillText, { color: status === 'done' ? '#059669' : '#9CA3AF' }]}>
                  {status === 'done' ? '✅' : ''} {lesson.xpReward} XP
                </Text>
              </View>
            </TouchableOpacity>
          );
        })}
      </ScrollView>
    </View>
  );
}

const styles = StyleSheet.create({
  root: { flex: 1, backgroundColor: '#F9FAFB' },
  header: {
    backgroundColor: '#0D9488', paddingTop: 52, paddingBottom: 16,
    paddingHorizontal: 20,
  },
  headerTitle: { fontSize: 22, fontWeight: 'bold', color: '#fff' },
  headerSub: { fontSize: 14, color: 'rgba(255,255,255,0.8)', marginTop: 2 },
  tabs: {
    flexDirection: 'row', backgroundColor: '#0D9488',
    paddingHorizontal: 16, paddingBottom: 12,
  },
  tab: {
    flex: 1, paddingVertical: 8, borderRadius: 10, alignItems: 'center',
    marginHorizontal: 4,
  },
  tabActive: { backgroundColor: '#fff' },
  tabText: { fontSize: 13, fontWeight: '600', color: 'rgba(255,255,255,0.7)' },
  tabTextActive: { color: '#0D9488' },
  content: { padding: 16, paddingBottom: 40 },
  unitHeader: {
    borderRadius: 16, padding: 16, flexDirection: 'row', alignItems: 'center',
    marginBottom: 8,
  },
  unitEmoji: { fontSize: 36, marginRight: 14 },
  unitTitle: { fontSize: 18, fontWeight: 'bold', color: '#fff' },
  unitSub: { fontSize: 12, color: 'rgba(255,255,255,0.85)', marginTop: 2 },
  unitProgress: { fontSize: 22, fontWeight: 'bold', color: '#fff' },
  progressBarWrap: { marginBottom: 20 },
  progressBarBg: { height: 6, backgroundColor: '#E5E7EB', borderRadius: 4, overflow: 'hidden' },
  progressBarFill: { height: '100%', borderRadius: 4 },
  lessonCard: {
    backgroundColor: '#fff', borderRadius: 14, padding: 14,
    flexDirection: 'row', alignItems: 'center', marginBottom: 10,
    elevation: 2, shadowColor: '#000', shadowOpacity: 0.05,
    shadowRadius: 4, shadowOffset: { width: 0, height: 2 },
  },
  lessonDone: { backgroundColor: '#F0FDF4', borderWidth: 1, borderColor: '#BBF7D0' },
  lessonLocked: { opacity: 0.5 },
  lessonNum: {
    width: 36, height: 36, borderRadius: 18,
    alignItems: 'center', justifyContent: 'center', marginRight: 12,
  },
  lessonNumText: { color: '#fff', fontWeight: 'bold', fontSize: 14 },
  lessonTitle: { fontSize: 15, fontWeight: '700', color: '#111827' },
  lessonDesc: { fontSize: 12, color: '#6B7280', marginTop: 2 },
  lockedText: { color: '#9CA3AF' },
  xpPill: { borderRadius: 8, paddingHorizontal: 8, paddingVertical: 4 },
  xpPillText: { fontSize: 12, fontWeight: '600' },
});
