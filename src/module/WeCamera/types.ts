export type WeCameraProps = {
  openImagePicker: () => Promise<string>;
  captureImage: () => Promise<string>;
};
