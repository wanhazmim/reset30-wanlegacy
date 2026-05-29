import React, { createContext, useContext, useState, useCallback } from 'react';
import AsyncStorage from '@react-native-async-storage/async-storage';

const STORAGE_KEY = 'code30_user_data';

const defaultState = {
  userName: '',
  xp: 0,
  level: 1,
  hearts: 5,
  streak: 0,
  lastActiveDate: null,
  completedLessons: [],
  dailyXPHistory: {},
  isDarkMode: false,
  language: 'bm',
  isFirstTime: true,
};

const AppContext = createContext(null);

export function AppProvider({ children }) {
  const [state, setState] = useState(defaultState);

  const computeLevel = (xp) => Math.max(1, Math.floor(xp / 200) + 1);

  const getTodayString = () => {
    const d = new Date();
    return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`;
  };

  const getYesterdayString = () => {
    const d = new Date();
    d.setDate(d.getDate() - 1);
    return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`;
  };

  const saveStateToStorage = useCallback(async (newState) => {
    try {
      await AsyncStorage.setItem(STORAGE_KEY, JSON.stringify(newState));
    } catch (e) {
      console.warn('Failed to save state:', e);
    }
  }, []);

  const init = useCallback(async () => {
    try {
      const stored = await AsyncStorage.getItem(STORAGE_KEY);
      if (stored) {
        const parsed = JSON.parse(stored);
        const today = getTodayString();
        let updated = { ...defaultState, ...parsed };

        if (updated.lastActiveDate !== today) {
          const yesterday = getYesterdayString();
          if (updated.lastActiveDate !== yesterday) {
            updated.streak = 0;
          }
          updated.hearts = 5;
        }

        updated.level = computeLevel(updated.xp);
        setState(updated);
      } else {
        setState(defaultState);
      }
    } catch (e) {
      console.warn('Failed to load state:', e);
      setState(defaultState);
    }
  }, []);

  const updateState = useCallback(
    (updater) => {
      setState((prev) => {
        const next = typeof updater === 'function' ? updater(prev) : { ...prev, ...updater };
        next.level = computeLevel(next.xp);
        saveStateToStorage(next);
        return next;
      });
    },
    [saveStateToStorage]
  );

  const completeOnboarding = useCallback(
    (name, lang) => {
      updateState((prev) => ({
        ...prev,
        userName: name,
        language: lang || 'bm',
        isFirstTime: false,
        lastActiveDate: getTodayString(),
      }));
    },
    [updateState]
  );

  const completeLesson = useCallback(
    (lessonId, xpEarned) => {
      updateState((prev) => {
        const today = getTodayString();
        const alreadyDone = prev.completedLessons.includes(lessonId);
        const newCompletedLessons = alreadyDone
          ? prev.completedLessons
          : [...prev.completedLessons, lessonId];

        const newXP = prev.xp + (alreadyDone ? 0 : xpEarned);
        const dailyXP = prev.dailyXPHistory[today] || 0;
        const newDailyXPHistory = {
          ...prev.dailyXPHistory,
          [today]: dailyXP + (alreadyDone ? 0 : xpEarned),
        };

        const yesterday = getYesterdayString();
        let newStreak = prev.streak;
        if (prev.lastActiveDate === today) {
          // already active today
        } else if (prev.lastActiveDate === yesterday) {
          newStreak = prev.streak + 1;
        } else {
          newStreak = 1;
        }

        return {
          ...prev,
          completedLessons: newCompletedLessons,
          xp: newXP,
          dailyXPHistory: newDailyXPHistory,
          streak: newStreak,
          lastActiveDate: today,
        };
      });
    },
    [updateState]
  );

  const loseHeart = useCallback(() => {
    updateState((prev) => ({
      ...prev,
      hearts: Math.max(0, prev.hearts - 1),
    }));
  }, [updateState]);

  const refillHearts = useCallback(() => {
    updateState((prev) => ({ ...prev, hearts: 5 }));
  }, [updateState]);

  const resetProgress = useCallback(() => {
    const fresh = { ...defaultState, isFirstTime: false };
    saveStateToStorage(fresh);
    setState(fresh);
  }, [saveStateToStorage]);

  const checkAndUpdateStreak = useCallback(() => {
    updateState((prev) => {
      const today = getTodayString();
      const yesterday = getYesterdayString();
      if (prev.lastActiveDate === yesterday) {
        return { ...prev, streak: prev.streak + 1, lastActiveDate: today };
      } else if (prev.lastActiveDate !== today) {
        return { ...prev, streak: 0 };
      }
      return prev;
    });
  }, [updateState]);

  const checkNewDay = useCallback(() => {
    updateState((prev) => {
      const today = getTodayString();
      if (prev.lastActiveDate !== today) {
        return { ...prev, hearts: 5 };
      }
      return prev;
    });
  }, [updateState]);

  const setDarkMode = useCallback(
    (val) => {
      updateState((prev) => ({ ...prev, isDarkMode: val }));
    },
    [updateState]
  );

  const value = {
    ...state,
    init,
    completeOnboarding,
    completeLesson,
    loseHeart,
    refillHearts,
    resetProgress,
    checkAndUpdateStreak,
    checkNewDay,
    setDarkMode,
  };

  return <AppContext.Provider value={value}>{children}</AppContext.Provider>;
}

export function useApp() {
  const ctx = useContext(AppContext);
  if (!ctx) throw new Error('useApp must be used within AppProvider');
  return ctx;
}
