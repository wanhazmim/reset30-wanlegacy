import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

const BADGES = [
  { id: 'first_lesson', emoji: '🎯', label: 'Pelajar Pertama', desc: 'Selesaikan pelajaran pertama' },
  { id: 'unit1_done', emoji: '🌐', label: 'Pakar HTML', desc: 'Habiskan Unit HTML' },
  { id: 'unit2_done', emoji: '🎨', label: 'Pelukis CSS', desc: 'Habiskan Unit CSS' },
  { id: 'unit3_done', emoji: '⚡', label: 'Pengaturcara JS', desc: 'Habiskan Unit JavaScript' },
  { id: 'streak7', emoji: '🔥', label: '7 Hari Berturut', desc: 'Aktif 7 hari berturut-turut' },
  { id: 'xp500', emoji: '⭐', label: 'Bintang XP', desc: 'Kumpul 500 XP' },
];

export function getBadgesEarned(completedLessons, streak, xp) {
  const earned = [];
  if (completedLessons.length >= 1) earned.push('first_lesson');
  const u1Done = ['u1l1', 'u1l2', 'u1l3', 'u1l4'].every((id) => completedLessons.includes(id));
  const u2Done = ['u2l1', 'u2l2', 'u2l3', 'u2l4'].every((id) => completedLessons.includes(id));
  const u3Done = ['u3l1', 'u3l2', 'u3l3', 'u3l4'].every((id) => completedLessons.includes(id));
  if (u1Done) earned.push('unit1_done');
  if (u2Done) earned.push('unit2_done');
  if (u3Done) earned.push('unit3_done');
  if (streak >= 7) earned.push('streak7');
  if (xp >= 500) earned.push('xp500');
  return BADGES.filter((b) => earned.includes(b.id));
}

export default function BadgeCard({ badge, size = 'normal' }) {
  const isSmall = size === 'small';
  return (
    <View style={[styles.card, isSmall && styles.cardSmall]}>
      <Text style={[styles.emoji, isSmall && styles.emojiSmall]}>{badge.emoji}</Text>
      <Text style={[styles.label, isSmall && styles.labelSmall]} numberOfLines={2}>
        {badge.label}
      </Text>
      {!isSmall && <Text style={styles.desc}>{badge.desc}</Text>}
    </View>
  );
}

const styles = StyleSheet.create({
  card: {
    backgroundColor: '#fff',
    borderRadius: 16,
    padding: 14,
    alignItems: 'center',
    elevation: 2,
    shadowColor: '#000',
    shadowOpacity: 0.06,
    shadowRadius: 6,
    shadowOffset: { width: 0, height: 2 },
    borderWidth: 1,
    borderColor: '#F59E0B',
    width: 120,
    marginRight: 10,
  },
  cardSmall: {
    width: 90,
    padding: 10,
  },
  emoji: {
    fontSize: 28,
    marginBottom: 6,
  },
  emojiSmall: {
    fontSize: 22,
    marginBottom: 4,
  },
  label: {
    fontSize: 12,
    fontWeight: '700',
    color: '#1f2937',
    textAlign: 'center',
    marginBottom: 4,
  },
  labelSmall: {
    fontSize: 10,
  },
  desc: {
    fontSize: 10,
    color: '#6b7280',
    textAlign: 'center',
  },
});
