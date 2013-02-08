//
//  IVGRSUtils.m
//  IVGResources
//
//  Created by Douglas Sjoquist on 2/7/13.
//  Copyright (c) 2013 Ivy Gulch, LLC. All rights reserved.
//

#import "IVGRSUtils.h"

NSString * const kIVGRSNotification_resourceChangedSubresource = @"kIVGRSNotification_resourceChangedSubresource";

NSString *orientationText(kIVGRSResourceOrientation orientation) {
    switch (orientation) {
        case kIVGRSResourceOrientationDefault: return @"";
        case kIVGRSResourceOrientationPortraitUpsideDown: return @"-PortraitUpsideDown ";
        case kIVGRSResourceOrientationPortrait: return @"-Portrait";
        case kIVGRSResourceOrientationLandscapeLeft: return @"-LandscapeLeft";
        case kIVGRSResourceOrientationLandscapeRight: return @"-LandscapeRight";
        case kIVGRSResourceOrientationLandscape: return @"-Landscape";
    }
}

NSString *scaleText(kIVGRSResourceScale scale) {
    switch (scale) {
        case kIVGRSResourceScaleDefault : return @"";
        case kIVGRSResourceScale568h2X : return @"-568h@2x";
        case kIVGRSResourceScale2X : return @"2x";
    }
}

NSString *deviceText(kIVGRSResourceDevice device) {
    switch (device) {
        case kIVGRSResourceDeviceDefault : return @"";
        case kIVGRSResourceDeviceiPhone : return @"~iphone";
        case kIVGRSResourceDeviceiPad : return @"~ipad";
    }
}

NSString *combinedText(kIVGRSResourceOrientation orientation, kIVGRSResourceScale scale, kIVGRSResourceDevice device) {
    return [NSString stringWithFormat:@"%@%@%@", orientationText(orientation), scaleText(scale), deviceText(device)];
}

NSUInteger orientationPriority(kIVGRSResourceOrientation orientation) {
    switch (orientation) {
        case kIVGRSResourceOrientationDefault: return 3;
        case kIVGRSResourceOrientationPortraitUpsideDown: return 2;
        case kIVGRSResourceOrientationPortrait: return 1;
        case kIVGRSResourceOrientationLandscapeLeft: return 2;
        case kIVGRSResourceOrientationLandscapeRight: return 2;
        case kIVGRSResourceOrientationLandscape: return 1;
    }
}

NSUInteger scalePriority(kIVGRSResourceScale scale) {
    switch (scale) {
        case kIVGRSResourceScaleDefault : return 3;
        case kIVGRSResourceScale568h2X : return 1;
        case kIVGRSResourceScale2X : return 2;
    }
}

NSUInteger devicePriority(kIVGRSResourceDevice device) {
    switch (device) {
        case kIVGRSResourceDeviceDefault : return 3;
        case kIVGRSResourceDeviceiPhone : return 2;
        case kIVGRSResourceDeviceiPad : return 1;
    }
}

NSUInteger combinedPriority(kIVGRSResourceOrientation orientation, kIVGRSResourceScale scale, kIVGRSResourceDevice device) {
    return orientationPriority(orientation) * scalePriority(scale) * devicePriority(device);
}
