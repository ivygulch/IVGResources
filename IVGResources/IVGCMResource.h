//
//  IVGCMResource.h
//  IVGContentManager
//
//  Created by Douglas Sjoquist on 2/7/13.
//  Copyright (c) 2013 Ivy Gulch, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kIVGCMNotification_resourceChangedSubresource;

typedef enum {
    kIVGCMResourceOrientationDefault,
    kIVGCMResourceOrientationPortraitUpsideDown,
    kIVGCMResourceOrientationPortrait,
    kIVGCMResourceOrientationLandscapeLeft,
    kIVGCMResourceOrientationLandscapeRight,
    kIVGCMResourceOrientationLandscape
} kIVGCMResourceOrientation;

typedef enum {
    kIVGCMResourceScaleDefault,
    kIVGCMResourceScale2X
} kIVGCMResourceScale;

typedef enum {
    kIVGCMResourceDeviceDefault,
    kIVGCMResourceDeviceiPhone568h,
    kIVGCMResourceDeviceiPhone,
    kIVGCMResourceDeviceiPadMini,
    kIVGCMResourceDeviceiPad
} kIVGCMResourceDevice;

@class IVGCMResource;

@interface IVGCMSubresource : NSObject
@property (nonatomic,weak,readonly) IVGCMResource *resource;
@property (nonatomic,copy,readonly) NSString *resourcePath;
@property (nonatomic,assign,readonly) kIVGCMResourceOrientation orientation;
@property (nonatomic,assign,readonly) kIVGCMResourceScale scale;
@property (nonatomic,assign,readonly) kIVGCMResourceDevice device;
@end

@interface IVGCMResource : NSObject

@property (nonatomic,copy,readonly) NSString *basePath;
@property (nonatomic,copy,readonly) NSString *name;

- (id) initWithBasePath:(NSString *) basePath name:(NSString *) name;

- (IVGCMSubresource *) currentSubresource;

@end
