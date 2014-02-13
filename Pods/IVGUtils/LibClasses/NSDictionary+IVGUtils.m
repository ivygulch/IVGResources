//
//  NSDictionary+IVGUtils.m
//  IVGUtils
//
//  Created by Douglas Sjoquist on 2/11/13.
//  Copyright (c) 2013 Ivy Gulch, LLC. All rights reserved.
//

#import "NSDictionary+IVGUtils.h"

@implementation NSDictionary (IVGUtils)

- (CGRect) CGRectValue;
{
    CGRect r;
    CGRectMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)(self), &r);
    return r;
}

+ (NSDictionary *) dictionaryWithCGRect:(CGRect) r;
{
    return [NSDictionary dictionaryWithDictionary:CFBridgingRelease(CGRectCreateDictionaryRepresentation(r))];
}

@end
