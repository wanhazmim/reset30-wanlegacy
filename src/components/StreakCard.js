import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

export default function StreakCard({ streak }) {
  return (
    <View style={styles.container}>
      <Text style={styles.fire}>🔥</Text>
      <View style={styles.info}>
        <Text style={styles.number}>{streak}</Text>
        <Text style={styles.label}>hari berturut-turut</Text>
      </View>
      <View style={styles.badge}>
        <Text style={styles.badgeText}>Streak!</Text>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    backgroundColor: '#FFF7ED',
    borderRadius: 16,
    padding: 16,
    flexDirection: 'row',
    alignItems: 'center',
    borderWidth: 1,
    borderColor: '#FED7AA',
  },
  fire: {
    fontSize: 32,
    marginRight: 12,
  },
  info: {
    flex: 1,
  },
  number: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#F59E0B',
    lineHeight: 32,
  },
  label: {
    fontSize: 13,
    color: '#92400E',
  },
  badge: {
    backgroundColor: '#F59E0B',
    borderRadius: 8,
    paddingHorizontal: 10,
    paddingVertical: 4,
  },
  badgeText: {
    color: '#fff',
    fontWeight: 'bold',
    fontSize: 12,
  },
});
