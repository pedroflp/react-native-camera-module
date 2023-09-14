package com.wefitcameramodule; // replace your-apps-package-name with your app’s package name
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod

import com.facebook.react.bridge.ReactApplicationContent
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise
import android.content.Intent
import android.provider.MediaStore

class WeCameraModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {
  private var reactContext: ReactApplicationContentContext = reactContext;

  override fun getName() = "WeCamera"

  @ReactMethod
  fun openImagePicker(promise: Promise) {
    val intent = Intent(Intent.ACTION_PICK, MediaStore.Images.Media.INTERNAL_CONTENT_URI)
    reactContext.startActivityForResult(intent, 100, null)

    promise.resolve("Picker aberto!")
  }
  fun openCamera(promise: Promise) {}
}