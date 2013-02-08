//
//  IVGRSUtils.h
//  IVGResources
//
//  Created by Douglas Sjoquist on 2/7/13.
//  Copyright (c) 2013 Ivy Gulch, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IVGRSConstants.h"

kIVGRSResourceOrientation orientationFromInterfaceOrientation(UIInterfaceOrientation interfaceOrientation);
kIVGRSResourceScale scaleFromScreenScaleAndSize(CGFloat screenScale, CGSize screenSize);
kIVGRSResourceDevice deviceFrom(id d);

NSString *combinedText(kIVGRSResourceOrientation orientation, kIVGRSResourceScale scale, kIVGRSResourceDevice device);

NSUInteger combinedPriority(kIVGRSResourceOrientation orientation, kIVGRSResourceScale scale, kIVGRSResourceDevice device);
