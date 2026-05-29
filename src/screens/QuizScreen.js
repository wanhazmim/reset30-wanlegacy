import React, { useState, useMemo } from 'react';
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  SafeAreaView,
  ScrollView,
} from 'react-native';
import { useApp } from '../context/AppContext';
import { getAllLessons } from '../data/courses';

function shuffleArray(arr) {
  const a = [...arr];
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

export default function QuizScreen({ navigation }) {
  const { loseHeart, hearts } = useApp();

  const questions = useMemo(() => {
    const allLessons = getAllLessons();
    const allExercises = allLessons.flatMap((l) => l.exercises);
    return shuffleArray(allExercises).slice(0, 10);
  }, []);

  const [index, setIndex] = useState(0);
  const [selectedAnswer, setSelectedAnswer] = useState(null);
  const [answered, setAnswered] = useState(false);
  const [isCorrect, setIsCorrect] = useState(null);
  const [correctCount, setCorrectCount] = useState(0);
  const [done, setDone] = useState(false);

  const question = questions[index];

  const handleAnswer = (answer) => {
    if (answered) return;
    const exercise = question;
    const correct =
      exercise.type === 'mcq'
        ? answer === exercise.correctIndex
        : answer === exercise.correctAnswer;

    setSelectedAnswer(answer);
    setAnswered(true);
    setIsCorrect(correct);

    if (!correct) {
      loseHeart();
    } else {
      setCorrectCount((c) => c + 1);
    }
  };

  const handleNext = () => {
    if (index < questions.length - 1) {
      setIndex((i) => i + 1);
      setSelectedAnswer(null);
      setAnswered(false);
      setIsCorrect(null);
    } else {
      setDone(true);
    }
  };

  const accuracy = Math.round((correctCount / questions.length) * 100);

  if (done) {
    return (
      <SafeAreaView style={styles.safe}>
        <View style={styles.doneScreen}>
          <Text style={styles.doneEmoji}>🏆</Text>
          <Text style={styles.doneTitle}>Cabaran Selesai!</Text>
          <Text style={styles.doneSub}>Keputusan kamu:</Text>
          <View style={styles.statsRow}>
            <View style={styles.statBox}>
              <Text style={styles.statVal}>{correctCount}/{questions.length}</Text>
              <Text style={styles.statLabel}>Betul</Text>
            </View>
            <View style={styles.statBox}>
              <Text style={styles.statVal}>{accuracy}%</Text>
              <Text style={styles.statLabel}>Tepat</Text>
            </View>
          </View>
          <TouchableOpacity style={styles.backBtn} onPress={() => navigation.goBack()}>
            <Text style={styles.backBtnText}>Kembali</Text>
          </TouchableOpacity>
        </View>
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView style={styles.safe}>
      {/* Header */}
      <View style={styles.topBar}>
        <TouchableOpacity onPress={() => navigation.goBack()} style={styles.closeBtn}>
          <Text style={styles.closeText}>✕</Text>
        </TouchableOpacity>
        <View style={styles.progressBarBg}>
          <View
            style={[styles.progressBarFill, { width: `${((index + 1) / questions.length) * 100}%` }]}
          />
        </View>
        <View style={styles.heartsRow}>
          <Text style={styles.heartIcon}>❤️</Text>
          <Text style={styles.heartsCount}>{hearts}</Text>
        </View>
      </View>

      <ScrollView contentContainerStyle={styles.content}>
        <Text style={styles.quizLabel}>🧪 Cabaran</Text>
        <Text style={styles.counter}>
          Soalan {index + 1} daripada {questions.length}
        </Text>
        <Text style={styles.question}>{question.question}</Text>

        {question.type === 'mcq' && (
          <View>
            {question.options.map((opt, i) => {
              let optStyle = styles.option;
              if (answered) {
                if (i === question.correctIndex) optStyle = [styles.option, styles.correct];
                else if (i === selectedAnswer) optStyle = [styles.option, styles.wrong];
              } else if (i === selectedAnswer) {
                optStyle = [styles.option, styles.selected];
              }
              return (
                <TouchableOpacity
                  key={i}
                  style={optStyle}
                  onPress={() => handleAnswer(i)}
                  activeOpacity={answered ? 1 : 0.7}
                >
                  <Text style={styles.optText}>{opt}</Text>
                </TouchableOpacity>
              );
            })}
          </View>
        )}

        {question.type === 'truefalse' && (
          <View style={styles.tfRow}>
            {[true, false].map((val) => {
              let optStyle = styles.tfOpt;
              if (answered) {
                if (val === question.correctAnswer) optStyle = [styles.tfOpt, styles.correct];
                else if (selectedAnswer === val) optStyle = [styles.tfOpt, styles.wrong];
              } else if (selectedAnswer === val) {
                optStyle = [styles.tfOpt, styles.selected];
              }
              return (
                <TouchableOpacity
                  key={String(val)}
                  style={optStyle}
                  onPress={() => handleAnswer(val)}
                  activeOpacity={answered ? 1 : 0.7}
                >
                  <Text style={[styles.tfText, val ? styles.tfTrue : styles.tfFalse]}>
                    {val ? 'BETUL ✓' : 'SALAH ✗'}
                  </Text>
                </TouchableOpacity>
              );
            })}
          </View>
        )}

        {answered && (
          <View style={[styles.feedback, isCorrect ? styles.fbCorrect : styles.fbWrong]}>
            <Text style={styles.fbTitle}>{isCorrect ? '✅ Betul!' : '❌ Salah!'}</Text>
            <Text style={styles.fbExp}>{question.explanation}</Text>
            <TouchableOpacity style={styles.nextBtn} onPress={handleNext}>
              <Text style={styles.nextBtnText}>
                {index < questions.length - 1 ? 'Seterusnya →' : 'Selesai!'}
              </Text>
            </TouchableOpacity>
          </View>
        )}
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safe: { flex: 1, backgroundColor: '#F0FDF9' },
  topBar: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 12,
    paddingVertical: 10,
    backgroundColor: '#fff',
    elevation: 2,
    shadowColor: '#000',
    shadowOpacity: 0.05,
    shadowRadius: 4,
    shadowOffset: { width: 0, height: 2 },
  },
  closeBtn: {
    width: 36,
    height: 36,
    borderRadius: 18,
    backgroundColor: '#f3f4f6',
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: 10,
  },
  closeText: { fontSize: 16, color: '#374151', fontWeight: 'bold' },
  progressBarBg: {
    flex: 1,
    backgroundColor: '#e5e7eb',
    borderRadius: 6,
    height: 10,
    overflow: 'hidden',
  },
  progressBarFill: {
    backgroundColor: '#F59E0B',
    height: '100%',
    borderRadius: 6,
  },
  heartsRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginLeft: 10,
  },
  heartIcon: { fontSize: 16 },
  heartsCount: { fontSize: 15, fontWeight: 'bold', color: '#ef4444', marginLeft: 3 },
  content: { padding: 20, paddingBottom: 40 },
  quizLabel: {
    fontSize: 12,
    color: '#F59E0B',
    fontWeight: 'bold',
    textTransform: 'uppercase',
    letterSpacing: 1,
    marginBottom: 4,
  },
  counter: { fontSize: 13, color: '#6b7280', marginBottom: 16 },
  question: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#1f2937',
    marginBottom: 24,
    lineHeight: 28,
  },
  option: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    borderWidth: 2,
    borderColor: '#e5e7eb',
    marginBottom: 10,
  },
  selected: { borderColor: '#F59E0B', backgroundColor: '#FFFBEB' },
  correct: { borderColor: '#22c55e', backgroundColor: '#f0fdf4' },
  wrong: { borderColor: '#ef4444', backgroundColor: '#fef2f2' },
  optText: { fontSize: 16, color: '#374151' },
  tfRow: { flexDirection: 'row', gap: 12 },
  tfOpt: {
    flex: 1,
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 20,
    borderWidth: 2,
    borderColor: '#e5e7eb',
    alignItems: 'center',
  },
  tfText: { fontSize: 16, fontWeight: 'bold' },
  tfTrue: { color: '#16a34a' },
  tfFalse: { color: '#dc2626' },
  feedback: {
    marginTop: 20,
    borderRadius: 16,
    padding: 20,
    borderTopWidth: 2,
  },
  fbCorrect: { backgroundColor: '#f0fdf4', borderTopColor: '#22c55e' },
  fbWrong: { backgroundColor: '#fef2f2', borderTopColor: '#ef4444' },
  fbTitle: { fontSize: 20, fontWeight: 'bold', color: '#1f2937', marginBottom: 8 },
  fbExp: { fontSize: 15, color: '#374151', lineHeight: 22, marginBottom: 16 },
  nextBtn: {
    backgroundColor: '#F59E0B',
    borderRadius: 12,
    paddingVertical: 14,
    alignItems: 'center',
  },
  nextBtnText: { color: '#fff', fontWeight: 'bold', fontSize: 16 },
  doneScreen: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: 28,
  },
  doneEmoji: { fontSize: 72, marginBottom: 16 },
  doneTitle: { fontSize: 28, fontWeight: 'bold', color: '#F59E0B', marginBottom: 6 },
  doneSub: { fontSize: 16, color: '#6b7280', marginBottom: 24 },
  statsRow: { flexDirection: 'row', gap: 16, marginBottom: 32 },
  statBox: {
    alignItems: 'center',
    backgroundColor: '#fff',
    borderRadius: 16,
    padding: 20,
    elevation: 2,
    shadowColor: '#000',
    shadowOpacity: 0.05,
    shadowRadius: 6,
    shadowOffset: { width: 0, height: 2 },
    minWidth: 120,
  },
  statVal: { fontSize: 28, fontWeight: 'bold', color: '#F59E0B', marginBottom: 4 },
  statLabel: { fontSize: 13, color: '#6b7280' },
  backBtn: {
    backgroundColor: '#0D9488',
    borderRadius: 12,
    paddingVertical: 14,
    paddingHorizontal: 40,
    alignItems: 'center',
  },
  backBtnText: { color: '#fff', fontWeight: 'bold', fontSize: 16 },
});
