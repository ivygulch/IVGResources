//
//  IVGRSResource.h
//  IVGResources
//
//  Created by Douglas Sjoquist on 2/7/13.
//  Copyright (c) 2013 Ivy Gulch, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IVGRSConstants.h"

@interface IVGRSResource : NSObject

@property (nonatomic,copy,readonly) NSString *basePath;
@property (nonatomic,copy,readonly) NSString *name;

- (id) initWithBasePath:(NSString *) basePath name:(NSString *) name;

- (NSString *) currentResourcePathForInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation;
- (NSArray *) resourcePathsForInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation
                                       screenScale:(CGFloat) screenScale
                                        screenSize:(CGSize) screenSize
                                userInterfaceIdiom:(UIUserInterfaceIdiom) userInterfaceIdiom;
- (NSString *) resourcePathForInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation
                                       screenScale:(CGFloat) screenScale
                                        screenSize:(CGSize) screenSize
                                userInterfaceIdiom:(UIUserInterfaceIdiom) userInterfaceIdiom;

@end
