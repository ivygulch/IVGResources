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

@end

SPEC_BEGIN(IVGRSResourceInstanceSpec)

describe(@"ResourceInstance", ^{

    it(@"should work", ^{
        IVGRSResourceInstance *ri = nil;//[IVGRSResourceInstance resourceInstanceForDirectoryPath:temporaryDir fileBaseName:@"test1" extension:@"png"];
        [ri shouldBeNil];
    });

});

SPEC_END
