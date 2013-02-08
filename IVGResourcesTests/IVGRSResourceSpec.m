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
#import "IVGRSResource.h"
#import "NSString+IVGUtils.h"

@interface IVGRSResource(testing)
+ (NSDictionary *) suffixes;
@end

@implementation KWSpec(helper)

+ (void) suffix:(NSString *) suffix1 shouldBeGreaterThan:(NSString *) suffix2;
{
    NSNumber *value1 = [[IVGRSResource suffixes] objectForKey:suffix1];
    [value1 shouldNotBeNil];
    NSNumber *value2 = [[IVGRSResource suffixes] objectForKey:suffix2];
    [value2 shouldNotBeNil];

    [[theValue([value1 integerValue]) should] beGreaterThan:theValue([value2 integerValue])];
}

@end

SPEC_BEGIN(IVGRSResourceSpec)

describe(@"Resource", ^{
    NSString *defaultSuffix = combinedText(kIVGRSResourceOrientationDefault, kIVGRSResourceScaleDefault, kIVGRSResourceDeviceDefault);
    NSString *pud568iPhone = combinedText(kIVGRSResourceOrientationPortraitUpsideDown, kIVGRSResourceScale568h2X, kIVGRSResourceDeviceiPhone);
    NSString *p2XiPhone = combinedText(kIVGRSResourceOrientationPortrait, kIVGRSResourceScale2X, kIVGRSResourceDeviceiPhone);

    context(@"suffix priorities", ^{
        it(@"default should come after portraitUpsideDown 568h2X iPhone", ^{
            [self suffix:defaultSuffix shouldBeGreaterThan:pud568iPhone];
        });

        it(@"portrait 2x iPhone should come after portraitUpsideDown 568h2X iPhone", ^{
            [self suffix:p2XiPhone shouldBeGreaterThan:pud568iPhone];
        });
});

});

SPEC_END
