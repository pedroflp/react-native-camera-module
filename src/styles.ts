import styled from 'styled-components/native';

export const Container = styled.View`
  justify-content: center;
  align-content: center;
  padding: 24px;
  height: 100%;
  width: 100%;
  gap: 28px;
`;

export const Button = styled.TouchableOpacity`
  background-color: rgba(0, 0, 0, 0.1);
  border-radius: 14px;
  padding: 16px;
`;

export const ButtonText = styled.Text`
  text-transform: uppercase;
  font-weight: 500;
`;

export const ImageView = styled.Image`
  border-radius: 14px;
  aspect-ratio: 1;
  width: 100%;
`;
