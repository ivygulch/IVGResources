//
//  IVGRSResourceInstance.h
//  IVGResources
//
//  Created by Douglas Sjoquist on 2/7/13.
//  Copyright (c) 2013 Ivy Gulch, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IVGRSConstants.h"

@interface IVGRSResourceInstance : NSObject

@property (nonatomic,copy,readonly) NSString *resourcePath;
@property (nonatomic,assign,readonly) kIVGRSResourceOrientation orientation;
@property (nonatomic,assign,readonly) kIVGRSResourceScale scale;
@property (nonatomic,assign,readonly) kIVGRSResourceDevice device;

+ (IVGRSResourceInstance *) resourceInstanceForDirectoryPath:(NSString *) directoryPath
                                                fileBaseName:(NSString *) fileBaseName
                                                   extension:extension;

@end
