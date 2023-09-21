// WeCamera.swift
// wefitCameraModule
//
// Created by Abner Bernal on 17/09/23.
//

import React

@objc(WeCamera)
class WeCamera: NSObject {
  @objc static func requiresMainQueueSetup() -> Bool { return true }

  @objc public func simpleMethodReturns(_ callback: RCTResponseSenderBlock) {
      callback(["Este é um teste de módulo em Swift."])
  }
  
  
  @objc public func openImagePicker(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
    DispatchQueue.main.async {
      let imagePicker = UIImagePickerController()
      imagePicker.sourceType = .photoLibrary
      
      if let viewController = RCTPresentedViewController() {
        viewController.present(imagePicker, animated: true, completion: nil)
      } else {
        reject("PRESENT_VIEW_CONTROLLER_ERROR", "Não foi possível encontrar a view controller apresentada", nil)
      }
      
      resolve("Picker aberto!")
    }
  }
}

