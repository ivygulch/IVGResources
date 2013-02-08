//
//  IVGRSResource.m
//  IVGResources
//
//  Created by Douglas Sjoquist on 2/7/13.
//  Copyright (c) 2013 Ivy Gulch, LLC. All rights reserved.
//

#import "IVGRSResource.h"
#import "IVGRSUtils.h"
#import "NSArray+IVGUtils.h"

// return which mask values are a match for this particular interfaceOrientation
kIVGRSResourceBitMask maskForInterfaceOrientation(UIInterfaceOrientation interfaceOrientation) {
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait: return kIVGRSResourceBitMask_orientation_generic | kIVGRSResourceBitMask_orientation_Portrait;
        case UIInterfaceOrientationPortraitUpsideDown: return kIVGRSResourceBitMask_orientation_generic | kIVGRSResourceBitMask_orientation_Portrait;
        case UIInterfaceOrientationLandscapeLeft: return kIVGRSResourceBitMask_orientation_generic | kIVGRSResourceBitMask_orientation_Landscape | kIVGRSResourceBitMask_orientation_LandscapeLeft;
        case UIInterfaceOrientationLandscapeRight: return kIVGRSResourceBitMask_orientation_generic | kIVGRSResourceBitMask_orientation_Landscape | kIVGRSResourceBitMask_orientation_LandscapeRight;
    }
}

// return which mask values are a match for this particular screen scale and size
kIVGRSResourceBitMask maskForScreenScaleAndSize(CGFloat screenScale, CGSize screenSize) {
    if (screenScale == 2.0) {
        if (screenSize.height == 568.0) {
            return kIVGRSResourceBitMask_scale_generic | kIVGRSResourceBitMask_scale_2X | kIVGRSResourceBitMask_scale_568h;
        } else {
            return kIVGRSResourceBitMask_scale_generic | kIVGRSResourceBitMask_scale_2X;
        }
    } else {
        return kIVGRSResourceBitMask_scale_generic;
    }
}

// return which mask values are a match for this particular userInterfaceIdiom
kIVGRSResourceBitMask maskForUserInterfaceIdiom(UIUserInterfaceIdiom userInterfaceIdiom) {
    switch (userInterfaceIdiom) {
        case UIUserInterfaceIdiomPad: return kIVGRSResourceBitMask_device_generic | kIVGRSResourceBitMask_device_ipad;
        case UIUserInterfaceIdiomPhone: return kIVGRSResourceBitMask_device_generic | kIVGRSResourceBitMask_device_iphone;
    }
}

kIVGRSResourceBitMask qualifierMask(UIInterfaceOrientation interfaceOrientation, CGFloat screenScale, CGSize screenSize, UIUserInterfaceIdiom userInterfaceIdiom) {
    return maskForInterfaceOrientation(interfaceOrientation) | maskForScreenScaleAndSize(screenScale, screenSize) | maskForUserInterfaceIdiom(userInterfaceIdiom);
}

unsigned int countBits (unsigned int value) {
    unsigned int count = 0;
    while (value > 0) {           // until all bits are zero
        if ((value & 1) == 1)     // check lower bit
            count++;
        value >>= 1;              // shift bits, removing lower bit
    }
    return count;
}

@interface IVGRSResource()
@property (nonatomic,copy,readonly) NSString *baseName;
@property (nonatomic,copy,readonly) NSString *extension;
@property (nonatomic,strong) NSDictionary *resourceInstances;
@end

@implementation IVGRSResource

+ (NSUInteger) bitCountForQualiferMask:(NSNumber *) number;
{
    static dispatch_once_t pred_bitCounts;
    static NSMutableDictionary *_bitCounts = nil;
    dispatch_once(&pred_bitCounts, ^{
        _bitCounts = [NSMutableDictionary dictionary];
    });
    NSNumber *result = [_bitCounts objectForKey:number];
    if (result == nil) {
        NSUInteger bitCount = countBits([number integerValue]);
        result = [NSNumber numberWithInteger:bitCount];
        [_bitCounts setObject:result forKey:number];
    }
    return [result integerValue];
}

+ (NSDictionary *) suffixes;
{
    static dispatch_once_t pred_shared_instance;
    static NSDictionary *_sharedInstance = nil;
    dispatch_once(&pred_shared_instance, ^{
        _sharedInstance =
        @{
          @"":@(kIVGRSResourceBitMask_device_generic | kIVGRSResourceBitMask_scale_generic | kIVGRSResourceBitMask_orientation_generic),
          @"@2x":@(kIVGRSResourceBitMask_device_generic | kIVGRSResourceBitMask_scale_2X | kIVGRSResourceBitMask_orientation_generic),
          @"~iphone":@(kIVGRSResourceBitMask_device_iphone | kIVGRSResourceBitMask_scale_generic | kIVGRSResourceBitMask_orientation_generic),
          @"@2x~iphone":@(kIVGRSResourceBitMask_device_iphone | kIVGRSResourceBitMask_scale_2X | kIVGRSResourceBitMask_orientation_generic),
          @"-568h@2x~iphone":@(kIVGRSResourceBitMask_device_iphone | kIVGRSResourceBitMask_scale_2X | kIVGRSResourceBitMask_orientation_generic),
          @"~ipad":@(kIVGRSResourceBitMask_device_ipad | kIVGRSResourceBitMask_scale_generic | kIVGRSResourceBitMask_orientation_generic),
          @"@2x~ipad":@(kIVGRSResourceBitMask_device_ipad | kIVGRSResourceBitMask_scale_2X | kIVGRSResourceBitMask_orientation_generic),
          @"-PortraitUpsideDown":@(kIVGRSResourceBitMask_device_generic | kIVGRSResourceBitMask_scale_generic | kIVGRSResourceBitMask_orientation_PortraitUpsideDown),
          @"-PortraitUpsideDown@2x":@(kIVGRSResourceBitMask_device_generic | kIVGRSResourceBitMask_scale_2X | kIVGRSResourceBitMask_orientation_PortraitUpsideDown),
          @"-PortraitUpsideDown~iphone":@(kIVGRSResourceBitMask_device_iphone | kIVGRSResourceBitMask_scale_generic | kIVGRSResourceBitMask_orientation_PortraitUpsideDown),
          @"-PortraitUpsideDown@2x~iphone":@(kIVGRSResourceBitMask_device_iphone | kIVGRSResourceBitMask_scale_2X | kIVGRSResourceBitMask_orientation_PortraitUpsideDown),
          @"-PortraitUpsideDown-568h@2x~iphone":@(kIVGRSResourceBitMask_device_iphone | kIVGRSResourceBitMask_scale_568h | kIVGRSResourceBitMask_orientation_PortraitUpsideDown),
          @"-PortraitUpsideDown~ipad":@(kIVGRSResourceBitMask_device_ipad | kIVGRSResourceBitMask_scale_generic | kIVGRSResourceBitMask_orientation_PortraitUpsideDown),
          @"-PortraitUpsideDown@2x~ipad":@(kIVGRSResourceBitMask_device_ipad | kIVGRSResourceBitMask_scale_2X | kIVGRSResourceBitMask_orientation_PortraitUpsideDown),
          @"-Portrait":@(kIVGRSResourceBitMask_device_generic | kIVGRSResourceBitMask_scale_generic | kIVGRSResourceBitMask_orientation_Portrait),
          @"-Portrait@2x":@(kIVGRSResourceBitMask_device_generic | kIVGRSResourceBitMask_scale_2X | kIVGRSResourceBitMask_orientation_Portrait),
          @"-Portrait~iphone":@(kIVGRSResourceBitMask_device_iphone | kIVGRSResourceBitMask_scale_generic | kIVGRSResourceBitMask_orientation_Portrait),
          @"-Portrait@2x~iphone":@(kIVGRSResourceBitMask_device_iphone | kIVGRSResourceBitMask_scale_2X | kIVGRSResourceBitMask_orientation_Portrait),
          @"-Portrait-568h@2x~iphone":@(kIVGRSResourceBitMask_device_iphone | kIVGRSResourceBitMask_scale_568h | kIVGRSResourceBitMask_orientation_Portrait),
          @"-Portrait~ipad":@(kIVGRSResourceBitMask_device_ipad | kIVGRSResourceBitMask_scale_generic | kIVGRSResourceBitMask_orientation_Portrait),
          @"-Portrait@2x~ipad":@(kIVGRSResourceBitMask_device_ipad | kIVGRSResourceBitMask_scale_2X | kIVGRSResourceBitMask_orientation_Portrait),
          @"-LandscapeLeft":@(kIVGRSResourceBitMask_device_generic | kIVGRSResourceBitMask_scale_generic | kIVGRSResourceBitMask_orientation_LandscapeLeft),
          @"-LandscapeLeft@2x":@(kIVGRSResourceBitMask_device_generic | kIVGRSResourceBitMask_scale_2X | kIVGRSResourceBitMask_orientation_LandscapeLeft),
          @"-LandscapeLeft~iphone":@(kIVGRSResourceBitMask_device_iphone | kIVGRSResourceBitMask_scale_generic | kIVGRSResourceBitMask_orientation_LandscapeLeft),
          @"-LandscapeLeft@2x~iphone":@(kIVGRSResourceBitMask_device_iphone | kIVGRSResourceBitMask_scale_2X | kIVGRSResourceBitMask_orientation_LandscapeLeft),
          @"-LandscapeLeft-568h@2x~iphone":@(kIVGRSResourceBitMask_device_iphone | kIVGRSResourceBitMask_scale_568h | kIVGRSResourceBitMask_orientation_LandscapeLeft),
          @"-LandscapeLeft~ipad":@(kIVGRSResourceBitMask_device_ipad | kIVGRSResourceBitMask_scale_generic | kIVGRSResourceBitMask_orientation_LandscapeLeft),
          @"-LandscapeLeft@2x~ipad":@(kIVGRSResourceBitMask_device_ipad | kIVGRSResourceBitMask_scale_2X | kIVGRSResourceBitMask_orientation_LandscapeLeft),
          @"-LandscapeRight":@(kIVGRSResourceBitMask_device_generic | kIVGRSResourceBitMask_scale_generic | kIVGRSResourceBitMask_orientation_LandscapeRight),
          @"-LandscapeRight@2x":@(kIVGRSResourceBitMask_device_generic | kIVGRSResourceBitMask_scale_2X | kIVGRSResourceBitMask_orientation_LandscapeRight),
          @"-LandscapeRight~iphone":@(kIVGRSResourceBitMask_device_iphone | kIVGRSResourceBitMask_scale_generic | kIVGRSResourceBitMask_orientation_LandscapeRight),
          @"-LandscapeRight@2x~iphone":@(kIVGRSResourceBitMask_device_iphone | kIVGRSResourceBitMask_scale_2X | kIVGRSResourceBitMask_orientation_LandscapeRight),
          @"-LandscapeRight-568h@2x~iphone":@(kIVGRSResourceBitMask_device_iphone | kIVGRSResourceBitMask_scale_568h | kIVGRSResourceBitMask_orientation_LandscapeRight),
          @"-LandscapeRight~ipad":@(kIVGRSResourceBitMask_device_ipad | kIVGRSResourceBitMask_scale_generic | kIVGRSResourceBitMask_orientation_LandscapeRight),
          @"-LandscapeRight@2x~ipad":@(kIVGRSResourceBitMask_device_ipad | kIVGRSResourceBitMask_scale_2X | kIVGRSResourceBitMask_orientation_LandscapeRight),
          @"-Landscape":@(kIVGRSResourceBitMask_device_generic | kIVGRSResourceBitMask_scale_generic | kIVGRSResourceBitMask_orientation_Landscape),
          @"-Landscape@2x":@(kIVGRSResourceBitMask_device_generic | kIVGRSResourceBitMask_scale_2X | kIVGRSResourceBitMask_orientation_Landscape),
          @"-Landscape~ipad":@(kIVGRSResourceBitMask_device_ipad | kIVGRSResourceBitMask_scale_generic | kIVGRSResourceBitMask_orientation_Landscape),
          @"-Landscape@2x~ipad":@(kIVGRSResourceBitMask_device_ipad | kIVGRSResourceBitMask_scale_2X | kIVGRSResourceBitMask_orientation_Landscape),
          @"-Landscape~iphone":@(kIVGRSResourceBitMask_device_iphone | kIVGRSResourceBitMask_scale_generic | kIVGRSResourceBitMask_orientation_Landscape),
          @"-Landscape@2x~iphone":@(kIVGRSResourceBitMask_device_iphone | kIVGRSResourceBitMask_scale_2X | kIVGRSResourceBitMask_orientation_Landscape),
          @"-Landscape-568h@2x~iphone":@(kIVGRSResourceBitMask_device_iphone | kIVGRSResourceBitMask_scale_568h | kIVGRSResourceBitMask_orientation_Landscape)
          };
    });
    return _sharedInstance;
}


- (id) initWithBasePath:(NSString *) basePath name:(NSString *) name;
{
    if ((self = [super init])) {
        _basePath = [basePath copy];
        _name = [name copy];
        _baseName = [name stringByDeletingPathExtension];
        _extension = [name pathExtension];
    }
    return self;
}

- (void) appendResourceInstances:(NSMutableDictionary *) resourceInstances
           withResourceNamesUsed:(NSMutableSet *) resourceNamesUsed
               fromDirectoryPath:(NSString *) directoryPath
                           error:(NSError **) error;
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray *filenames = [fileManager contentsOfDirectoryAtPath:directoryPath error:error];
    if (filenames == nil) {
        return;
    }

    NSUInteger baseLength = [self.baseName length];
    NSLog(@"base: %@, %d", self.baseName, baseLength);
    for (NSString *filename in filenames) {
        if (![resourceNamesUsed containsObject:filename]) {
            NSString *fileBaseName = [filename stringByDeletingPathExtension];
            NSString *fileExtension = [filename pathExtension];
            if ([fileBaseName hasPrefix:self.baseName] && [fileExtension isEqualToString:self.extension]) {
                NSString *fileQualifier = [fileBaseName substringFromIndex:baseLength];
                NSString *qualifierMask = [[IVGRSResource suffixes] objectForKey:fileQualifier];
                NSLog(@"%@: %2.2X", filename, [qualifierMask integerValue]);
                if (qualifierMask != nil) {
                    NSString *resourcePath = [directoryPath stringByAppendingPathComponent:filename];
                    [resourceInstances setObject:resourcePath forKey:qualifierMask];
                    [resourceNamesUsed addObject:filename];
                }
            }
        }
    }
}

- (void) rebuildResourceInstances;
{
    NSMutableDictionary *resourceInstances = [NSMutableDictionary dictionaryWithCapacity:100];
    NSMutableSet *resourceNamesUsed = [NSMutableSet set];
    if (self.basePath != nil) {
        [self appendResourceInstances:resourceInstances withResourceNamesUsed:resourceNamesUsed fromDirectoryPath:self.basePath error:nil];
    }
    [self appendResourceInstances:resourceInstances withResourceNamesUsed:resourceNamesUsed fromDirectoryPath:[[NSBundle mainBundle] resourcePath] error:nil];
    self.resourceInstances = [NSDictionary dictionaryWithDictionary:resourceInstances];
}

- (NSDictionary *) resourceInstances;
{
    if (_resourceInstances == nil) {
        [self rebuildResourceInstances];
    }
    return _resourceInstances;
}

- (NSString *) currentResourcePathForInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation;
{
    return [self resourcePathForInterfaceOrientation:interfaceOrientation
                                         screenScale:[UIScreen mainScreen].scale
                                          screenSize:[UIScreen mainScreen].bounds.size
                                  userInterfaceIdiom:[[UIDevice currentDevice] userInterfaceIdiom]];
}

- (NSArray *) resourcePathsForInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation
                                       screenScale:(CGFloat) screenScale
                                        screenSize:(CGSize) screenSize
                                userInterfaceIdiom:(UIUserInterfaceIdiom) userInterfaceIdiom;
{
    kIVGRSResourceBitMask mask = qualifierMask(interfaceOrientation, screenScale, screenSize, userInterfaceIdiom);
    NSMutableArray *resourcePathKeys = [NSMutableArray array];
    [self.resourceInstances enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        int16_t resourceInstanceMask = [key integerValue];
        if ((mask & resourceInstanceMask) != 0) {
            [resourcePathKeys addObject:key];
        }
    }];
    [resourcePathKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSUInteger bitCount1 = [IVGRSResource bitCountForQualiferMask:obj1];
        NSUInteger bitCount2 = [IVGRSResource bitCountForQualiferMask:obj1];
        if (bitCount1 < bitCount2) {
            return NSOrderedAscending;
        } else if (bitCount1 > bitCount2) {
            return NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
    NSMutableArray *resourcePaths = [NSMutableArray arrayWithCapacity:[resourcePathKeys count]];
    for (NSNumber *resourcePathKey in resourcePathKeys) {
        [resourcePaths addObject:[self.resourceInstances objectForKey:resourcePathKey]];
    }
    return resourcePaths;
}

- (NSString *) resourcePathForInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation
                                       screenScale:(CGFloat) screenScale
                                        screenSize:(CGSize) screenSize
                                userInterfaceIdiom:(UIUserInterfaceIdiom) userInterfaceIdiom;
{
    NSArray *resourcePaths = [self resourcePathsForInterfaceOrientation:interfaceOrientation
                                                            screenScale:screenScale
                                                             screenSize:screenSize
                                                     userInterfaceIdiom:userInterfaceIdiom];
    return [resourcePaths objectAtIndex:0 outOfRange:nil];
}


@end

