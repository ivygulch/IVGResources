//
//  IVGRSResourceInstanceSpec.m
//  IVGResources
//
//  Created by Douglas Sjoquist on 2/7/13.
//  Copyright (c) 2013 Ivy Gulch, LLC. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "IVGRSResourceInstance.h"

SPEC_BEGIN(IVGRSResourceInstanceSpec)

describe(@"ResourceInstance", ^{

    it(@"should work", ^{
        IVGRSResourceInstance *ri = [[IVGRSResourceInstance alloc] init];
        [ri shouldNotBeNil];
    });

});

SPEC_END