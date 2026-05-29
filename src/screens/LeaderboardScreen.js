import React from 'react';
import { View, Text, StyleSheet, ScrollView, FlatList } from 'react-native';
import { useApp } from '../context/AppContext';
import { MOCK_LEADERBOARD, PODIUM_COLORS } from '../data/leaderboard';

export default function LeaderboardScreen() {
  const { userName, xp, level } = useApp();

  const myEntry = { id: 'me', name: userName || 'Kamu', xp, level, avatar: (userName || 'K').charAt(0).toUpperCase(), isMe: true };

  const combined = [...MOCK_LEADERBOARD, myEntry]
    .sort((a, b) => b.xp - a.xp)
    .map((item, i) => ({ ...item, rank: i + 1 }));

  const top3 = combined.slice(0, 3);
  const rest = combined.slice(3);

  const podiumOrder = [top3[1], top3[0], top3[2]].filter(Boolean);
  const podiumHeights = [80, 110, 60];

  return (
    <View style={styles.root}>
      <View style={styles.header}>
        <Text style={styles.headerTitle}>🏆 Papan Pendahulu</Text>
        <Text style={styles.headerSub}>Minggu ini — bersaing dengan rakan!</Text>
      </View>

      <ScrollView contentContainerStyle={styles.content} showsVerticalScrollIndicator={false}>
        {/* Podium */}
        <View style={styles.podiumWrap}>
          {podiumOrder.map((item, idx) => {
            const podiumH = podiumHeights[idx];
            const rankInPodium = idx === 0 ? 2 : idx === 1 ? 1 : 3;
            return (
              <View key={item.id} style={styles.podiumItem}>
                <View style={[styles.podiumAvatar, item.isMe && styles.podiumAvatarMe]}>
                  <Text style={styles.podiumAvatarText}>{item.avatar}</Text>
                </View>
                <Text style={styles.podiumName} numberOfLines={1}>{item.name}</Text>
                <Text style={styles.podiumXP}>{item.xp} XP</Text>
                <View style={[styles.podiumBlock, { height: podiumH, backgroundColor: PODIUM_COLORS[rankInPodium - 1] }]}>
                  <Text style={styles.podiumRankText}>{rankInPodium === 1 ? '🥇' : rankInPodium === 2 ? '🥈' : '🥉'}</Text>
                </View>
              </View>
            );
          })}
        </View>

        {/* Rest of list */}
        <View style={styles.listWrap}>
          {rest.map(item => (
            <View key={item.id} style={[styles.listItem, item.isMe && styles.listItemMe]}>
              <Text style={styles.rankNum}>{item.rank}</Text>
              <View style={[styles.listAvatar, item.isMe && styles.listAvatarMe]}>
                <Text style={styles.listAvatarText}>{item.avatar}</Text>
              </View>
              <View style={{ flex: 1 }}>
                <Text style={[styles.listName, item.isMe && styles.listNameMe]}>
                  {item.name}{item.isMe ? ' (Kamu)' : ''}
                </Text>
                <Text style={styles.listLevel}>Level {item.level}</Text>
              </View>
              <View style={styles.xpBadge}>
                <Text style={[styles.xpBadgeText, item.isMe && { color: '#0D9488' }]}>
                  {item.xp} XP
                </Text>
              </View>
            </View>
          ))}
        </View>

        <View style={styles.infoBox}>
          <Text style={styles.infoText}>💡 Selesaikan pelajaran untuk kumpul XP dan naik tangga!</Text>
        </View>
      </ScrollView>
    </View>
  );
}

const styles = StyleSheet.create({
  root: { flex: 1, backgroundColor: '#F9FAFB' },
  header: {
    backgroundColor: '#0D9488', paddingTop: 52,
    paddingBottom: 16, paddingHorizontal: 20,
  },
  headerTitle: { fontSize: 22, fontWeight: 'bold', color: '#fff' },
  headerSub: { fontSize: 14, color: 'rgba(255,255,255,0.8)', marginTop: 2 },
  content: { paddingBottom: 40 },
  podiumWrap: {
    flexDirection: 'row', justifyContent: 'center', alignItems: 'flex-end',
    paddingTop: 24, paddingBottom: 8, paddingHorizontal: 20,
    backgroundColor: '#0D9488',
  },
  podiumItem: { alignItems: 'center', flex: 1 },
  podiumAvatar: {
    width: 52, height: 52, borderRadius: 26,
    backgroundColor: 'rgba(255,255,255,0.25)',
    alignItems: 'center', justifyContent: 'center', marginBottom: 4,
    borderWidth: 2, borderColor: 'rgba(255,255,255,0.4)',
  },
  podiumAvatarMe: { borderColor: '#F59E0B', borderWidth: 2.5 },
  podiumAvatarText: { fontSize: 22, fontWeight: 'bold', color: '#fff' },
  podiumName: { fontSize: 11, fontWeight: '700', color: '#fff', marginBottom: 2, maxWidth: 80, textAlign: 'center' },
  podiumXP: { fontSize: 10, color: 'rgba(255,255,255,0.8)', marginBottom: 4 },
  podiumBlock: {
    width: '90%', borderTopLeftRadius: 8, borderTopRightRadius: 8,
    alignItems: 'center', justifyContent: 'center',
  },
  podiumRankText: { fontSize: 22, paddingTop: 8 },
  listWrap: { paddingHorizontal: 16, paddingTop: 16 },
  listItem: {
    flexDirection: 'row', alignItems: 'center', backgroundColor: '#fff',
    borderRadius: 14, padding: 12, marginBottom: 8, elevation: 1,
    shadowColor: '#000', shadowOpacity: 0.04, shadowRadius: 4,
    shadowOffset: { width: 0, height: 2 },
  },
  listItemMe: { backgroundColor: '#F0FDFA', borderWidth: 1.5, borderColor: '#0D9488' },
  rankNum: { fontSize: 15, fontWeight: 'bold', color: '#9CA3AF', width: 28, textAlign: 'center' },
  listAvatar: {
    width: 38, height: 38, borderRadius: 19,
    backgroundColor: '#E5E7EB',
    alignItems: 'center', justifyContent: 'center', marginHorizontal: 10,
  },
  listAvatarMe: { backgroundColor: '#CCFBF1' },
  listAvatarText: { fontSize: 16, fontWeight: 'bold', color: '#374151' },
  listName: { fontSize: 14, fontWeight: '600', color: '#111827' },
  listNameMe: { color: '#0D9488' },
  listLevel: { fontSize: 11, color: '#9CA3AF', marginTop: 1 },
  xpBadge: { backgroundColor: '#F3F4F6', borderRadius: 8, paddingHorizontal: 8, paddingVertical: 4 },
  xpBadgeText: { fontSize: 13, fontWeight: 'bold', color: '#374151' },
  infoBox: {
    margin: 16, backgroundColor: '#ECFDF5', borderRadius: 12,
    padding: 14, borderLeftWidth: 3, borderLeftColor: '#059669',
  },
  infoText: { fontSize: 13, color: '#065F46', lineHeight: 18 },
});
