import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

const XP_PER_LEVEL = 200;

export default function XPBar({ xp, level }) {
  const xpInLevel = xp % XP_PER_LEVEL;
  const progress = xpInLevel / XP_PER_LEVEL;

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <View style={styles.levelBadge}>
          <Text style={styles.levelText}>Lvl {level}</Text>
        </View>
        <Text style={styles.xpText}>{xp} XP</Text>
      </View>
      <View style={styles.barBg}>
        <View style={[styles.barFill, { width: `${Math.min(progress * 100, 100)}%` }]} />
      </View>
      <Text style={styles.nextLevel}>{xpInLevel}/{XP_PER_LEVEL} XP ke level {level + 1}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    backgroundColor: '#fff',
    borderRadius: 16,
    padding: 16,
    elevation: 2,
    shadowColor: '#000',
    shadowOpacity: 0.06,
    shadowRadius: 6,
    shadowOffset: { width: 0, height: 2 },
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: 10,
  },
  levelBadge: {
    backgroundColor: '#0D9488',
    paddingHorizontal: 12,
    paddingVertical: 4,
    borderRadius: 20,
  },
  levelText: {
    color: '#fff',
    fontWeight: 'bold',
    fontSize: 14,
  },
  xpText: {
    color: '#0D9488',
    fontWeight: 'bold',
    fontSize: 16,
  },
  barBg: {
    backgroundColor: '#E5F4F3',
    borderRadius: 8,
    height: 10,
    overflow: 'hidden',
  },
  barFill: {
    backgroundColor: '#0D9488',
    height: '100%',
    borderRadius: 8,
  },
  nextLevel: {
    fontSize: 12,
    color: '#6b7280',
    marginTop: 6,
    textAlign: 'right',
  },
});
