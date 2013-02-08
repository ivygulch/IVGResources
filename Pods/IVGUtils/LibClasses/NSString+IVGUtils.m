//
//  NSString+IVGUtils.m
//  IVGUtils
//
//  Created by Douglas Sjoquist on 3/18/11.
//  Copyright 2011 Ivy Gulch, LLC. All rights reserved.
//

#import "NSString+IVGUtils.h"

@implementation NSString(IVGUtils)

+ (NSString *) UUID {
    // create a new UUID which you own
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    
    // return a new CFStringRef (toll-free bridged to NSString) that we own
    return (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
}

- (BOOL) haveValue {
    return [self length] > 0;
}

- (NSString *) trimAllLeading:(NSString *) value;
{
    NSUInteger lenValue = [value length];
    if (lenValue == 0) {
        return self;
    }
    
    NSRange range = (NSRange) {0,lenValue};
    NSMutableString *ms = [NSMutableString stringWithString:self];
    while ([ms hasPrefix:value]) {
        [ms replaceCharactersInRange:range withString:@""];
    }
    return [NSString stringWithString:ms];
}

- (NSString *) trimAllTrailing:(NSString *) value;
{
    NSUInteger lenValue = [value length];
    if (lenValue == 0) {
        return self;
    }
    
    NSMutableString *ms = [NSMutableString stringWithString:self];
    while ([ms hasSuffix:value]) {
        NSRange range = (NSRange) {[ms length]-lenValue,lenValue};
        [ms replaceCharactersInRange:range withString:@""];
    }
    return [NSString stringWithString:ms];
}

- (NSString *) trimMatchingLeadingTrailing:(NSString *) value;
{
    NSUInteger lenValue = [value length];
    if (lenValue == 0) {
        return self;
    }

    if ([self hasSuffix:value] && [self hasPrefix:value]) {
        NSMutableString *ms = [NSMutableString stringWithString:self];
        [ms replaceCharactersInRange:(NSRange) {0,lenValue} withString:@""];
        if ([ms length] > 0) {
            [ms replaceCharactersInRange:(NSRange) {[ms length]-lenValue,lenValue} withString:@""];
        }
        return [NSString stringWithString:ms];
    } else {
        return self;
    }
}

+ (NSString *) binaryStringWithInteger:(int32_t) x bitCount:(NSUInteger) bitCount leftPad:(BOOL) leftPad;
{
    static char b[33];
    b[0] = '\0';

    uint32_t start = 1 << (bitCount-1);
    BOOL everOn = NO;
    for (uint32_t z = start; z > 0; z >>= 1)
    {
        BOOL on = (x & z) == z;
        everOn |= on;
        if (leftPad || everOn || (z == 1)) {
            strcat(b, (on ? "1" : "0"));
        }
    }

    return [NSString stringWithCString:b encoding:NSUTF8StringEncoding];
}

@end
