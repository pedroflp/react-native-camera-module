import React, {useEffect, useState} from 'react';

import WeCamera from './module/WeCamera';

import {Button, ButtonText, Container, ImageView} from './styles';
import {PermissionsAndroid} from 'react-native';

export default function App() {
  const [selectedImage, setSelectedImage] = useState<string>();
  const handleOpenImagePicker = async () => {
    try {
      const selectedImageUri = await WeCamera.openImagePicker();
      setSelectedImage(selectedImageUri);
    } catch (err) {
      console.log(err);
    }
  };
  const handleCaptureImage = async () => {
    const permission = await PermissionsAndroid.request(
      PermissionsAndroid.PERMISSIONS.CAMERA,
    );

    console.log(permission);
    try {
      const capturedImageUri = await WeCamera.captureImage();
      setSelectedImage(capturedImageUri);
    } catch (err) {
      console.log(err);
    }
  };

  const handleRemoveImage = async () => {
    setSelectedImage(undefined);
  };

  useEffect(() => {}, []);

  return (
    <Container>
      <Button onPress={handleCaptureImage}>
        <ButtonText>Open camera and take photo</ButtonText>
      </Button>
      <Button onPress={handleOpenImagePicker}>
        <ButtonText>Open image picker</ButtonText>
      </Button>
      {selectedImage && (
        <>
          <Button onPress={handleRemoveImage}>
            <ButtonText>Remove Image</ButtonText>
          </Button>
          <ImageView source={{uri: selectedImage}} />
        </>
      )}
    </Container>
  );
}
