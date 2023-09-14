import React from 'react';
import {StyleSheet, Text, TouchableOpacity, View} from 'react-native';
import WeCamera from './module/WeCamera';

export default function App() {
  function handleOpenImagePicker() {
    WeCamera.openImagePicker();
  }

  return (
    <View style={styles.container}>
      <TouchableOpacity style={styles.button} onPress={handleOpenImagePicker}>
        <Text>Open image picker</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    padding: 30,
    justifyContent: 'center',
    alignContent: 'center',
    height: '100%',
    width: '100%',
  },
  button: {
    padding: 16,
    borderRadius: 8,
    backgroundColor: 'lightgrey',
  },
});
