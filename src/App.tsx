import React, {useState} from 'react';

import WeCamera from './module/WeCamera';

import {Button, ButtonText, Container, ImageView} from './styles';

export default function App() {
  const [selectedImageUri, setSelectedImageUri] = useState<string>();
  const handleOpenImagePicker = async () => {
    try {
      const reponse = await WeCamera.openImagePicker();
      setSelectedImageUri(reponse);
    } catch (err) {
      console.log(err);
    }
  };

  const handleRemoveImage = async () => {
    setSelectedImageUri(undefined);
  };

  return (
    <Container>
      <Button onPress={handleOpenImagePicker}>
        <ButtonText>Open image picker</ButtonText>
      </Button>
      {selectedImageUri && (
        <>
          <Button onPress={handleRemoveImage}>
            <ButtonText>Remove Image</ButtonText>
          </Button>
          <ImageView source={{uri: selectedImageUri}} />
        </>
      )}
    </Container>
  );
}
