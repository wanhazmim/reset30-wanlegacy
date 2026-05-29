import React, { useEffect, useRef } from 'react';
import { View, Text, StyleSheet, Animated } from 'react-native';
import { useApp } from '../context/AppContext';

export default function SplashScreen({ navigation }) {
  const { isFirstTime, init } = useApp();
  const scaleAnim = useRef(new Animated.Value(0.7)).current;
  const opacityAnim = useRef(new Animated.Value(0)).current;
  const dotAnim1 = useRef(new Animated.Value(0.3)).current;
  const dotAnim2 = useRef(new Animated.Value(0.3)).current;
  const dotAnim3 = useRef(new Animated.Value(0.3)).current;

  useEffect(() => {
    // Animate in
    Animated.parallel([
      Animated.spring(scaleAnim, { toValue: 1, tension: 50, friction: 7, useNativeDriver: true }),
      Animated.timing(opacityAnim, { toValue: 1, duration: 500, useNativeDriver: true }),
    ]).start();

    // Loading dots
    const dotLoop = Animated.loop(
      Animated.sequence([
        Animated.timing(dotAnim1, { toValue: 1, duration: 300, useNativeDriver: true }),
        Animated.timing(dotAnim2, { toValue: 1, duration: 300, useNativeDriver: true }),
        Animated.timing(dotAnim3, { toValue: 1, duration: 300, useNativeDriver: true }),
        Animated.delay(200),
        Animated.parallel([
          Animated.timing(dotAnim1, { toValue: 0.3, duration: 200, useNativeDriver: true }),
          Animated.timing(dotAnim2, { toValue: 0.3, duration: 200, useNativeDriver: true }),
          Animated.timing(dotAnim3, { toValue: 0.3, duration: 200, useNativeDriver: true }),
        ]),
      ])
    );
    dotLoop.start();

    const timer = setTimeout(async () => {
      await init();
      dotLoop.stop();
    }, 400);

    return () => clearTimeout(timer);
  }, []);

  useEffect(() => {
    if (isFirstTime === true) return;
    const t = setTimeout(() => {
      navigation.replace(isFirstTime ? 'Onboarding' : 'Main');
    }, 2000);
    return () => clearTimeout(t);
  }, [isFirstTime]);

  return (
    <View style={styles.container}>
      <Animated.View style={[styles.content, { opacity: opacityAnim, transform: [{ scale: scaleAnim }] }]}>
        <View style={styles.logoRing}>
          <View style={styles.logoBg}>
            <Text style={styles.logoEmoji}>🚀</Text>
          </View>
        </View>
        <Text style={styles.appName}>CODE30</Text>
        <Text style={styles.tagline}>Belajar Kod. Setiap Hari.</Text>
        <Text style={styles.subtitle}>dalam Bahasa Melayu 🇲🇾</Text>
      </Animated.View>

      <View style={styles.dots}>
        {[dotAnim1, dotAnim2, dotAnim3].map((anim, i) => (
          <Animated.View key={i} style={[styles.dot, { opacity: anim }]} />
        ))}
      </View>

      <Text style={styles.version}>v1.2.0</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#0D9488',
    alignItems: 'center',
    justifyContent: 'center',
  },
  content: { alignItems: 'center' },
  logoRing: {
    width: 130, height: 130, borderRadius: 65,
    borderWidth: 2, borderColor: 'rgba(255,255,255,0.3)',
    alignItems: 'center', justifyContent: 'center',
    marginBottom: 28,
  },
  logoBg: {
    width: 110, height: 110, borderRadius: 55,
    backgroundColor: 'rgba(255,255,255,0.15)',
    alignItems: 'center', justifyContent: 'center',
  },
  logoEmoji: { fontSize: 60 },
  appName: {
    fontSize: 48, fontWeight: 'bold', color: '#fff',
    letterSpacing: 6, marginBottom: 10,
  },
  tagline: {
    fontSize: 17, color: 'rgba(255,255,255,0.9)',
    fontWeight: '600', letterSpacing: 0.5,
  },
  subtitle: {
    fontSize: 14, color: 'rgba(255,255,255,0.65)',
    marginTop: 8,
  },
  dots: {
    position: 'absolute', bottom: 70,
    flexDirection: 'row', gap: 8,
  },
  dot: {
    width: 8, height: 8, borderRadius: 4,
    backgroundColor: '#fff',
  },
  version: {
    position: 'absolute', bottom: 24,
    color: 'rgba(255,255,255,0.4)', fontSize: 12,
  },
});
