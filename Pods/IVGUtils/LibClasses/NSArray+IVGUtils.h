//
//  NSArray+IVGUtils.h
//  IVGUtils
//
//  Created by Douglas Sjoquist on 3/19/11.
//  Copyright 2011 Ivy Gulch, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray (IVGUtils)

- (NSArray *) randomized;
- (NSArray *) reversedArray;
- (NSArray *) filterArray:(BOOL (^)(id element)) filterBlock;

- (id) objectAtIndex:(NSUInteger) index outOfRange:(id) outOfRangeValue;
- (NSString *) descriptionDelimitedBy:(NSString *) delimiter;

+ (NSArray *) sortDescriptors:(NSString *)firstKey, ... NS_REQUIRES_NIL_TERMINATION;

@end

@interface NSMutableArray (IGUtils)

- (void) addIfNotNil:(id) item;

@end
