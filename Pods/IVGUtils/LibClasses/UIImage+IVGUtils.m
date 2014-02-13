//
//  UIImage+IVGUtils.m
//  IVGUtils
//
//  Created by Douglas Sjoquist on 3/12/13.
//  Copyright (c) 2013 Ivy Gulch, LLC. All rights reserved.
//

#import "UIImage+IVGUtils.h"

@implementation UIImage (IVGUtils)

- (UIImage *) scaleToSize:(CGSize) size;
{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *) scale:(CGFloat) scale;
{
    CGSize size = CGSizeMake(self.size.width*scale,self.size.height*scale);
    return [self scaleToSize:size];
}

+ (UIImage *) imageNamed:(NSString *)name inDirectory:(NSString *) directory;
{
    UIImage *image = [UIImage imageWithContentsOfFile:[directory stringByAppendingPathComponent:name]];
//    CGFloat screenScale = [[UIScreen mainScreen] scale];
//    if (screenScale > 1.0) {
//        image = [image scale:screenScale];
//    }
    return image;
}

@end
