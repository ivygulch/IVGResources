//
//  IVGTypeMap.h
//  IVGUtils
//
//  Created by Douglas Sjoquist on 2/8/13.
//  Copyright (c) 2013 Ivy Gulch, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^IVGTypeMapSuccessBlock)(NSInteger value);

@interface IVGTypeMap : NSObject

- (id) initWithDictionary:(NSDictionary *) dictionary;

- (NSInteger) typeForDescription:(NSString *) description;
- (void) typeForDescription:(NSString *) description withSuccessBlock:(IVGTypeMapSuccessBlock) successBlock;
- (NSString *) descriptionForType:(NSInteger) type;

@end
