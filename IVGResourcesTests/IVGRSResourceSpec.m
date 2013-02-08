//
//  IVGRSResourceSpec.m
//  IVGResources
//
//  Created by Douglas Sjoquist on 2/7/13.
//  Copyright (c) 2013 Ivy Gulch, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Kiwi/Kiwi.h>
#import "IVGRSConstants.h"
#import "IVGRSUtils.h"
#import "IVGRSResource.h"
#import "NSString+IVGUtils.h"

@interface IVGRSResource(testing)
@property (nonatomic,strong) NSDictionary *resourceInstances;
- (void) rebuildResourceInstances;
@end

@implementation KWSpec(helper)

+ (NSString *) temporaryFilesWithName:(NSString *) name qualifiers:(NSArray *) qualifiers;
{
    NSString *baseName = [name stringByDeletingPathExtension];
    NSString *extension = [name pathExtension];
    NSString *tempPath = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString UUID]];
    [[NSFileManager defaultManager] createDirectoryAtPath:tempPath withIntermediateDirectories:NO attributes:nil error:nil];
    for (NSString *qualifier in qualifiers) {
        NSString *filename = [NSString stringWithFormat:@"%@%@.%@", baseName, qualifier, extension];
        NSString *path = [tempPath stringByAppendingPathComponent:filename];
        NSData *data = [path dataUsingEncoding:NSUTF8StringEncoding];
        [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
    }
    return tempPath;
}

@end

SPEC_BEGIN(IVGRSResourceSpec)

describe(@"Resource", ^{

    context(@"rebuildResourceInstances should create resource for each valid temp file", ^{
        NSString *name = @"test1.png";
        NSArray *qualifiers = @[@"",@"-568h@2x~iphone"];
        NSString *tmpDir = [self temporaryFilesWithName:name qualifiers:qualifiers];
        IVGRSResource *resource = [[IVGRSResource alloc] initWithBasePath:tmpDir name:name];
        [resource rebuildResourceInstances];

        [[resource.resourceInstances should] haveCountOf:[qualifiers count]];
    });

    context(@"rebuildResourceInstances should not create resource for invalid temp file", ^{
        NSString *name = @"test1.png";
        NSArray *qualifiers = @[@"-InvalidQualifier"];
        NSString *tmpDir = [self temporaryFilesWithName:name qualifiers:qualifiers];
        IVGRSResource *resource = [[IVGRSResource alloc] initWithBasePath:tmpDir name:name];
        [resource rebuildResourceInstances];

        [[resource.resourceInstances should] haveCountOf:0];
    });

    context(@"resourceResourcePaths should find valid files for retina iphone 4", ^{
        NSString *name = @"test1.png";
        NSArray *qualifiers = @[@"",@"-568h@2x~iphone",@"@2x"];
        NSString *tmpDir = [self temporaryFilesWithName:name qualifiers:qualifiers];
        IVGRSResource *resource = [[IVGRSResource alloc] initWithBasePath:tmpDir name:name];

        NSArray *paths = [resource resourcePathsForInterfaceOrientation:UIInterfaceOrientationPortrait screenScale:2.0 screenSize:CGSizeMake(320,480) userInterfaceIdiom:UIUserInterfaceIdiomPhone];
        [[paths should] haveCountOf:2];
        [[[paths objectAtIndex:0] should] equal:[tmpDir stringByAppendingPathComponent:@"test1@2x.png"]];
        [[[paths objectAtIndex:1] should] equal:[tmpDir stringByAppendingPathComponent:@"test1.png"]];

        NSString *highestPriorityPath = [resource resourcePathForInterfaceOrientation:UIInterfaceOrientationPortrait screenScale:2.0 screenSize:CGSizeMake(320,480) userInterfaceIdiom:UIUserInterfaceIdiomPhone];
        [[highestPriorityPath should] equal:[tmpDir stringByAppendingPathComponent:@"test1@2x.png"]];
    });

    context(@"resourceResourcePaths should find valid files for retina iphone 5", ^{
        NSString *name = @"test1.png";
        NSArray *qualifiers = @[@"",@"-568h@2x~iphone",@"@2x"];
        NSString *tmpDir = [self temporaryFilesWithName:name qualifiers:qualifiers];
        IVGRSResource *resource = [[IVGRSResource alloc] initWithBasePath:tmpDir name:name];

        NSArray *paths = [resource resourcePathsForInterfaceOrientation:UIInterfaceOrientationPortrait screenScale:2.0 screenSize:CGSizeMake(320,568) userInterfaceIdiom:UIUserInterfaceIdiomPhone];
        [[paths should] haveCountOf:2];
        [[[paths objectAtIndex:0] should] equal:[tmpDir stringByAppendingPathComponent:@"test1-568h@2x~iphone.png"]];
        [[[paths objectAtIndex:1] should] equal:[tmpDir stringByAppendingPathComponent:@"test1.png"]];

        NSString *highestPriorityPath = [resource resourcePathForInterfaceOrientation:UIInterfaceOrientationPortrait screenScale:2.0 screenSize:CGSizeMake(320,568) userInterfaceIdiom:UIUserInterfaceIdiomPhone];
        [[highestPriorityPath should] equal:[tmpDir stringByAppendingPathComponent:@"test1-568h@2x~iphone.png"]];
    });

    context(@"resourceResourcePaths should find valid files for retina iPad", ^{
        NSString *name = @"test1.png";
        NSArray *qualifiers = @[@"",@"-568h@2x~iphone",@"@2x"];
        NSString *tmpDir = [self temporaryFilesWithName:name qualifiers:qualifiers];
        IVGRSResource *resource = [[IVGRSResource alloc] initWithBasePath:tmpDir name:name];

        NSArray *paths = [resource resourcePathsForInterfaceOrientation:UIInterfaceOrientationPortrait screenScale:2.0 screenSize:CGSizeMake(768,1024) userInterfaceIdiom:UIUserInterfaceIdiomPad];
        [[paths should] haveCountOf:1];
        [[[paths objectAtIndex:1] should] equal:[tmpDir stringByAppendingPathComponent:@"test1.png"]];

        NSString *highestPriorityPath = [resource resourcePathForInterfaceOrientation:UIInterfaceOrientationPortrait screenScale:2.0 screenSize:CGSizeMake(768,1024) userInterfaceIdiom:UIUserInterfaceIdiomPad];
        [[highestPriorityPath should] equal:[tmpDir stringByAppendingPathComponent:@"test1.png"]];
    });

    context(@"resourceResourcePaths should not find valid files for iPad", ^{
        NSString *name = @"test1.png";
        NSArray *qualifiers = @[@"-568h@2x~iphone",@"@2x"];
        NSString *tmpDir = [self temporaryFilesWithName:name qualifiers:qualifiers];
        IVGRSResource *resource = [[IVGRSResource alloc] initWithBasePath:tmpDir name:name];

        NSArray *paths = [resource resourcePathsForInterfaceOrientation:UIInterfaceOrientationPortrait screenScale:1.0 screenSize:CGSizeMake(768,1024) userInterfaceIdiom:UIUserInterfaceIdiomPad];
        [[paths should] haveCountOf:0];

        NSString *highestPriorityPath = [resource resourcePathForInterfaceOrientation:UIInterfaceOrientationPortrait screenScale:1.0 screenSize:CGSizeMake(768,1024) userInterfaceIdiom:UIUserInterfaceIdiomPad];
        [highestPriorityPath shouldBeNil];
    });

});

SPEC_END
