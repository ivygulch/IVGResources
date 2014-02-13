//
//  UIImage+IVGUtils.h
//  IVGUtils
//
//  Created by Douglas Sjoquist on 3/12/13.
//  Copyright (c) 2013 Ivy Gulch, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (IVGUtils)

- (UIImage *) scaleToSize:(CGSize) size;
- (UIImage *) scale:(CGFloat) scale;
+ (UIImage *) imageNamed:(NSString *)name inDirectory:(NSString *) directory;

@end
