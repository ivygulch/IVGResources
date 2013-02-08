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
static const kIVGRSResourceOrientation kIVGRSResourceOrientationMin = kIVGRSResourceOrientationDefault;
static const kIVGRSResourceOrientation kIVGRSResourceOrientationMax = kIVGRSResourceOrientationLandscape;

typedef enum {
    kIVGRSResourceScaleDefault,
    kIVGRSResourceScale568h2X,
    kIVGRSResourceScale2X
} kIVGRSResourceScale;
static const kIVGRSResourceScale kIVGRSResourceScaleMin = kIVGRSResourceScaleDefault;
static const kIVGRSResourceScale kIVGRSResourceScaleMax = kIVGRSResourceScale2X;

typedef enum {
    kIVGRSResourceDeviceDefault,
    kIVGRSResourceDeviceiPhone,
    kIVGRSResourceDeviceiPad
} kIVGRSResourceDevice;
static const kIVGRSResourceDevice kIVGRSResourceDeviceMin = kIVGRSResourceDeviceDefault;
static const kIVGRSResourceDevice kIVGRSResourceDeviceMax = kIVGRSResourceDeviceiPad;

NSString *orientationText(kIVGRSResourceOrientation orientation);
NSString *scaleText(kIVGRSResourceScale scale);
NSString *deviceText(kIVGRSResourceDevice device);
NSString *combinedText(kIVGRSResourceOrientation orientation, kIVGRSResourceScale scale, kIVGRSResourceDevice device);

NSUInteger orientationPriority(kIVGRSResourceOrientation orientation);
NSUInteger scalePriority(kIVGRSResourceScale scale);
NSUInteger devicePriority(kIVGRSResourceDevice device);
NSUInteger combinedPriority(kIVGRSResourceOrientation orientation, kIVGRSResourceScale scale, kIVGRSResourceDevice device);
