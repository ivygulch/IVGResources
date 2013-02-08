//
//  NSDate+IVGUtils.h
//  IVGUtils
//
//  Created by Douglas Sjoquist on 2/7/13.
//  Copyright (c) 2013 Ivy Gulch, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (IVGUtils)

+ (NSDateFormatter *) sharedDateFormatter;
+ (NSDate *) dateFromString:(NSString *) string withFormat:(NSString *) format timeZone:(NSTimeZone *) timeZone;
+ (NSDate *) dateFromString:(NSString *) string withFormat:(NSString *) format;
+ (NSDate *) utcDateFromString:(NSString *) string withFormat:(NSString *) format;
+ (NSDate *) dateFromYear:(NSInteger) year month:(NSInteger) month day:(NSInteger) day hour:(NSInteger) hour minute:(NSInteger) minute second:(NSInteger) second timeZone:(NSTimeZone *) timeZone;
+ (NSDate *) dateFromYear:(NSInteger) year month:(NSInteger) month day:(NSInteger) day hour:(NSInteger) hour minute:(NSInteger) minute second:(NSInteger) second;
+ (NSString *) stringFromDate:(NSDate *) date withFormat:(NSString *) format;
+ (NSString *) utcStringFromDate:(NSDate *) date withFormat:(NSString *) format;

- (NSString *) stringWithFormat:(NSString *) format timeZone:(NSTimeZone *) timeZone;
- (NSString *) stringWithFormat:(NSString *) format;
- (NSString *) utcStringWithFormat:(NSString *) format;

@end
