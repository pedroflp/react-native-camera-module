#import <React/ReactBridgeModule.h>

@interface RCT_EXTERN_MODULE(WeCamera, NSObject)

RCT_EXTERN_METHOD(openImagePicker:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject
)

@end