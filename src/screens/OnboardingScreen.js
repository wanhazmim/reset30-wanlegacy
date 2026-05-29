import React, { useState, useRef } from 'react';
import {
  View, Text, StyleSheet, TextInput, TouchableOpacity,
  ScrollView, Animated, Dimensions, KeyboardAvoidingView, Platform,
} from 'react-native';
import { useApp } from '../context/AppContext';

const { width } = Dimensions.get('window');

const PAGES = [
  {
    emoji: '🚀',
    title: 'Selamat Datang ke CODE30!',
    body: 'Belajar HTML, CSS & JavaScript dalam Bahasa Melayu.\nMudah. Seronok. Setiap hari.',
  },
  {
    emoji: '🎯',
    title: 'Belajar Seperti Bermain',
    body: 'Kumpul XP, capai streak harian, dan naik level.\nPembelajaran yang memotivasikan!',
  },
  {
    emoji: '🏆',
    title: 'Bersaing Dengan Rakan',
    body: 'Lihat kedudukan kamu dalam papan pendahulu.\nBuktikan kehebatan kodemu!',
  },
];

export default function OnboardingScreen({ navigation }) {
  const { completeOnboarding } = useApp();
  const [page, setPage] = useState(0);
  const [name, setName] = useState('');
  const scrollRef = useRef(null);

  const goNext = () => {
    if (page < PAGES.length - 1) {
      const next = page + 1;
      setPage(next);
      scrollRef.current?.scrollTo({ x: next * width, animated: true });
    } else {
      setPage(PAGES.length);
    }
  };

  const handleStart = () => {
    const trimmed = name.trim() || 'Pelajar';
    completeOnboarding(trimmed, 'bm');
    navigation.replace('Main');
  };

  if (page === PAGES.length) {
    return (
      <KeyboardAvoidingView behavior={Platform.OS === 'ios' ? 'padding' : undefined} style={styles.container}>
        <View style={styles.namePage}>
          <Text style={styles.nameEmoji}>✏️</Text>
          <Text style={styles.nameTitle}>Siapakah kamu?</Text>
          <Text style={styles.nameSubtitle}>Masukkan nama panggilan kamu</Text>
          <TextInput
            style={styles.input}
            placeholder="Contoh: Ali, Nurul, Haziq..."
            placeholderTextColor="#9CA3AF"
            value={name}
            onChangeText={setName}
            maxLength={20}
            autoFocus
          />
          <TouchableOpacity style={styles.startBtn} onPress={handleStart}>
            <Text style={styles.startBtnText}>Mula Belajar! 🚀</Text>
          </TouchableOpacity>
        </View>
      </KeyboardAvoidingView>
    );
  }

  return (
    <View style={styles.container}>
      <ScrollView
        ref={scrollRef}
        horizontal
        pagingEnabled
        scrollEnabled={false}
        showsHorizontalScrollIndicator={false}
      >
        {PAGES.map((p, i) => (
          <View key={i} style={[styles.page, { width }]}>
            <Text style={styles.emoji}>{p.emoji}</Text>
            <Text style={styles.title}>{p.title}</Text>
            <Text style={styles.body}>{p.body}</Text>
          </View>
        ))}
      </ScrollView>

      <View style={styles.bottom}>
        <View style={styles.dots}>
          {PAGES.map((_, i) => (
            <View key={i} style={[styles.dot, page === i && styles.dotActive]} />
          ))}
        </View>
        <TouchableOpacity style={styles.nextBtn} onPress={goNext}>
          <Text style={styles.nextBtnText}>
            {page === PAGES.length - 1 ? 'Seterusnya →' : 'Seterusnya →'}
          </Text>
        </TouchableOpacity>
        {page < PAGES.length - 1 && (
          <TouchableOpacity onPress={() => setPage(PAGES.length)}>
            <Text style={styles.skip}>Langkau</Text>
          </TouchableOpacity>
        )}
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: '#0D9488' },
  page: {
    alignItems: 'center',
    justifyContent: 'center',
    padding: 40,
    paddingTop: 120,
  },
  emoji: { fontSize: 80, marginBottom: 32 },
  title: { fontSize: 26, fontWeight: 'bold', color: '#fff', textAlign: 'center', marginBottom: 16 },
  body: { fontSize: 16, color: 'rgba(255,255,255,0.85)', textAlign: 'center', lineHeight: 24 },
  bottom: { paddingBottom: 50, paddingHorizontal: 32, alignItems: 'center' },
  dots: { flexDirection: 'row', marginBottom: 24 },
  dot: {
    width: 8, height: 8, borderRadius: 4,
    backgroundColor: 'rgba(255,255,255,0.4)', marginHorizontal: 4,
  },
  dotActive: { backgroundColor: '#fff', width: 24 },
  nextBtn: {
    backgroundColor: '#fff', borderRadius: 16,
    paddingHorizontal: 48, paddingVertical: 14,
    width: '100%', alignItems: 'center', marginBottom: 16,
  },
  nextBtnText: { color: '#0D9488', fontWeight: 'bold', fontSize: 16 },
  skip: { color: 'rgba(255,255,255,0.6)', fontSize: 14 },
  namePage: {
    flex: 1, alignItems: 'center', justifyContent: 'center', padding: 32,
  },
  nameEmoji: { fontSize: 64, marginBottom: 24 },
  nameTitle: { fontSize: 28, fontWeight: 'bold', color: '#fff', marginBottom: 8 },
  nameSubtitle: { fontSize: 16, color: 'rgba(255,255,255,0.8)', marginBottom: 32 },
  input: {
    backgroundColor: '#fff', borderRadius: 14,
    paddingHorizontal: 20, paddingVertical: 14,
    fontSize: 18, width: '100%', marginBottom: 24, color: '#111',
  },
  startBtn: {
    backgroundColor: '#F59E0B', borderRadius: 16,
    paddingHorizontal: 48, paddingVertical: 16,
    width: '100%', alignItems: 'center',
  },
  startBtnText: { color: '#fff', fontWeight: 'bold', fontSize: 18 },
});
