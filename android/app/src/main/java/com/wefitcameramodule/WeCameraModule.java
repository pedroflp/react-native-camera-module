package com.wefitcameramodule;

import android.content.Intent;
import android.provider.MediaStore;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

public class WeCameraModule extends ReactContextBaseJavaModule {
    private static ReactApplicationContext reactContext;

    public WeCameraModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @NonNull
    @Override
    public String getName() {
        return "WeCamera";
    }

    @ReactMethod
    public void openImagePicker(Promise promise) {
        Intent intent = new Intent(Intent.ACTION_PICK, MediaStore.Images.Media.INTERNAL_CONTENT_URI);
        reactContext.startActivityForResult(intent, 100, null);

        promise.resolve("Picker aberto!");
    }

    public void openCamera(Promise promise){}
}