import React, {useMemo, useState} from 'react';

import WeCamera from './module/WeCamera';

import {Button, ButtonText, Container, ImageView} from './styles';
import {PermissionsAndroid} from 'react-native';

export default function App() {
  const [selectedImageUri, setSelectedImageUri] = useState<
    string | undefined
  >();
  const [imageId, setImageId] = useState<number>(0);

  // Use useMemo para criar uma chave única para o ImageView sempre que a imagem for alterada
  const imageViewKey = useMemo(() => imageId.toString(), [imageId]);

  const handleOpenImagePicker = async () => {
    try {
      const response = await WeCamera.openGallery();
      if (response) {
        setSelectedImageUri(response);
        // Atualiza o ID da imagem para forçar a recriação do componente ImageView
        setImageId(imageId + 1);
      }
    } catch (err) {
      console.log(err);
    }
  };

  const handleOpenCamera = async () => {
    await requestCameraPermission();
    try {
      const response = await WeCamera.openCamera();
      if (response) {
        setSelectedImageUri(response);
        // Atualiza o ID da imagem para forçar a recriação do componente ImageView
        setImageId(imageId + 1);
      }
    } catch (err) {
      console.log(err);
    }
  };

  const handleRemoveImage = () => {
    setSelectedImageUri(undefined);
    // Atualiza o ID da imagem para forçar a recriação do componente ImageView
    setImageId(imageId + 1);
  };

  const requestCameraPermission = async () => {
    const hasPermission = await PermissionsAndroid.check(
      PermissionsAndroid.PERMISSIONS.CAMERA,
    );

    if (!hasPermission) {
      PermissionsAndroid.request(PermissionsAndroid.PERMISSIONS.CAMERA);
    }

    return;
  };

  return (
    <Container>
      <Button onPress={handleOpenCamera}>
        <ButtonText>Open Camera</ButtonText>
      </Button>
      <Button onPress={handleOpenImagePicker}>
        <ButtonText>Open image picker</ButtonText>
      </Button>
      {selectedImageUri && (
        <>
          <Button onPress={handleRemoveImage}>
            <ButtonText>Remove Image</ButtonText>
          </Button>
          <ImageView key={imageViewKey} source={{uri: selectedImageUri}} />
        </>
      )}
    </Container>
  );
}
