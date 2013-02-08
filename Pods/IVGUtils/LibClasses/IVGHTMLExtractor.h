//
//  IVGHTMLExtractor.h
//  IVGUtils
//
//  Created by Douglas Sjoquist on 2/4/13.
//  Copyright (c) 2013 Ivy Gulch, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^IVGHTMLReturnBlock)(NSURL *url, NSString *idToExtract, NSString *html, NSError *error);

@interface IVGHTMLExtractor : NSObject

- (void) extractId:(NSString *) idToExtract fromURL:(NSString *) urlStr withReturnBlock:(IVGHTMLReturnBlock) returnBlock;

@end
