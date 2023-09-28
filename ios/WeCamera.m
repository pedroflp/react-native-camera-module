// WeCamera.m
// wefitCameraModule
//
// Created by Abner Bernal on 17/09/23.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"

#import <UIKit/UIKit.h>

@interface RCT_EXTERN_MODULE(WeCamera, NSObject)
RCT_EXTERN_METHOD(simpleMethodReturns:
   (RCTResponseSenderBlock) callback
 )
RCT_EXTERN_METHOD(
openCamera: (RCTPromiseResolveBlock) resolve
  rejecter: (RCTPromiseRejectBlock) reject
)
RCT_EXTERN_METHOD(
  openGallery: (RCTPromiseResolveBlock) resolve
  rejecter: (RCTPromiseRejectBlock) reject
)
@end

