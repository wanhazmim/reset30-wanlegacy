import React from 'react';
import { TouchableOpacity, View, Text, StyleSheet } from 'react-native';

export default function LessonCard({ lesson, status, onPress }) {
  const isLocked = status === 'locked';
  const isDone = status === 'completed';

  return (
    <TouchableOpacity
      style={[styles.card, isLocked && styles.locked, isDone && styles.done]}
      onPress={isLocked ? null : onPress}
      activeOpacity={isLocked ? 1 : 0.7}
    >
      <Text style={styles.emoji}>{lesson.emoji}</Text>
      <Text style={[styles.title, isLocked && styles.lockedText]} numberOfLines={2}>
        {lesson.title}
      </Text>
      {isDone && <Text style={styles.checkmark}>✅</Text>}
      {isLocked && <Text style={styles.lock}>🔒</Text>}
      <View style={styles.xpBadge}>
        <Text style={styles.xpText}>+{lesson.xpReward} XP</Text>
      </View>
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  card: {
    backgroundColor: '#fff',
    borderRadius: 16,
    padding: 14,
    width: 130,
    marginRight: 10,
    alignItems: 'center',
    elevation: 2,
    shadowColor: '#000',
    shadowOpacity: 0.06,
    shadowRadius: 6,
    shadowOffset: { width: 0, height: 2 },
    borderWidth: 2,
    borderColor: '#E5F4F3',
  },
  locked: {
    backgroundColor: '#f3f4f6',
    borderColor: '#e5e7eb',
  },
  done: {
    borderColor: '#0D9488',
    backgroundColor: '#F0FDF9',
  },
  emoji: {
    fontSize: 28,
    marginBottom: 8,
  },
  title: {
    fontSize: 13,
    fontWeight: '600',
    color: '#1f2937',
    textAlign: 'center',
    marginBottom: 6,
  },
  lockedText: {
    color: '#9ca3af',
  },
  checkmark: {
    fontSize: 16,
    marginBottom: 4,
  },
  lock: {
    fontSize: 14,
    marginBottom: 4,
    opacity: 0.5,
  },
  xpBadge: {
    backgroundColor: '#F0FDF9',
    borderRadius: 8,
    paddingHorizontal: 8,
    paddingVertical: 2,
    marginTop: 4,
  },
  xpText: {
    color: '#0D9488',
    fontSize: 11,
    fontWeight: 'bold',
  },
});
