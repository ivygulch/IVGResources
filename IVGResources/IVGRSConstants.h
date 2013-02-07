//
//  IVGRSConstants.h
//  IVGResources
//
//  Created by Douglas Sjoquist on 2/7/13.
//  Copyright (c) 2013 Ivy Gulch, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kIVGRSNotification_resourceChangedSubresource;

typedef enum {
    kIVGRSResourceOrientationDefault,
    kIVGRSResourceOrientationPortraitUpsideDown,
    kIVGRSResourceOrientationPortrait,
    kIVGRSResourceOrientationLandscapeLeft,
    kIVGRSResourceOrientationLandscapeRight,
    kIVGRSResourceOrientationLandscape
} kIVGRSResourceOrientation;

typedef enum {
    kIVGRSResourceScaleDefault,
    kIVGRSResourceScale2X
} kIVGRSResourceScale;

typedef enum {
    kIVGRSResourceDeviceDefault,
    kIVGRSResourceDeviceiPhone568h,
    kIVGRSResourceDeviceiPhone,
    kIVGRSResourceDeviceiPadMini,
    kIVGRSResourceDeviceiPad
} kIVGRSResourceDevice;

