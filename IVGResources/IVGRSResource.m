//
//  IVGRSResource.m
//  IVGResources
//
//  Created by Douglas Sjoquist on 2/7/13.
//  Copyright (c) 2013 Ivy Gulch, LLC. All rights reserved.
//

#import "IVGRSResource.h"
#import "IVGRSUtils.h"

NSNumber *makekey(kIVGRSResourceOrientation orientation, kIVGRSResourceScale scale, kIVGRSResourceDevice device) {
    return [NSNumber numberWithInteger:(combinedPriority(orientation,scale,device) << 24) | (orientation << 16) | (scale << 8) | device];
}

@interface IVGRSResource()
@property (nonatomic,copy,readonly) NSString *baseName;
@property (nonatomic,copy,readonly) NSString *extension;
@property (nonatomic,strong) NSDictionary *resourceInstances;
@property (nonatomic,strong) NSOrderedSet *orderedResourceInstanceKeys;
@end

@implementation IVGRSResource

+ (NSDictionary *) suffixes;
{
    static dispatch_once_t pred_shared_instance;
    static NSDictionary *_sharedInstance = nil;
    dispatch_once(&pred_shared_instance, ^{
        NSMutableDictionary *instances = [NSMutableDictionary dictionaryWithCapacity:48];
        for (kIVGRSResourceOrientation orientation=kIVGRSResourceOrientationMin; orientation<=kIVGRSResourceOrientationMax; orientation++) {
            for(kIVGRSResourceScale scale=kIVGRSResourceScaleMin; scale<=kIVGRSResourceScaleMax; scale++) {
                for (kIVGRSResourceDevice device=kIVGRSResourceDeviceMin; device<=kIVGRSResourceDeviceMax; device++) {
                    [instances setObject:makekey(orientation,scale,device) forKey:combinedText(orientation,scale,device)];
                }
            }
        }

        _sharedInstance = [NSDictionary dictionaryWithDictionary:instances];
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

- (IVGRSResourceInstance *) currentResourceInstance;
{
    return nil;
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

    for (NSString *filename in filenames) {
        if (![resourceNamesUsed containsObject:filename]) {
            NSString *fileBaseName = [filename stringByDeletingPathExtension];
            NSString *fileExtension = [filename pathExtension];
            if ([fileBaseName hasPrefix:self.baseName] && [fileExtension isEqualToString:self.extension]) {
                IVGRSResourceInstance *resourceInstance = [IVGRSResourceInstance resourceInstanceForDirectoryPath:directoryPath fileBaseName:fileBaseName extension:fileExtension];
                if (resourceInstance != nil) {
                    [resourceInstances setObject:resourceInstance forKey:filename];
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
    self.orderedResourceInstanceKeys = [NSOrderedSet orderedSetWithArray:[self.resourceInstances allKeys]];
}

- (IVGRSResourceInstance *) currentResourceInstanceForInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation;
{
    return [self resourceInstanceForInterfaceOrientation:interfaceOrientation
                                             screenScale:[UIScreen mainScreen].scale
                                              screenSize:[UIScreen mainScreen].bounds.size
                                      userInterfaceIdiom:[[UIDevice currentDevice] userInterfaceIdiom]];
}

- (IVGRSResourceInstance *) resourceInstanceForInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation
                                                        screenScale:(CGFloat) screenScale
                                                         screenSize:(CGSize) screenSize
                                                 userInterfaceIdiom:(UIUserInterfaceIdiom) userInterfaceIdiom;
{
    kIVGRSResourceOrientation orientation = orientationFromInterfaceOrientation(interfaceOrientation);
    kIVGRSResourceScale scale = scaleFromScreenScaleAndSize(screenScale, screenSize);
    kIVGRSResourceDevice device = deviceFromUserIntefaceIdiom(userInterfaceIdiom);

    IVGRSResourceInstance *result = [self.resourceInstances objectForKey:makekey(orientation, scale, device)];
    
}


@end
