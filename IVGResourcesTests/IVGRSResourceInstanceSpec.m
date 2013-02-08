//
//  IVGRSResourceInstanceSpec.m
//  IVGResources
//
//  Created by Douglas Sjoquist on 2/7/13.
//  Copyright (c) 2013 Ivy Gulch, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Kiwi/Kiwi.h>
#import "IVGRSResourceInstance.h"
#import "NSString+IVGUtils.h"

@implementation KWSpec(helper)

+ (NSString *) createTemporaryFilesWithBaseName:(NSString *) fileBaseName extension:(NSString *) extension qualifiers:(NSArray *) qualifiers;
{
    NSString *tempPath = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString UUID]];
    [[NSFileManager defaultManager] createDirectoryAtPath:tempPath withIntermediateDirectories:NO attributes:nil error:nil];
    for (NSString *qualifier in qualifiers) {
        NSString *filename = [NSString stringWithFormat:@"%@%@.%@", fileBaseName, qualifier, extension];
        NSString *path = [tempPath stringByAppendingPathComponent:filename];
        NSData *data = [path dataUsingEncoding:NSUTF8StringEncoding];
        [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
    }
    return tempPath;
}

@end

SPEC_BEGIN(IVGRSResourceInstanceSpec)

describe(@"ResourceInstance", ^{

    it(@"should work", ^{
        NSString *temporaryDir = [self createTemporaryFilesWithBaseName:@"test1" extension:@"png" qualifiers:@[@"",@"-568h@2x"]];
        IVGRSResourceInstance *ri = [IVGRSResourceInstance resourceInstanceForDirectoryPath:temporaryDir fileBaseName:@"test1" extension:@"png"];
        [ri shouldNotBeNil];
    });

});

SPEC_END
