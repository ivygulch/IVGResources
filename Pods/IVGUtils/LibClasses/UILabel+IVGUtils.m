//
//  UILabel+IVGUtils.m
//  IVGUtils
//
//  Created by Douglas Sjoquist on 09/01/11.
//  Copyright 2011 Ivy Gulch, LLC. All rights reserved.
//  Derived from:
//    http://stackoverflow.com/questions/1054558/how-do-i-vertically-align-text-within-a-uilabel
//

#import "UILabel+IVGUtils.h"

@implementation UILabel(IVGUtils)

- (void)alignTop {
    CGSize fontSize = [self.text sizeWithFont:self.font];
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;    //expected width of label
    CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text = [self.text stringByAppendingString:@"\n "];
}

- (void)alignBottom {
    CGSize fontSize = [self.text sizeWithFont:self.font];
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;    //expected width of label
    CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text = [NSString stringWithFormat:@" \n%@",self.text];
}

- (void)setText:(NSString *) text adjustHeightUsingLineBreakMode:(NSLineBreakMode) lineBreakMode {
    // calculate new size, but all we really want is the height
    CGSize originalSize = self.bounds.size;
    CGSize newSize = [text sizeWithFont:self.font constrainedToSize:originalSize lineBreakMode:lineBreakMode];

    // reset the existing frame to newly calculated size and ask label to sizeToFit
    self.frame = (CGRect){self.frame.origin,{self.bounds.size.width,newSize.height}};
    self.numberOfLines = 0;
    self.lineBreakMode = lineBreakMode;
    self.text = text;
    [self sizeToFit];
    
    // sizeToFit will also change the width, change it back since if the label is used again
    // (like in a table view cell), the starting point for the next time will be wrong
    self.frame = (CGRect){self.frame.origin,{originalSize.width,self.bounds.size.height}};
}

@end
