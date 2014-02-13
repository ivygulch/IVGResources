//
//  NSOrderedSet+IVGUtils.m
//  MyFactor
//
//  Created by Douglas Sjoquist on 12/6/12.
//  Copyright (c) 2012 Ivy Gulch, LLC. All rights reserved.
//

#import "NSOrderedSet+IVGUtils.h"

@implementation NSOrderedSet (IVGUtils)

- (id) objectAtIndex:(NSUInteger) index outOfRange:(id) outOfRangeValue;
{
    if (index < [self count]) {
        return [self objectAtIndex:index];
    } else {
        return outOfRangeValue;
    }
}

@end
