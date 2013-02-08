//
//  NSDate+IVGUtils.m
//  IVGUtils
//
//  Created by Douglas Sjoquist on 2/7/13.
//  Copyright (c) 2013 Ivy Gulch, LLC. All rights reserved.
//

#import "NSDate+IVGUtils.h"

@implementation NSDate (IVGUtils)

// creating a DateFormatter instance is pretty expensive, so creating a shared one makes sense
// DateFormatter is not threadsafe, so we need one per thread
// dwsjoquist 17-Aug-2012
+ (NSDateFormatter *) sharedDateFormatter;
{
    NSMutableDictionary *dictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *sharedDateFormatter = [dictionary objectForKey:@"sharedDateFormatter"];
    if (sharedDateFormatter == nil) {
        sharedDateFormatter = [[NSDateFormatter alloc] init];
        sharedDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        sharedDateFormatter.timeZone = [NSTimeZone systemTimeZone];
        [dictionary setObject:sharedDateFormatter forKey:@"sharedDateFormatter"];
    }
    return sharedDateFormatter;
}

+ (NSDate *) dateFromString:(NSString *) string withFormat:(NSString *) format timeZone:(NSTimeZone *) timeZone;
{
    if ([string isKindOfClass:[NSNull class]]) return nil;
    if (string.length == 0) return nil;

    NSDateFormatter *displayFormatter = [self sharedDateFormatter];
    [displayFormatter setDateFormat:format];
    [displayFormatter setTimeZone:timeZone];
	NSDate *date = [displayFormatter dateFromString:string];
	return date;
}

+ (NSDate *) dateFromString:(NSString *) string withFormat:(NSString *) format;
{
    return [self dateFromString:string withFormat:format timeZone:[NSTimeZone defaultTimeZone]];
}

+ (NSDate *) utcDateFromString:(NSString *) string withFormat:(NSString *) format;
{
    return [self dateFromString:string withFormat:format timeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
}

+ (NSDate *) dateFromYear:(NSInteger) year month:(NSInteger) month day:(NSInteger) day hour:(NSInteger) hour minute:(NSInteger) minute second:(NSInteger) second timeZone:(NSTimeZone *) timeZone;
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = year;
    dateComponents.month = month;
    dateComponents.day = day;
    dateComponents.hour = hour;
    dateComponents.minute = minute;
    dateComponents.second = second;
    dateComponents.timeZone = timeZone;
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

+ (NSDate *) dateFromYear:(NSInteger) year month:(NSInteger) month day:(NSInteger) day hour:(NSInteger) hour minute:(NSInteger) minute second:(NSInteger) second;
{
    return [self dateFromYear:year month:month day:day hour:hour minute:minute second:second timeZone:[NSTimeZone defaultTimeZone]];
}

+ (NSString *) stringFromDate:(NSDate *) date withFormat:(NSString *) format;
{
	return [date stringWithFormat:format];
}

+ (NSString *) utcStringFromDate:(NSDate *) date withFormat:(NSString *) format;
{
	return [date stringWithFormat:format timeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
}

- (NSString *) stringWithFormat:(NSString *) format timeZone:(NSTimeZone *) timeZone;
{
	NSDateFormatter *outputFormatter = [NSDate sharedDateFormatter];
	[outputFormatter setDateFormat:format];
    [outputFormatter setTimeZone:timeZone];
	NSString *timestamp_str = [outputFormatter stringFromDate:self];
	return timestamp_str;
}

- (NSString *) stringWithFormat:(NSString *) format;
{
    return [self stringWithFormat:format timeZone:[NSTimeZone defaultTimeZone]];
}

- (NSString *) utcStringWithFormat:(NSString *) format;
{
    return [self stringWithFormat:format timeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
}

@end
