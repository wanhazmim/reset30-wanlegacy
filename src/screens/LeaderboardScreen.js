import React, { useRef, useEffect } from 'react';
import {
  View, Text, StyleSheet, ScrollView,
  Animated,
} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { Ionicons } from '@expo/vector-icons';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useApp } from '../context/AppContext';
import { MOCK_LEADERBOARD } from '../data/leaderboard';
import { C, R, S } from '../theme';

const MEDAL_ICONS = ['trophy', 'medal', 'ribbon'];
const MEDAL_COLORS = ['#F59E0B', '#94A3B8', '#CD7C3B'];
const PODIUM_HEIGHTS = [100, 130, 76];

function PodiumItem({ item, heightIndex }) {
  const scaleAnim = useRef(new Animated.Value(0.6)).current;
  const opacityAnim = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    const delay = heightIndex === 1 ? 0 : heightIndex === 0 ? 120 : 240;
    const t = setTimeout(() => {
      Animated.parallel([
        Animated.spring(scaleAnim, { toValue: 1, tension: 60, friction: 7, useNativeDriver: true }),
        Animated.timing(opacityAnim, { toValue: 1, duration: 300, useNativeDriver: true }),
      ]).start();
    }, delay);
    return () => clearTimeout(t);
  }, []);

  if (!item) return <View style={{ flex: 1 }} />;

  const rank = heightIndex === 1 ? 1 : heightIndex === 0 ? 2 : 3;
  const podiumH = PODIUM_HEIGHTS[heightIndex];
  const medalColor = MEDAL_COLORS[rank - 1];

  return (
    <Animated.View style={[styles.podiumItem, { opacity: opacityAnim, transform: [{ scale: scaleAnim }] }]}>
      {rank === 1 && (
        <Ionicons name="star" size={16} color={C.gold} style={{ marginBottom: 2 }} />
      )}
      <View style={[
        styles.podiumAvatar,
        item.isMe && { borderColor: C.gold, borderWidth: 3 },
      ]}>
        <Text style={styles.podiumAvatarText}>{item.avatar}</Text>
      </View>
      <Text style={styles.podiumName} numberOfLines={1}>{item.isMe ? 'Kamu' : item.name}</Text>
      <Text style={styles.podiumXP}>{item.xp} XP</Text>
      <View style={[styles.podiumBlock, { height: podiumH, backgroundColor: medalColor + '22', borderTopColor: medalColor }]}>
        <Ionicons name={MEDAL_ICONS[rank - 1]} size={28} color={medalColor} />
        <Text style={[styles.podiumRank, { color: medalColor }]}>{rank}</Text>
      </View>
    </Animated.View>
  );
}

function ListItem({ item, index }) {
  const slideAnim = useRef(new Animated.Value(30)).current;
  const opacityAnim = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    const delay = index * 40;
    const t = setTimeout(() => {
      Animated.parallel([
        Animated.timing(slideAnim, { toValue: 0, duration: 280, useNativeDriver: true }),
        Animated.timing(opacityAnim, { toValue: 1, duration: 280, useNativeDriver: true }),
      ]).start();
    }, delay);
    return () => clearTimeout(t);
  }, []);

  const rankColor = item.rank <= 3 ? MEDAL_COLORS[item.rank - 1] : C.textMuted;

  return (
    <Animated.View style={{ opacity: opacityAnim, transform: [{ translateY: slideAnim }] }}>
      <View style={[styles.listItem, item.isMe && styles.listItemMe]}>
        <View style={styles.rankWrap}>
          {item.rank <= 3
            ? <Ionicons name={MEDAL_ICONS[item.rank - 1]} size={20} color={rankColor} />
            : <Text style={[styles.rankNum, { color: rankColor }]}>{item.rank}</Text>
          }
        </View>

        <View style={[
          styles.listAvatar,
          item.isMe
            ? { backgroundColor: C.primaryLight, borderWidth: 2, borderColor: C.primary }
            : { backgroundColor: C.bg },
        ]}>
          <Text style={[styles.listAvatarText, { color: item.isMe ? C.primary : C.textSub }]}>
            {item.avatar}
          </Text>
        </View>

        <View style={{ flex: 1, marginLeft: 10 }}>
          <Text style={[styles.listName, item.isMe && { color: C.primary }]} numberOfLines={1}>
            {item.name}{item.isMe ? ' (Kamu)' : ''}
          </Text>
          <Text style={styles.listLevel}>Level {item.level}</Text>
        </View>

        <View style={[styles.xpPill, item.isMe && { backgroundColor: C.primaryBg, borderColor: C.primary, borderWidth: 1 }]}>
          <Ionicons name="flash" size={11} color={item.isMe ? C.primary : C.gold} />
          <Text style={[styles.xpText, item.isMe && { color: C.primary }]}>{item.xp}</Text>
        </View>
      </View>
    </Animated.View>
  );
}

export default function LeaderboardScreen() {
  const insets = useSafeAreaInsets();
  const { userName, xp, level } = useApp();

  const myEntry = {
    id: 'me',
    name: userName || 'Kamu',
    xp,
    level,
    avatar: (userName || 'K').charAt(0).toUpperCase(),
    isMe: true,
  };

  const combined = [...MOCK_LEADERBOARD, myEntry]
    .sort((a, b) => b.xp - a.xp)
    .map((item, i) => ({ ...item, rank: i + 1 }));

  const top3 = combined.slice(0, 3);
  const rest = combined.slice(3);

  const podiumOrder = [top3[1], top3[0], top3[2]];

  const myRank = combined.find(x => x.isMe)?.rank ?? '-';

  return (
    <View style={styles.root}>
      <LinearGradient colors={['#0D9488', '#0A6E66']} style={[styles.header, { paddingTop: insets.top + 16 }]}>
        <View style={styles.headerRow}>
          <View>
            <Text style={styles.headerTitle}>Papan Pendahulu</Text>
            <Text style={styles.headerSub}>Minggu ini — bersaing dengan rakan!</Text>
          </View>
          <View style={styles.myRankBadge}>
            <Text style={styles.myRankLabel}>Ranking</Text>
            <Text style={styles.myRankNum}>#{myRank}</Text>
          </View>
        </View>
      </LinearGradient>

      {/* Podium section */}
      <LinearGradient colors={['#0A6E66', '#0D8A7F']} style={styles.podiumSection}>
        <View style={styles.podiumWrap}>
          {podiumOrder.map((item, idx) => (
            <PodiumItem key={item?.id ?? idx} item={item} heightIndex={idx} />
          ))}
        </View>
      </LinearGradient>

      <ScrollView
        style={styles.listContainer}
        contentContainerStyle={{ paddingHorizontal: 16, paddingTop: 16, paddingBottom: 40 }}
        showsVerticalScrollIndicator={false}
      >
        <Text style={styles.sectionLabel}>Semua Peserta</Text>
        {rest.map((item, i) => (
          <ListItem key={item.id} item={item} index={i} />
        ))}

        <View style={styles.tipCard}>
          <View style={styles.tipIcon}>
            <Ionicons name="bulb" size={20} color={C.gold} />
          </View>
          <Text style={styles.tipText}>
            Selesaikan lebih banyak pelajaran untuk kumpul XP dan naik tangga!
          </Text>
        </View>
      </ScrollView>
    </View>
  );
}

const styles = StyleSheet.create({
  root: { flex: 1, backgroundColor: C.bg },

  header: { paddingBottom: 16, paddingHorizontal: 20 },
  headerRow: { flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between' },
  headerTitle: { fontSize: 22, fontWeight: '800', color: C.textInverse, letterSpacing: 0.3 },
  headerSub: { fontSize: 13, color: 'rgba(255,255,255,0.75)', marginTop: 2 },
  myRankBadge: {
    backgroundColor: 'rgba(255,255,255,0.18)',
    borderRadius: R.md,
    paddingHorizontal: 14,
    paddingVertical: 8,
    alignItems: 'center',
    borderWidth: 1,
    borderColor: 'rgba(255,255,255,0.25)',
  },
  myRankLabel: { fontSize: 10, color: 'rgba(255,255,255,0.75)', fontWeight: '600', textTransform: 'uppercase', letterSpacing: 1 },
  myRankNum: { fontSize: 20, fontWeight: '800', color: C.textInverse, marginTop: 1 },

  podiumSection: { paddingTop: 8, paddingBottom: 20 },
  podiumWrap: { flexDirection: 'row', alignItems: 'flex-end', justifyContent: 'center', paddingHorizontal: 12 },
  podiumItem: { flex: 1, alignItems: 'center' },
  podiumAvatar: {
    width: 52, height: 52, borderRadius: 26,
    backgroundColor: 'rgba(255,255,255,0.22)',
    alignItems: 'center', justifyContent: 'center',
    marginBottom: 6,
  },
  podiumAvatarText: { fontSize: 22, fontWeight: '800', color: '#fff' },
  podiumName: { fontSize: 11, fontWeight: '700', color: '#fff', marginBottom: 2, textAlign: 'center', maxWidth: 80 },
  podiumXP: { fontSize: 10, color: 'rgba(255,255,255,0.7)', marginBottom: 6 },
  podiumBlock: {
    width: '88%',
    borderTopWidth: 3,
    borderTopLeftRadius: R.sm,
    borderTopRightRadius: R.sm,
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 8,
    gap: 2,
  },
  podiumRank: { fontSize: 15, fontWeight: '800' },

  listContainer: { flex: 1 },
  sectionLabel: {
    fontSize: 13, fontWeight: '700', color: C.textMuted,
    textTransform: 'uppercase', letterSpacing: 1.2, marginBottom: 10,
  },

  listItem: {
    flexDirection: 'row', alignItems: 'center',
    backgroundColor: C.surface,
    borderRadius: R.md,
    padding: 12,
    marginBottom: 8,
    ...S.xs,
  },
  listItemMe: {
    backgroundColor: C.primaryBg,
    borderWidth: 1.5,
    borderColor: C.primary,
  },
  rankWrap: { width: 32, alignItems: 'center' },
  rankNum: { fontSize: 15, fontWeight: '800' },
  listAvatar: {
    width: 40, height: 40, borderRadius: 20,
    alignItems: 'center', justifyContent: 'center',
    marginLeft: 4,
  },
  listAvatarText: { fontSize: 16, fontWeight: '800' },
  listName: { fontSize: 14, fontWeight: '700', color: C.text },
  listLevel: { fontSize: 11, color: C.textMuted, marginTop: 1 },
  xpPill: {
    flexDirection: 'row', alignItems: 'center', gap: 3,
    backgroundColor: C.goldLight,
    borderRadius: R.full,
    paddingHorizontal: 9, paddingVertical: 5,
  },
  xpText: { fontSize: 12, fontWeight: '800', color: C.goldDark },

  tipCard: {
    flexDirection: 'row', alignItems: 'flex-start',
    backgroundColor: C.surface,
    borderRadius: R.md,
    padding: 14,
    marginTop: 8,
    borderLeftWidth: 3, borderLeftColor: C.gold,
    ...S.xs,
  },
  tipIcon: {
    width: 32, height: 32, borderRadius: 16,
    backgroundColor: C.goldLight,
    alignItems: 'center', justifyContent: 'center',
    marginRight: 10,
  },
  tipText: { flex: 1, fontSize: 13, color: C.textSub, lineHeight: 19 },
});
