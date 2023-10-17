import styled from 'styled-components/native';

export const Container = styled.View`
  justify-content: center;
  align-content: center;
  padding: 24px;
  height: 100%;
  width: 100%;
  gap: 28px;
`;

export const Button = styled.TouchableOpacity<{
  variant: 'delete' | 'filled';
}>`
  padding: 16px;
  border-radius: 8px;
  align-items: center;
  justify-content: center;

  ${({variant}) => {
    switch (variant) {
      case 'delete':
        return `
          width: 50%;
          margin-left: auto;
          background-color: rgba(255,0,0, 0.5);
        `;
      default:
        return `
          background-color: rgba(0, 0, 0, 0.1);
        `;
    }
  }};
`;

export const ButtonText = styled.Text<{
  variant: 'delete';
}>`
  text-transform: uppercase;
  font-weight: 500;

  ${({variant}) => {
    switch (variant) {
      case 'delete':
        return `
          color: white;
        `;
      default:
        return `
          color: black;
        `;
    }
  }};
`;

export const ImageView = styled.Image`
  border-radius: 14px;
  aspect-ratio: 1;
  width: 100%;
`;
