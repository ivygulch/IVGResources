//
//  IVGRSUtils.h
//  IVGResources
//
//  Created by Douglas Sjoquist on 2/7/13.
//  Copyright (c) 2013 Ivy Gulch, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IVGRSConstants.h"

NSString *combinedText(kIVGRSResourceOrientation orientation, kIVGRSResourceScale scale, kIVGRSResourceDevice device);

NSUInteger combinedPriority(kIVGRSResourceOrientation orientation, kIVGRSResourceScale scale, kIVGRSResourceDevice device);
