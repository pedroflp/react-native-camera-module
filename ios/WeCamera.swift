// WeCamera.swift
// wefitCameraModule
//
// Created by Abner Bernal on 17/09/23.
//

import Photos
import React

@objc(WeCamera)
class WeCamera: NSObject, RCTBridgeModule, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  @objc static func moduleName() -> String {
         return "WeCamera" // Defina o nome do seu módulo
  }

  @objc static func requiresMainQueueSetup() -> Bool { return true }
  
  var imagePickerPromise: RCTPromiseResolveBlock?

  @objc public func simpleMethodReturns(_ callback: RCTResponseSenderBlock) {
      callback(["Este é um teste de módulo em Swift."])
  }
  
  @objc public func openImagePicker(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    DispatchQueue.main.async {
      let imagePicker = UIImagePickerController()
      imagePicker.sourceType = .photoLibrary
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
    if info[UIImagePickerController.InfoKey.originalImage] is UIImage {
          // Obter o URL do caminho de arquivo para a imagem
          if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
              // Converta o URL em uma string
              let imagePath = imageURL.absoluteString
              // Verifique se a promessa foi armazenada
              if let promise = self.imagePickerPromise {
                  promise(imagePath)
              }
          }
      } else {
      print("Falha ao obter a imagem")
    }
    
    // Fecha o imagePicker
    picker.dismiss(animated: true, completion: nil)
  }
}

