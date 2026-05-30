import React, { useState, useRef } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, Animated, Dimensions, Alert } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useApp } from '../context/AppContext';
import { getLessonById } from '../data/courses';
import { C, R, S } from '../theme';

const { width } = Dimensions.get('window');

// ── SLIDE VIEW ──────────────────────────────────────────────────────
function SlideView({ slide, index, total, onNext, isLast }) {
  return (
    <ScrollView contentContainerStyle={styles.slideScroll} showsVerticalScrollIndicator={false}>
      <View style={styles.slideEmojiWrap}>
        <Text style={styles.slideEmoji}>{slide.emoji}</Text>
      </View>
      <View style={styles.slideCounter}>
        <Text style={styles.slideCountText}>{index + 1} / {total}</Text>
      </View>
      <Text style={styles.slideTitle}>{slide.title}</Text>
      <Text style={styles.slideBody}>{slide.body}</Text>

      {slide.code && (
        <View style={styles.codeCard}>
          <View style={styles.codeHeader}>
            <View style={styles.codeTraffic}>
              {['#FF5F56', '#FFBD2E', '#27C93F'].map((c, i) => (
                <View key={i} style={[styles.codeTrafficDot, { backgroundColor: c }]} />
              ))}
            </View>
            <Text style={styles.codeLabel}>Contoh Kod</Text>
          </View>
          <Text style={styles.codeText}>{slide.code}</Text>
        </View>
      )}

      <TouchableOpacity
        style={[styles.nextBtn, isLast && styles.nextBtnGreen]}
        onPress={onNext}
        activeOpacity={0.85}
      >
        <Text style={styles.nextBtnText}>{isLast ? 'Mula Latihan!' : 'Seterusnya'}</Text>
        <Ionicons name={isLast ? 'rocket' : 'arrow-forward'} size={18} color="#fff" />
      </TouchableOpacity>
    </ScrollView>
  );
}

// ── EXERCISE VIEW ────────────────────────────────────────────────────
function ExerciseView({ exercise, onCorrect, onWrong }) {
  const [selected, setSelected] = useState(null);
  const [submitted, setSubmitted] = useState(false);
  const [isCorrect, setIsCorrect] = useState(null);
  const shakeAnim = useRef(new Animated.Value(0)).current;

  const shake = () => {
    Animated.sequence([
      Animated.timing(shakeAnim, { toValue: 10, duration: 60, useNativeDriver: true }),
      Animated.timing(shakeAnim, { toValue: -10, duration: 60, useNativeDriver: true }),
      Animated.timing(shakeAnim, { toValue: 6, duration: 60, useNativeDriver: true }),
      Animated.timing(shakeAnim, { toValue: 0, duration: 60, useNativeDriver: true }),
    ]).start();
  };

  const handleSubmit = () => {
    if (selected === null) return;
    const correct = exercise.type === 'mcq'
      ? selected === exercise.correctIndex
      : (selected === 0) === exercise.correctAnswer;
    setSubmitted(true);
    setIsCorrect(correct);
    if (correct) { setTimeout(onCorrect, 900); }
    else { shake(); setTimeout(onWrong, 1000); }
  };

  const options = exercise.type === 'truefalse' ? ['Benar', 'Salah'] : exercise.options;

  const getOptionState = (i) => {
    if (!submitted) return selected === i ? 'selected' : 'idle';
    const correct = exercise.type === 'mcq' ? i === exercise.correctIndex : (i === 0) === exercise.correctAnswer;
    if (correct) return 'correct';
    if (selected === i) return 'wrong';
    return 'idle';
  };

  const optionStyles = {
    idle: { border: C.border, bg: C.surface, textColor: C.text },
    selected: { border: C.primary, bg: C.primaryBg, textColor: C.primary },
    correct: { border: C.success, bg: C.successBg, textColor: C.success },
    wrong: { border: C.danger, bg: C.dangerBg, textColor: C.danger },
  };

  return (
    <Animated.View style={[{ flex: 1 }, { transform: [{ translateX: shakeAnim }] }]}>
      <ScrollView contentContainerStyle={styles.exScroll} showsVerticalScrollIndicator={false}>
        <View style={styles.questionCard}>
          <View style={styles.questionBadge}>
            <Ionicons name="help-circle" size={14} color={C.violet} />
            <Text style={styles.questionBadgeText}>SOALAN</Text>
          </View>
          <Text style={styles.questionText}>{exercise.question}</Text>
        </View>

        <View style={{ gap: 10 }}>
          {options.map((opt, i) => {
            const state = getOptionState(i);
            const s = optionStyles[state];
            const icon = state === 'correct' ? 'checkmark-circle' : state === 'wrong' ? 'close-circle' : state === 'selected' ? 'ellipse' : 'ellipse-outline';
            const iconColor = state === 'correct' ? C.success : state === 'wrong' ? C.danger : state === 'selected' ? C.primary : C.border;
            return (
              <TouchableOpacity
                key={i}
                style={[styles.option, { borderColor: s.border, backgroundColor: s.bg }]}
                onPress={() => !submitted && setSelected(i)}
                disabled={submitted}
                activeOpacity={0.75}
              >
                <Ionicons name={icon} size={20} color={iconColor} />
                <Text style={[styles.optionText, { color: s.textColor }]}>{opt}</Text>
              </TouchableOpacity>
            );
          })}
        </View>

        {submitted && exercise.explanation && (
          <View style={[styles.explanationBox, { borderColor: isCorrect ? C.success : C.danger }]}>
            <View style={styles.explanationHeader}>
              <Ionicons name={isCorrect ? 'checkmark-circle' : 'close-circle'} size={18} color={isCorrect ? C.success : C.danger} />
              <Text style={[styles.explanationTitle, { color: isCorrect ? C.success : C.danger }]}>
                {isCorrect ? 'Betul!' : 'Salah!'}
              </Text>
            </View>
            <Text style={styles.explanationText}>{exercise.explanation}</Text>
          </View>
        )}

        {!submitted && (
          <TouchableOpacity
            style={[styles.submitBtn, selected === null && styles.submitBtnDisabled]}
            onPress={handleSubmit}
            disabled={selected === null}
            activeOpacity={0.85}
          >
            <Text style={styles.submitBtnText}>Semak Jawapan</Text>
            <Ionicons name="send" size={16} color="#fff" />
          </TouchableOpacity>
        )}
      </ScrollView>
    </Animated.View>
  );
}

// ── COMPLETION ───────────────────────────────────────────────────────
function CompletionView({ lesson, xpEarned, onGoBack }) {
  const bounceAnim = useRef(new Animated.Value(0.5)).current;
  React.useEffect(() => {
    Animated.spring(bounceAnim, { toValue: 1, tension: 40, friction: 5, useNativeDriver: true }).start();
  }, []);
  return (
    <View style={styles.completionWrap}>
      <Animated.View style={{ transform: [{ scale: bounceAnim }], alignItems: 'center' }}>
        <View style={styles.completionCircle}>
          <Ionicons name="trophy" size={56} color={C.gold} />
        </View>
        <Text style={styles.completionTitle}>Tahniah! 🎉</Text>
        <Text style={styles.completionSub}>{lesson.title} selesai!</Text>
        <View style={styles.xpEarnedCard}>
          <Ionicons name="star" size={24} color={C.gold} />
          <Text style={styles.xpEarnedText}>+{xpEarned} XP</Text>
        </View>
      </Animated.View>
      <TouchableOpacity style={styles.doneBtn} onPress={onGoBack} activeOpacity={0.85}>
        <Text style={styles.doneBtnText}>Kembali ke Pelajaran</Text>
        <Ionicons name="arrow-back" size={18} color="#fff" />
      </TouchableOpacity>
    </View>
  );
}

// ── MAIN SCREEN ──────────────────────────────────────────────────────
export default function LessonScreen({ route, navigation }) {
  const { lessonId } = route.params;
  const lesson = getLessonById(lessonId);
  const { completeLesson, loseHeart, hearts } = useApp();
  const [phase, setPhase] = useState('slides');
  const [slideIdx, setSlideIdx] = useState(0);
  const [exIdx, setExIdx] = useState(0);
  const [done, setDone] = useState(false);

  if (!lesson) return <View style={styles.safe}><Text>Pelajaran tidak dijumpai.</Text></View>;

  const total = phase === 'slides' ? lesson.slides.length : lesson.exercises.length;
  const current = phase === 'slides' ? slideIdx : exIdx;
  const progress = total > 0 ? (current + 1) / total : 0;

  const handleSlideNext = () => {
    if (slideIdx < lesson.slides.length - 1) setSlideIdx(slideIdx + 1);
    else setPhase('exercises');
  };

  const handleCorrect = () => {
    if (exIdx < lesson.exercises.length - 1) setExIdx(exIdx + 1);
    else { completeLesson(lesson.id, lesson.xpReward); setDone(true); }
  };

  const handleWrong = () => {
    loseHeart();
    if (hearts <= 1) {
      Alert.alert('Tiada Nyawa', 'Cuba lagi esok!', [{ text: 'OK', onPress: () => navigation.goBack() }]);
    } else if (exIdx < lesson.exercises.length - 1) {
      setExIdx(exIdx + 1);
    } else {
      completeLesson(lesson.id, lesson.xpReward);
      setDone(true);
    }
  };

  return (
    <SafeAreaView style={styles.safe} edges={['top']}>
      {/* Top bar */}
      <View style={styles.topBar}>
        <TouchableOpacity onPress={() => navigation.goBack()} style={styles.closeBtn}>
          <Ionicons name="close" size={22} color={C.textSub} />
        </TouchableOpacity>
        <View style={styles.topProgress}>
          <View style={styles.topProgressBg}>
            <View style={[styles.topProgressFill, { width: `${progress * 100}%` }]} />
          </View>
        </View>
        <View style={styles.topHearts}>
          {Array.from({ length: Math.min(hearts, 5) }).map((_, i) => (
            <Ionicons key={i} name="heart" size={16} color="#FF6B6B" />
          ))}
        </View>
      </View>

      {/* Phase label */}
      <View style={styles.phaseRow}>
        <View style={[styles.phasePill, { backgroundColor: phase === 'slides' ? C.primaryBg : C.violetBg }]}>
          <Ionicons name={phase === 'slides' ? 'book-outline' : 'help-circle-outline'} size={13} color={phase === 'slides' ? C.primary : C.violet} />
          <Text style={[styles.phaseText, { color: phase === 'slides' ? C.primary : C.violet }]}>
            {phase === 'slides' ? `Pembelajaran ${slideIdx + 1}/${lesson.slides.length}` : `Latihan ${exIdx + 1}/${lesson.exercises.length}`}
          </Text>
        </View>
      </View>

      {done ? (
        <CompletionView lesson={lesson} xpEarned={lesson.xpReward} onGoBack={() => navigation.goBack()} />
      ) : phase === 'slides' ? (
        <SlideView slide={lesson.slides[slideIdx]} index={slideIdx} total={lesson.slides.length}
          onNext={handleSlideNext} isLast={slideIdx === lesson.slides.length - 1} />
      ) : (
        <ExerciseView key={exIdx} exercise={lesson.exercises[exIdx]} onCorrect={handleCorrect} onWrong={handleWrong} />
      )}
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safe: { flex: 1, backgroundColor: C.bg },

  // Top bar
  topBar: { flexDirection: 'row', alignItems: 'center', paddingHorizontal: 16, paddingVertical: 12, backgroundColor: C.surface, borderBottomWidth: 1, borderBottomColor: C.divider },
  closeBtn: { width: 36, height: 36, borderRadius: 18, backgroundColor: C.bg, alignItems: 'center', justifyContent: 'center' },
  topProgress: { flex: 1, marginHorizontal: 12 },
  topProgressBg: { height: 8, backgroundColor: C.border, borderRadius: R.full, overflow: 'hidden' },
  topProgressFill: { height: '100%', backgroundColor: C.primary, borderRadius: R.full },
  topHearts: { flexDirection: 'row', gap: 2 },

  // Phase
  phaseRow: { paddingHorizontal: 16, paddingTop: 12 },
  phasePill: { flexDirection: 'row', alignItems: 'center', gap: 5, alignSelf: 'flex-start', paddingHorizontal: 12, paddingVertical: 5, borderRadius: R.full },
  phaseText: { fontSize: 12, fontWeight: '700' },

  // Slide
  slideScroll: { padding: 20, paddingBottom: 40 },
  slideEmojiWrap: { width: 90, height: 90, borderRadius: 45, backgroundColor: C.primaryBg, alignItems: 'center', justifyContent: 'center', alignSelf: 'center', marginTop: 8, marginBottom: 16, ...S.sm },
  slideEmoji: { fontSize: 48 },
  slideCounter: { alignSelf: 'center', backgroundColor: C.bg, borderRadius: R.full, paddingHorizontal: 12, paddingVertical: 4, marginBottom: 16 },
  slideCountText: { fontSize: 12, fontWeight: '700', color: C.textMuted },
  slideTitle: { fontSize: 24, fontWeight: '800', color: C.text, textAlign: 'center', marginBottom: 14, lineHeight: 30 },
  slideBody: { fontSize: 15, color: C.textSub, lineHeight: 24, marginBottom: 20 },
  codeCard: { backgroundColor: '#1E1E2E', borderRadius: R.md, marginBottom: 24, overflow: 'hidden' },
  codeHeader: { flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', paddingHorizontal: 14, paddingVertical: 10, borderBottomWidth: 1, borderBottomColor: 'rgba(255,255,255,0.08)' },
  codeTraffic: { flexDirection: 'row', gap: 6 },
  codeTrafficDot: { width: 11, height: 11, borderRadius: 6 },
  codeLabel: { fontSize: 11, color: 'rgba(255,255,255,0.4)', fontWeight: '600' },
  codeText: { color: '#A6E22E', fontFamily: 'monospace', fontSize: 13, lineHeight: 21, padding: 14 },
  nextBtn: { backgroundColor: C.primary, borderRadius: R.md, paddingVertical: 15, flexDirection: 'row', alignItems: 'center', justifyContent: 'center', gap: 8 },
  nextBtnGreen: { backgroundColor: C.success },
  nextBtnText: { color: '#fff', fontWeight: '800', fontSize: 16 },

  // Exercise
  exScroll: { padding: 20, paddingBottom: 40, gap: 12 },
  questionCard: { backgroundColor: C.surface, borderRadius: R.lg, padding: 20, ...S.sm },
  questionBadge: { flexDirection: 'row', alignItems: 'center', gap: 5, backgroundColor: C.violetBg, alignSelf: 'flex-start', borderRadius: R.full, paddingHorizontal: 10, paddingVertical: 4, marginBottom: 12 },
  questionBadgeText: { fontSize: 11, fontWeight: '800', color: C.violet, letterSpacing: 0.5 },
  questionText: { fontSize: 18, fontWeight: '700', color: C.text, lineHeight: 26 },
  option: { flexDirection: 'row', alignItems: 'center', gap: 12, padding: 15, borderRadius: R.md, borderWidth: 2 },
  optionText: { fontSize: 15, fontWeight: '600', flex: 1 },
  explanationBox: { backgroundColor: C.surface, borderRadius: R.md, padding: 14, borderWidth: 2 },
  explanationHeader: { flexDirection: 'row', alignItems: 'center', gap: 6, marginBottom: 6 },
  explanationTitle: { fontSize: 15, fontWeight: '800' },
  explanationText: { fontSize: 13, color: C.textSub, lineHeight: 20 },
  submitBtn: { backgroundColor: C.primary, borderRadius: R.md, paddingVertical: 15, flexDirection: 'row', alignItems: 'center', justifyContent: 'center', gap: 8, marginTop: 4 },
  submitBtnDisabled: { backgroundColor: C.border },
  submitBtnText: { color: '#fff', fontWeight: '800', fontSize: 16 },

  // Completion
  completionWrap: { flex: 1, alignItems: 'center', justifyContent: 'space-between', padding: 32, paddingBottom: 48 },
  completionCircle: { width: 130, height: 130, borderRadius: 65, backgroundColor: C.goldLight, alignItems: 'center', justifyContent: 'center', marginBottom: 24, ...S.md },
  completionTitle: { fontSize: 36, fontWeight: '800', color: C.text, marginBottom: 8 },
  completionSub: { fontSize: 17, color: C.textSub, marginBottom: 28 },
  xpEarnedCard: { flexDirection: 'row', alignItems: 'center', gap: 10, backgroundColor: C.goldLight, borderRadius: R.xl, paddingHorizontal: 28, paddingVertical: 16 },
  xpEarnedText: { fontSize: 28, fontWeight: '800', color: C.goldDark },
  doneBtn: { backgroundColor: C.primary, borderRadius: R.md, paddingVertical: 15, paddingHorizontal: 32, flexDirection: 'row', alignItems: 'center', gap: 8, width: '100%', justifyContent: 'center' },
  doneBtnText: { color: '#fff', fontWeight: '800', fontSize: 16 },
});
