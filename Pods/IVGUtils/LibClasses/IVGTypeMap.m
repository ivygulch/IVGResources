//
//  IVGTypeMap.m
//  IVGUtils
//
//  Created by Douglas Sjoquist on 2/8/13.
//  Copyright (c) 2013 Ivy Gulch, LLC. All rights reserved.
//

#import "IVGTypeMap.h"

@interface IVGTypeMap()
@property (nonatomic,strong) NSMutableDictionary *typeToDescription;
@property (nonatomic,strong) NSMutableDictionary *descriptionToType;
@end

@implementation IVGTypeMap

- (id) initWithDictionary:(NSDictionary *) dictionary;
{
    if ((self = [super init])) {
        _typeToDescription = [NSMutableDictionary dictionaryWithCapacity:[dictionary count]];
        _descriptionToType = [NSMutableDictionary dictionaryWithCapacity:[dictionary count]];
        [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([key isKindOfClass:[NSNumber class]] && [obj isKindOfClass:[NSString class]]) {
                [_typeToDescription setObject:obj forKey:key];
                [_descriptionToType setObject:key forKey:obj];
            } else if ([key isKindOfClass:[NSString class]] && [obj isKindOfClass:[NSNumber class]]) {
                [_typeToDescription setObject:key forKey:obj];
                [_descriptionToType setObject:obj forKey:key];
            }
        }];
    }
    return self;
}

- (NSInteger) typeForDescription:(NSString *) description;
{
    NSNumber *value = [self.descriptionToType objectForKey:description];
    return (value == nil) ? NSNotFound : [value integerValue];
}

- (void) typeForDescription:(NSString *) description withSuccessBlock:(IVGTypeMapSuccessBlock) successBlock;
{
    if (description != nil) {
        NSInteger type = [self typeForDescription:description];
        if (type != NSNotFound) {
            successBlock(type);
        }
    }
}

- (NSString *) descriptionForType:(NSInteger) type;
{
    return [self.typeToDescription objectForKey:@(type)];
}

@end
