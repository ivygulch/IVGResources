//
//  IVGRSResource.h
//  IVGResources
//
//  Created by Douglas Sjoquist on 2/7/13.
//  Copyright (c) 2013 Ivy Gulch, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IVGRSConstants.h"
#import "IVGRSResourceInstance.h"

@interface IVGRSResource : NSObject

@property (nonatomic,copy,readonly) NSString *basePath;
@property (nonatomic,copy,readonly) NSString *name;

- (id) initWithBasePath:(NSString *) basePath name:(NSString *) name;

- (IVGRSResourceInstance *) currentResourceInstance;

@end
