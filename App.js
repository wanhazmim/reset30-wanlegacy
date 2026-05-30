import React, { useEffect } from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { View, StyleSheet } from 'react-native';
import { StatusBar } from 'expo-status-bar';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { GestureHandlerRootView } from 'react-native-gesture-handler';
import { Ionicons } from '@expo/vector-icons';
import { AppProvider, useApp } from './src/context/AppContext';
import { C, S } from './src/theme';

import SplashScreen from './src/screens/SplashScreen';
import OnboardingScreen from './src/screens/OnboardingScreen';
import HomeScreen from './src/screens/HomeScreen';
import LearningPathScreen from './src/screens/LearningPathScreen';
import LessonScreen from './src/screens/LessonScreen';
import ProfileScreen from './src/screens/ProfileScreen';
import LeaderboardScreen from './src/screens/LeaderboardScreen';

const Stack = createNativeStackNavigator();
const Tab = createBottomTabNavigator();

const TABS = [
  { name: 'Home',        label: 'Utama',   icon: 'home',    component: HomeScreen },
  { name: 'Learn',       label: 'Belajar', icon: 'book',    component: LearningPathScreen },
  { name: 'Leaderboard', label: 'Ranking', icon: 'trophy',  component: LeaderboardScreen },
  { name: 'Profile',     label: 'Profil',  icon: 'person',  component: ProfileScreen },
];

function TabIcon({ name, focused }) {
  return (
    <View style={[styles.tabIconWrap, focused && styles.tabIconActive]}>
      <Ionicons
        name={focused ? name : `${name}-outline`}
        size={22}
        color={focused ? C.primary : C.textMuted}
      />
    </View>
  );
}

function MainTabs() {
  return (
    <Tab.Navigator
      screenOptions={{
        headerShown: false,
        tabBarStyle: styles.tabBar,
        tabBarActiveTintColor: C.primary,
        tabBarInactiveTintColor: C.textMuted,
        tabBarLabelStyle: styles.tabLabel,
        tabBarItemStyle: styles.tabItem,
      }}
    >
      {TABS.map(tab => (
        <Tab.Screen
          key={tab.name}
          name={tab.name}
          component={tab.component}
          options={{
            tabBarLabel: tab.label,
            tabBarIcon: ({ focused }) => <TabIcon name={tab.icon} focused={focused} />,
          }}
        />
      ))}
    </Tab.Navigator>
  );
}

function RootNavigator() {
  const { init } = useApp();
  useEffect(() => { init(); }, []);

  return (
    <>
      <StatusBar style="light" />
      <Stack.Navigator screenOptions={{ headerShown: false, animation: 'fade' }}>
        <Stack.Screen name="Splash"      component={SplashScreen} />
        <Stack.Screen name="Onboarding"  component={OnboardingScreen} />
        <Stack.Screen name="Main"        component={MainTabs} />
        <Stack.Screen name="Lesson"      component={LessonScreen}
          options={{ animation: 'slide_from_bottom', gestureEnabled: false }} />
      </Stack.Navigator>
    </>
  );
}

export default function App() {
  return (
    <GestureHandlerRootView style={{ flex: 1 }}>
      <SafeAreaProvider>
        <AppProvider>
          <NavigationContainer>
            <RootNavigator />
          </NavigationContainer>
        </AppProvider>
      </SafeAreaProvider>
    </GestureHandlerRootView>
  );
}

const styles = StyleSheet.create({
  tabBar: {
    backgroundColor: C.surface,
    borderTopWidth: 0,
    height: 72,
    paddingBottom: 10,
    paddingTop: 8,
    paddingHorizontal: 8,
    ...S.lg,
  },
  tabItem: { borderRadius: 16 },
  tabLabel: { fontSize: 11, fontWeight: '600', marginTop: 2 },
  tabIconWrap: {
    width: 40, height: 32,
    alignItems: 'center', justifyContent: 'center',
    borderRadius: 12,
  },
  tabIconActive: {
    backgroundColor: C.primaryBg,
  },
});
