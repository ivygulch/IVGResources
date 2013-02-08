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

@interface TestableIVGRSResource : IVGRSResource
@end
@implementation TestableIVGRSResource
- (NSString *) bundleResourcePath;
{
    return [[NSBundle bundleWithIdentifier:@"com.ivygulch.IVGResourcesTests"] resourcePath];
}
@end

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

    context(@"should create resource for each valid temp file", ^{
        NSString *name = @"test1.png";

        [name shouldBeNil];

        NSArray *qualifiers = @[@"",@"-568h@2x~iphone"];
        NSString *tmpDir = [self temporaryFilesWithName:name qualifiers:qualifiers];
        IVGRSResource *resource = [[IVGRSResource alloc] initWithBasePath:tmpDir name:name];
        [resource rebuildResourceInstances];

        [[resource.resourceInstances should] haveCountOf:[qualifiers count]];
    });

    context(@"should not create resource for invalid temp file", ^{
        NSString *name = @"test1.png";
        NSArray *qualifiers = @[@"-InvalidQualifier"];
        NSString *tmpDir = [self temporaryFilesWithName:name qualifiers:qualifiers];
        IVGRSResource *resource = [[IVGRSResource alloc] initWithBasePath:tmpDir name:name];
        [resource rebuildResourceInstances];

        [[resource.resourceInstances should] haveCountOf:0];
    });

    context(@"should find valid files for retina iphone 4", ^{
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

    context(@"should find valid files for retina iphone 5", ^{
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

    context(@"should find valid files for retina iPad", ^{
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

    context(@"should not find valid files for iPad", ^{
        NSString *name = @"test1.png";
        NSArray *qualifiers = @[@"-568h@2x~iphone",@"@2x"];
        NSString *tmpDir = [self temporaryFilesWithName:name qualifiers:qualifiers];
        IVGRSResource *resource = [[IVGRSResource alloc] initWithBasePath:tmpDir name:name];

        NSArray *paths = [resource resourcePathsForInterfaceOrientation:UIInterfaceOrientationPortrait screenScale:1.0 screenSize:CGSizeMake(768,1024) userInterfaceIdiom:UIUserInterfaceIdiomPad];
        [[paths should] haveCountOf:0];

        NSString *highestPriorityPath = [resource resourcePathForInterfaceOrientation:UIInterfaceOrientationPortrait screenScale:1.0 screenSize:CGSizeMake(768,1024) userInterfaceIdiom:UIUserInterfaceIdiomPad];
        [highestPriorityPath shouldBeNil];
    });

    context(@"should find valid files in appropriate directory", ^{
        NSString *name = @"testIVGRSResource.txt";
        NSArray *qualifiers = @[@"-568h@2x~iphone",@"@2x"];
        NSString *tmpDir = [self temporaryFilesWithName:name qualifiers:qualifiers];
        TestableIVGRSResource *resource = [[TestableIVGRSResource alloc] initWithBasePath:tmpDir name:name];
        NSString *bundleDir = [resource bundleResourcePath];

        NSArray *paths = [resource resourcePathsForInterfaceOrientation:UIInterfaceOrientationPortrait screenScale:2.0 screenSize:CGSizeMake(320,568) userInterfaceIdiom:UIUserInterfaceIdiomPhone];
        [[paths should] haveCountOf:3];
        NSLog(@"paths: %@", paths);
        [[[paths objectAtIndex:0] should] equal:[tmpDir stringByAppendingPathComponent:@"testIVGRSResource-568h@2x~iphone.txt"]];
        [[[paths objectAtIndex:1] should] equal:[tmpDir stringByAppendingPathComponent:@"testIVGRSResource@2x.txt"]];
        [[[paths objectAtIndex:2] should] equal:[bundleDir stringByAppendingPathComponent:@"testIVGRSResource.txt"]];
    });

});

SPEC_END
