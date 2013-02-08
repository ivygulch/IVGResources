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
    kIVGRSResourceBitMask_device_generic = 1 << 0,
    kIVGRSResourceBitMask_device_ipad = 1 << 1,
    kIVGRSResourceBitMask_device_iphone = 1 << 2,
    kIVGRSResourceBitMask_scale_generic = 1 << 3,
    kIVGRSResourceBitMask_scale_2X = 1 << 4,
    kIVGRSResourceBitMask_scale_568h = 1 << 5,
    kIVGRSResourceBitMask_orientation_generic = 1 << 6,
    kIVGRSResourceBitMask_orientation_Portrait = 1 << 7,
    kIVGRSResourceBitMask_orientation_PortraitUpsideDown = 1 << 8,
    kIVGRSResourceBitMask_orientation_Landscape = 1 << 9,
    kIVGRSResourceBitMask_orientation_LandscapeLeft = 1 << 10,
    kIVGRSResourceBitMask_orientation_LandscapeRight = 1 << 11
} kIVGRSResourceBitMask;

