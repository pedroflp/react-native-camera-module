package com.wefitcameramodule;

import android.app.Activity;
import android.content.Intent;
import android.content.Context;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.provider.MediaStore;
import androidx.annotation.NonNull;
import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.BaseActivityEventListener;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import java.io.File;
import java.io.IOException;
import androidx.core.content.FileProvider;
import android.os.Environment;
import java.text.SimpleDateFormat;
import java.util.Date;


public class WeCameraModule extends ReactContextBaseJavaModule {
    public WeCameraModule(ReactApplicationContext reactContext) {
        super(reactContext);
        reactContext.addActivityEventListener(mActivityEventListener);
    }

    @NonNull
    @Override
    public String getName() {
        return "WeCamera";
    }

    private static final int IMAGE_PICKER_REQUEST = 1;
    private static final int CAMERA_CAPTURE_REQUEST = 2;
    private Promise mImagePickerPromise;

    @ReactMethod
    public void openImagePicker(Promise promise) {
        Activity currentActivity = getCurrentActivity();
        if (currentActivity == null) {
            promise.reject("ACTIVITY_NULL", "Activity is null");
            return;
        }

        mImagePickerPromise = promise;
        Intent intent = new Intent(Intent.ACTION_PICK, MediaStore.Images.Media.INTERNAL_CONTENT_URI);
        currentActivity.startActivityForResult(intent, IMAGE_PICKER_REQUEST);
    }

    @ReactMethod
    public void captureImage(Promise promise) {
        Activity currentActivity = getCurrentActivity();
        if (currentActivity == null) {
            promise.reject("ACTIVITY_NULL", "Activity is null");
            return;
        }

        if (!isCameraAvailable(currentActivity)) {
            promise.reject("CAMERA_NOT_AVAILABLE", "Camera is not available on this device");
            return;
        }

        mImagePickerPromise = promise;
        Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
        if (intent.resolveActivity(currentActivity.getPackageManager()) != null) {
            try {
                File photoFile = createImageFile();
                Uri photoUri = FileProvider.getUriForFile(currentActivity, "com.your.app.fileprovider", photoFile);
                intent.putExtra(MediaStore.EXTRA_OUTPUT, photoUri);
                currentActivity.startActivityForResult(intent, CAMERA_CAPTURE_REQUEST);
            } catch (IOException e) {
                promise.reject("IMAGE_FILE_ERROR", "Erro ao criar o arquivo de imagem");
            }
        } else {
            promise.reject("CAMERA_INTENT_ERROR", "Failed to create camera intent");
        }
    }

    private File createImageFile() throws IOException {
        // Nome único para o arquivo de imagem baseado na data e hora atual
        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
        String imageFileName = "JPEG_" + timeStamp + "_";
        
        // Diretório onde a imagem será armazenada (normalmente, o diretório de fotos do aplicativo)
        File storageDir = new File(Environment.getExternalStoragePublicDirectory(
                Environment.DIRECTORY_PICTURES), "YourAppDirectoryName");

        // Certifique-se de que o diretório existe, se não, crie-o
        if (!storageDir.exists()) {
            storageDir.mkdirs();
        }

        // Crie o arquivo de imagem
        File imageFile = File.createTempFile(
            imageFileName,  // Prefixo do nome do arquivo
            ".jpg",         // Extensão do arquivo
            storageDir      // Diretório onde o arquivo será criado
        );

        // Salve o caminho do arquivo para usá-lo posteriormente
        // mCurrentPhotoPath = imageFile.getAbsolutePath();
        
        return imageFile;
    }

    private boolean isCameraAvailable(Context context) {
        return context.getPackageManager().hasSystemFeature(PackageManager.FEATURE_CAMERA);
    }

    private final ActivityEventListener mActivityEventListener = new BaseActivityEventListener() {
        @Override
        public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) {
            if (mImagePickerPromise == null) {
                return;
            }

            switch (requestCode) {
                case IMAGE_PICKER_REQUEST:
                    if (resultCode == Activity.RESULT_OK) {
                        Uri selectedImageUri = data.getData();
                        mImagePickerPromise.resolve(selectedImageUri.toString());
                    } else {
                        mImagePickerPromise.reject("IMAGE_PICKER_ERROR", "Image picker canceled");
                    }
                    break;
                case CAMERA_CAPTURE_REQUEST:
                    if (resultCode == Activity.RESULT_OK) {
                        if (data != null && data.getData() != null) {
                            Uri capturedImageUri = data.getData();
                            mImagePickerPromise.resolve(capturedImageUri.toString());
                        } else {
                            mImagePickerPromise.reject("CAPTURE_ERROR", "Failed to get captured image URI");
                        }
                    } else {
                        mImagePickerPromise.reject("CAPTURE_CANCELLED", "Image capture cancelled");
                    }
                    break;
            }

            mImagePickerPromise = null;
        }
    };
}
