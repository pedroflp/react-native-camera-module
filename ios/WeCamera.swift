@objc(WeCamera)
class WeCamera: NSObject {
  @objc(openImagePicker:withRejecter:)
  func openImagePicker(resolve:RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) -> Void {
    let imagePicker = UIImagePickerController();
    imagePicker.sourceType = .photoLibrary;

    DispatchQueue.main.async {
      RCTPresentedViewController()?.present(imagePicker, animated: true)
    }

    resolve("Picker aberto!")
  }
}