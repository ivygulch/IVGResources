//
//  IVGCMResource.m
//  IVGContentManager
//
//  Created by Douglas Sjoquist on 2/7/13.
//  Copyright (c) 2013 Ivy Gulch, LLC. All rights reserved.
//

#import "IVGCMResource.h"

NSString * const kIVGCMNotification_resourceChangedSubresource = @"kIVGCMNotification_resourceChangedSubresource";


@implementation IVGCMSubresource



+ (IVGCMSubresource *) subresourceForResource:(IVGCMResource *) resource fileBaseName:(NSString *) fileBaseName extension:extension;
{
    NSCharacterSet *cs = [NSCharacterSet characterSetWithCharactersInString:@"-~@"];
    NSArray *components = [fileBaseName componentsSeparatedByCharactersInSet:cs];
    
}

@end



@interface IVGCMResource()
@property (nonatomic,copy,readonly) NSString *baseName;
@property (nonatomic,copy,readonly) NSString *extension;
@property (nonatomic,strong) NSMutableDictionary *subresources;
@end

@implementation IVGCMResource

- (id) initWithBasePath:(NSString *) basePath name:(NSString *) name;
{
    if ((self = [super init])) {
        _basePath = [basePath copy];
        _name = [name copy];
        _baseName = [name stringByDeletingPathExtension];
        _extension = [name pathExtension];
    }
    return self;
}

- (IVGCMSubresource *) currentSubresource;
{
    return nil;
}

- (void) appendSubresources:(NSMutableDictionary *) subresources fromPath:(NSString *) path error:(NSError **) error;
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray *filenames = [fileManager contentsOfDirectoryAtPath:path error:error];
    if (filenames == nil) {
        return;
    }

    for (NSString *filename in filenames) {
        NSString *fileBaseName = [filename stringByDeletingPathExtension];
        NSString *fileExtension = [filename pathExtension];
        if ([fileBaseName hasPrefix:self.baseName] && [fileExtension isEqualToString:self.extension]) {
            IVGCMSubresource *subresource = [IVGCMSubresource subresourceForResource:self fileBaseName:fileBaseName extension:fileExtension];
            if (subresource != nil) {
                [subresources setObject:subresource forKey:filename];
            }
        }
    }
}

- (void) rebuildSubresources;
{
    NSMutableDictionary *subresources = [NSMutableDictionary dictionaryWithCapacity:100];
    if (self.basePath != nil) {
        [self appendSubresources:subresources fromPath:self.basePath error:nil];
    }
    [self appendSubresources:subresources fromPath:[NSBundle mainBundle] ]
}

@end
