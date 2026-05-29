import React, { useState, useRef } from 'react';
import {
  View, Text, StyleSheet, ScrollView, TouchableOpacity,
  Animated, Dimensions, Alert,
} from 'react-native';
import { useApp } from '../context/AppContext';
import { getLessonById } from '../data/courses';

const { width } = Dimensions.get('window');

function SlideView({ slide, index, total, onNext, isLast }) {
  return (
    <ScrollView contentContainerStyle={styles.slideContent} showsVerticalScrollIndicator={false}>
      <Text style={styles.slideCount}>{index + 1} / {total}</Text>
      <Text style={styles.slideEmoji}>{slide.emoji}</Text>
      <Text style={styles.slideTitle}>{slide.title}</Text>
      <Text style={styles.slideBody}>{slide.body}</Text>
      {slide.code && (
        <View style={styles.codeBlock}>
          <Text style={styles.codeText}>{slide.code}</Text>
        </View>
      )}
      <TouchableOpacity style={[styles.nextSlideBtn, isLast && styles.nextSlideBtnGreen]} onPress={onNext}>
        <Text style={styles.nextSlideBtnText}>
          {isLast ? '✅ Mula Latihan!' : 'Seterusnya →'}
        </Text>
      </TouchableOpacity>
    </ScrollView>
  );
}

function ExerciseView({ exercise, onCorrect, onWrong }) {
  const [selected, setSelected] = useState(null);
  const [submitted, setSubmitted] = useState(false);
  const shakeAnim = useRef(new Animated.Value(0)).current;

  const shake = () => {
    Animated.sequence([
      Animated.timing(shakeAnim, { toValue: 10, duration: 60, useNativeDriver: true }),
      Animated.timing(shakeAnim, { toValue: -10, duration: 60, useNativeDriver: true }),
      Animated.timing(shakeAnim, { toValue: 8, duration: 60, useNativeDriver: true }),
      Animated.timing(shakeAnim, { toValue: 0, duration: 60, useNativeDriver: true }),
    ]).start();
  };

  const handleSubmit = () => {
    if (selected === null) return;
    setSubmitted(true);
    const isCorrect = exercise.type === 'mcq'
      ? selected === exercise.correctIndex
      : (selected === 0) === exercise.correctAnswer;
    if (isCorrect) {
      setTimeout(() => onCorrect(), 900);
    } else {
      shake();
      setTimeout(() => onWrong(), 1000);
    }
  };

  const getOptionStyle = (i) => {
    if (!submitted) return selected === i ? styles.optionSelected : styles.option;
    const isCorrect = exercise.type === 'mcq'
      ? i === exercise.correctIndex
      : (i === 0) === exercise.correctAnswer;
    if (isCorrect) return styles.optionCorrect;
    if (selected === i) return styles.optionWrong;
    return styles.option;
  };

  const options = exercise.type === 'truefalse'
    ? ['Benar ✅', 'Salah ❌']
    : exercise.options;

  return (
    <Animated.View style={[styles.exerciseWrap, { transform: [{ translateX: shakeAnim }] }]}>
      <ScrollView contentContainerStyle={styles.exerciseContent} showsVerticalScrollIndicator={false}>
        <View style={styles.questionCard}>
          <Text style={styles.questionLabel}>❓ Soalan</Text>
          <Text style={styles.questionText}>{exercise.question}</Text>
        </View>

        <View style={styles.optionsWrap}>
          {options.map((opt, i) => (
            <TouchableOpacity
              key={i}
              style={getOptionStyle(i)}
              onPress={() => !submitted && setSelected(i)}
              disabled={submitted}
            >
              <View style={styles.optionRow}>
                <View style={[styles.optionBullet, selected === i && !submitted && styles.optionBulletSelected]}>
                  <Text style={styles.optionBulletText}>{String.fromCharCode(65 + i)}</Text>
                </View>
                <Text style={[styles.optionText, selected === i && !submitted && { color: '#0D9488', fontWeight: '700' }]}>
                  {opt}
                </Text>
              </View>
            </TouchableOpacity>
          ))}
        </View>

        {submitted && exercise.explanation && (
          <View style={styles.explanationBox}>
            <Text style={styles.explanationTitle}>💡 Penjelasan</Text>
            <Text style={styles.explanationText}>{exercise.explanation}</Text>
          </View>
        )}

        {!submitted && (
          <TouchableOpacity
            style={[styles.submitBtn, selected === null && styles.submitBtnDisabled]}
            onPress={handleSubmit}
            disabled={selected === null}
          >
            <Text style={styles.submitBtnText}>Semak Jawapan</Text>
          </TouchableOpacity>
        )}
      </ScrollView>
    </Animated.View>
  );
}

function CompletionView({ lesson, onGoBack, xpEarned }) {
  return (
    <View style={styles.completionWrap}>
      <Text style={styles.completionEmoji}>🎉</Text>
      <Text style={styles.completionTitle}>Tahniah!</Text>
      <Text style={styles.completionSub}>{lesson.title} selesai!</Text>
      <View style={styles.completionXP}>
        <Text style={styles.completionXPText}>+{xpEarned} XP diperolehi!</Text>
      </View>
      <TouchableOpacity style={styles.backBtn} onPress={onGoBack}>
        <Text style={styles.backBtnText}>← Kembali ke Pelajaran</Text>
      </TouchableOpacity>
    </View>
  );
}

export default function LessonScreen({ route, navigation }) {
  const { lessonId } = route.params;
  const lesson = getLessonById(lessonId);
  const { completeLesson, loseHeart, hearts } = useApp();

  const [phase, setPhase] = useState('slides');
  const [slideIndex, setSlideIndex] = useState(0);
  const [exIndex, setExIndex] = useState(0);
  const [completed, setCompleted] = useState(false);
  const [wrongCount, setWrongCount] = useState(0);

  if (!lesson) {
    return (
      <View style={styles.root}>
        <Text>Pelajaran tidak dijumpai.</Text>
      </View>
    );
  }

  const handleSlideNext = () => {
    if (slideIndex < lesson.slides.length - 1) {
      setSlideIndex(slideIndex + 1);
    } else {
      setPhase('exercises');
    }
  };

  const handleCorrect = () => {
    if (exIndex < lesson.exercises.length - 1) {
      setExIndex(exIndex + 1);
    } else {
      completeLesson(lesson.id, lesson.xpReward);
      setCompleted(true);
    }
  };

  const handleWrong = () => {
    loseHeart();
    setWrongCount(wrongCount + 1);
    if (hearts <= 1) {
      Alert.alert('Tiada Nyawa', 'Kamu kehabisan nyawa! Cuba lagi esok.', [
        { text: 'OK', onPress: () => navigation.goBack() },
      ]);
    } else {
      if (exIndex < lesson.exercises.length - 1) {
        setExIndex(exIndex + 1);
      } else {
        completeLesson(lesson.id, Math.max(0, lesson.xpReward - wrongCount * 5));
        setCompleted(true);
      }
    }
  };

  const renderHeader = () => {
    const total = phase === 'slides' ? lesson.slides.length : lesson.exercises.length;
    const current = phase === 'slides' ? slideIndex : exIndex;
    return (
      <View style={styles.topBar}>
        <TouchableOpacity onPress={() => navigation.goBack()} style={styles.closeBtn}>
          <Text style={styles.closeBtnText}>✕</Text>
        </TouchableOpacity>
        <View style={styles.topBarProgress}>
          <View style={styles.topProgressBg}>
            <View style={[styles.topProgressFill, { width: `${((current + 1) / total) * 100}%` }]} />
          </View>
        </View>
        <View style={styles.topBarHearts}>
          {Array.from({ length: Math.min(hearts, 5) }).map((_, i) => (
            <Text key={i} style={{ fontSize: 14 }}>❤️</Text>
          ))}
        </View>
      </View>
    );
  };

  if (completed) {
    return (
      <View style={styles.root}>
        {renderHeader()}
        <CompletionView lesson={lesson} xpEarned={lesson.xpReward} onGoBack={() => navigation.goBack()} />
      </View>
    );
  }

  return (
    <View style={styles.root}>
      {renderHeader()}
      {phase === 'slides' ? (
        <SlideView
          slide={lesson.slides[slideIndex]}
          index={slideIndex}
          total={lesson.slides.length}
          onNext={handleSlideNext}
          isLast={slideIndex === lesson.slides.length - 1}
        />
      ) : (
        <ExerciseView
          key={exIndex}
          exercise={lesson.exercises[exIndex]}
          onCorrect={handleCorrect}
          onWrong={handleWrong}
        />
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  root: { flex: 1, backgroundColor: '#F9FAFB' },
  topBar: {
    flexDirection: 'row', alignItems: 'center', paddingTop: 48,
    paddingHorizontal: 16, paddingBottom: 12, backgroundColor: '#fff',
    borderBottomWidth: 1, borderBottomColor: '#E5E7EB',
  },
  closeBtn: { width: 32, height: 32, alignItems: 'center', justifyContent: 'center' },
  closeBtnText: { fontSize: 18, color: '#6B7280' },
  topBarProgress: { flex: 1, marginHorizontal: 12 },
  topProgressBg: { height: 8, backgroundColor: '#E5E7EB', borderRadius: 4, overflow: 'hidden' },
  topProgressFill: { height: '100%', backgroundColor: '#0D9488', borderRadius: 4 },
  topBarHearts: { flexDirection: 'row' },
  slideContent: { padding: 24, paddingBottom: 60, alignItems: 'center' },
  slideCount: { fontSize: 13, color: '#9CA3AF', marginBottom: 16 },
  slideEmoji: { fontSize: 64, marginBottom: 16 },
  slideTitle: { fontSize: 24, fontWeight: 'bold', color: '#111827', textAlign: 'center', marginBottom: 16 },
  slideBody: { fontSize: 16, color: '#374151', lineHeight: 24, textAlign: 'left', width: '100%', marginBottom: 20 },
  codeBlock: {
    backgroundColor: '#1E1E2E', borderRadius: 12, padding: 16,
    width: '100%', marginBottom: 20,
  },
  codeText: { color: '#A6E22E', fontFamily: 'monospace', fontSize: 13, lineHeight: 20 },
  nextSlideBtn: {
    backgroundColor: '#0D9488', borderRadius: 14,
    paddingHorizontal: 40, paddingVertical: 14,
    width: '100%', alignItems: 'center',
  },
  nextSlideBtnGreen: { backgroundColor: '#059669' },
  nextSlideBtnText: { color: '#fff', fontWeight: 'bold', fontSize: 16 },
  exerciseWrap: { flex: 1 },
  exerciseContent: { padding: 20, paddingBottom: 60 },
  questionCard: {
    backgroundColor: '#fff', borderRadius: 16, padding: 20,
    marginBottom: 20, elevation: 2,
    shadowColor: '#000', shadowOpacity: 0.06, shadowRadius: 6,
    shadowOffset: { width: 0, height: 2 },
  },
  questionLabel: { fontSize: 12, color: '#9CA3AF', fontWeight: '600', marginBottom: 8, textTransform: 'uppercase' },
  questionText: { fontSize: 18, fontWeight: '700', color: '#111827', lineHeight: 26 },
  optionsWrap: { gap: 10, marginBottom: 20 },
  option: {
    backgroundColor: '#fff', borderRadius: 12, padding: 14, borderWidth: 2, borderColor: '#E5E7EB',
    elevation: 1, shadowColor: '#000', shadowOpacity: 0.03, shadowRadius: 3,
  },
  optionSelected: {
    backgroundColor: '#F0FDFA', borderRadius: 12, padding: 14, borderWidth: 2, borderColor: '#0D9488',
  },
  optionCorrect: {
    backgroundColor: '#ECFDF5', borderRadius: 12, padding: 14, borderWidth: 2, borderColor: '#059669',
  },
  optionWrong: {
    backgroundColor: '#FEF2F2', borderRadius: 12, padding: 14, borderWidth: 2, borderColor: '#EF4444',
  },
  optionRow: { flexDirection: 'row', alignItems: 'center' },
  optionBullet: {
    width: 28, height: 28, borderRadius: 14, backgroundColor: '#F3F4F6',
    alignItems: 'center', justifyContent: 'center', marginRight: 12,
  },
  optionBulletSelected: { backgroundColor: '#0D9488' },
  optionBulletText: { fontSize: 12, fontWeight: 'bold', color: '#6B7280' },
  optionText: { fontSize: 15, color: '#374151', flex: 1 },
  submitBtn: {
    backgroundColor: '#0D9488', borderRadius: 14,
    paddingVertical: 14, alignItems: 'center',
  },
  submitBtnDisabled: { backgroundColor: '#D1D5DB' },
  submitBtnText: { color: '#fff', fontWeight: 'bold', fontSize: 16 },
  explanationBox: {
    backgroundColor: '#FFFBEB', borderRadius: 12, padding: 14, marginBottom: 16,
    borderLeftWidth: 4, borderLeftColor: '#F59E0B',
  },
  explanationTitle: { fontSize: 13, fontWeight: '700', color: '#92400E', marginBottom: 4 },
  explanationText: { fontSize: 14, color: '#78350F', lineHeight: 20 },
  completionWrap: { flex: 1, alignItems: 'center', justifyContent: 'center', padding: 32 },
  completionEmoji: { fontSize: 80, marginBottom: 16 },
  completionTitle: { fontSize: 36, fontWeight: 'bold', color: '#059669', marginBottom: 8 },
  completionSub: { fontSize: 18, color: '#6B7280', marginBottom: 24 },
  completionXP: {
    backgroundColor: '#ECFDF5', borderRadius: 14,
    paddingHorizontal: 24, paddingVertical: 14, marginBottom: 32,
  },
  completionXPText: { fontSize: 20, fontWeight: 'bold', color: '#059669' },
  backBtn: {
    backgroundColor: '#0D9488', borderRadius: 14,
    paddingHorizontal: 32, paddingVertical: 14,
  },
  backBtnText: { color: '#fff', fontWeight: 'bold', fontSize: 16 },
});
