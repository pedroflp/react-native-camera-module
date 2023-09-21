import {StyleSheet, Text, TouchableOpacity, View} from 'react-native';
import React from 'react';

import WeCamera from './module/WeCamera';

export default function App() {
  const handleOpenImagePicker = async () => {
    try {
      await WeCamera.openImagePicker();
    } catch (err) {
      console.log(err);
    }
  };

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
