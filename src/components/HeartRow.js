import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

export default function HeartRow({ hearts, max = 5 }) {
  return (
    <View style={styles.row}>
      {Array.from({ length: max }).map((_, i) => (
        <Text key={i} style={[styles.heart, i >= hearts && styles.empty]}>
          {i < hearts ? '❤️' : '🖤'}
        </Text>
      ))}
    </View>
  );
}

const styles = StyleSheet.create({
  row: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  heart: {
    fontSize: 20,
    marginRight: 4,
  },
  empty: {
    opacity: 0.3,
  },
});
