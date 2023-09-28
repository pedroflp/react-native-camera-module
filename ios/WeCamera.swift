// WeCamera.swift
// wefitCameraModule
//
// Created by Abner Bernal on 17/09/23.
//

import AVFoundation
import UIKit
import Photos
import React

@objc(WeCamera)
class WeCamera: NSObject, RCTBridgeModule, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc static func moduleName() -> String {
        return "WeCamera" // Defina o nome do seu módulo
    }

    @objc static func requiresMainQueueSetup() -> Bool { return true }
  
    @objc public func simpleMethodReturns(_ callback: RCTResponseSenderBlock) {
        callback(["Este é um teste de módulo em Swift."])
    }

    private var imagePickerPromise: RCTPromiseResolveBlock?

    // Função genérica para abrir a câmera ou a galeria com base na sourceType
    @objc func openImagePicker(_ sourceType: UIImagePickerController.SourceType, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        DispatchQueue.main.async {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = sourceType
            imagePicker.delegate = self // Configura o delegado

            if let viewController = RCTPresentedViewController() {
                self.imagePickerPromise = resolve // Armazena a resolução da promessa

                viewController.present(imagePicker, animated: true, completion: nil)
            } else {
                reject("PRESENT_VIEW_CONTROLLER_ERROR", "Não foi possível encontrar a view controller apresentada", nil)
            }
        }
    }

    // Implementa o método do delegado para receber a imagem selecionada
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)

        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            self.imagePickerPromise?(["Error capturing image"])
            return
        }

        // Salvar a imagem no diretório de documentos do aplicativo
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsDirectory.appendingPathComponent("captured_image.jpg")

            do {
                try imageData.write(to: fileURL)
                // Converta o URL em uma NSString
                let imagePath = fileURL.absoluteString as NSString
                self.imagePickerPromise?(imagePath)
            } catch {
                self.imagePickerPromise?(["Error saving image"])
            }
        }
    }

    // Implementa o método do delegado para cancelamento da seleção
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        self.imagePickerPromise?(NSNull()) // Retorna `undefined` como NSNull
    }

    // Método público para abrir a câmera
    @objc public func openCamera(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
        self.openImagePicker(.camera, resolve: resolve, reject: reject)
    }

    // Método público para abrir a galeria de fotos
    @objc public func openGallery(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
        self.openImagePicker(.photoLibrary, resolve: resolve, reject: reject)
    }
}

