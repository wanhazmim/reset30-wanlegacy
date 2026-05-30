// Design tokens for CODE30 premium UI
export const C = {
  // Brand
  primary:      '#0D9488',
  primaryDark:  '#0A7A70',
  primaryMid:   '#14B8A6',
  primaryLight: '#CCFBF1',
  primaryBg:    '#F0FDFA',

  // Accent
  gold:         '#F59E0B',
  goldLight:    '#FEF3C7',
  goldDark:     '#D97706',

  // Semantic
  success:      '#10B981',
  successBg:    '#D1FAE5',
  danger:       '#EF4444',
  dangerBg:     '#FEE2E2',
  violet:       '#7C3AED',
  violetBg:     '#EDE9FE',
  blue:         '#3B82F6',
  blueBg:       '#DBEAFE',
  orange:       '#F97316',
  orangeBg:     '#FFEDD5',

  // Neutral
  bg:           '#F1F5F9',
  surface:      '#FFFFFF',
  surfaceAlt:   '#F8FAFC',
  border:       '#E2E8F0',
  divider:      '#F1F5F9',

  // Text
  text:         '#0F172A',
  textSub:      '#475569',
  textMuted:    '#94A3B8',
  textInverse:  '#FFFFFF',
};

export const R = { xs: 6, sm: 10, md: 16, lg: 20, xl: 28, full: 999 };

export const S = {
  xs: { elevation: 1, shadowColor: '#0F172A', shadowOffset: { width: 0, height: 1 }, shadowOpacity: 0.04, shadowRadius: 3 },
  sm: { elevation: 2, shadowColor: '#0F172A', shadowOffset: { width: 0, height: 2 }, shadowOpacity: 0.06, shadowRadius: 6 },
  md: { elevation: 4, shadowColor: '#0F172A', shadowOffset: { width: 0, height: 4 }, shadowOpacity: 0.08, shadowRadius: 12 },
  lg: { elevation: 8, shadowColor: '#0F172A', shadowOffset: { width: 0, height: 8 }, shadowOpacity: 0.10, shadowRadius: 24 },
};

export const UNIT_COLORS = {
  u1: { primary: '#0D9488', gradient: ['#0D9488', '#0A7A70'], bg: '#F0FDFA', text: '#0D9488' },
  u2: { primary: '#3B82F6', gradient: ['#3B82F6', '#2563EB'], bg: '#DBEAFE', text: '#2563EB' },
  u3: { primary: '#F59E0B', gradient: ['#F59E0B', '#D97706'], bg: '#FEF3C7', text: '#D97706' },
};
