//
//  NSString+IVGUtils.h
//  IVGUtils
//
//  Created by Douglas Sjoquist on 3/18/11.
//  Copyright 2011 Ivy Gulch, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IVGUtils)

+ (NSString *) UUID;

- (BOOL) hasValue;

- (NSString *) removeCharactersInSet:(NSCharacterSet *) characterSet;
- (NSString *) trim;
- (NSString *) trimAllLeading:(NSString *) value;
- (NSString *) trimAllTrailing:(NSString *) value;
- (NSString *) trimMatchingLeadingTrailing:(NSString *) value;

- (BOOL) matches:(NSString *) searchText;

@end
