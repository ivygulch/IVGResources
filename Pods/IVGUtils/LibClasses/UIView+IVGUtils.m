//
//  UIView+IVGUtils.m
//  IVGUtils
//
//  Created by Douglas Sjoquist on 3/23/11.
//  Copyright 2011 Ivy Gulch, LLC. All rights reserved.
//

#import "UIView+IVGUtils.h"

@implementation UIView(IVGUtils)

- (NSString *) superviewDescription {
    NSString *result = @"";
    NSString *sep = @"";
    UIView *v = self;
    NSString *margin = @"";
    while (v) {
        result = [NSString stringWithFormat:@"%@%@%@%@", result, sep, margin, v];
        v = v.superview;
        margin = [NSString stringWithFormat:@"%@    ", margin];
        sep = @"\n";
    }    
    return result;
}

- (id) findSuperviewIsKindOfClass: (Class) clazz {
    UIView *v = self.superview;
    while (v) {
        if ([v isKindOfClass:clazz]) {
            return v;
        }
        v = v.superview;
    }    
    return nil;
}

- (void) logSizes:(NSString *) desc {
        NSLog(@"%@: f=[%0.1f,%0.1f %0.1f,%0.1f]  b=[%0.1f,%0.1f %0.1f,%0.1f]  c=[%0.1f,%0.1f]", 
              desc, 
              self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height,
              self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height,
              self.center.x, self.center.y
              );
}

- (void) removeAllGestureRecognizers {
    NSArray *recognizers = [NSArray arrayWithArray:self.gestureRecognizers];
    for (UIGestureRecognizer *recognizer in recognizers) {
        [self removeGestureRecognizer:recognizer];
    }
}

- (void) setOriginYBelow:(UIView *) baseView withGap:(CGFloat) gap;
{
    if (!baseView || baseView.hidden) {
        return; // do nothing
    }
    self.frame = (CGRect) {
        {self.frame.origin.x, baseView.frame.origin.y + baseView.bounds.size.height + gap},
        self.bounds.size
    };
}

- (CGFloat) bottom;
{
    return self.frame.origin.y + self.bounds.size.height;
}

- (CGFloat) bottomOfLowestSubview;
{
    return [UIView bottomOfLowestView:self.subviews];
}

- (CGFloat) topOfHighestSubview;
{
    return [UIView topOfHighestView:self.subviews];
}

+ (void) updateFrame:(UIView *) view x:(CGFloat) x {
    view.frame = (CGRect) {{x, view.frame.origin.y}, view.frame.size};
}

+ (void) updateFrame:(UIView *) view w:(CGFloat) w {
    view.frame = (CGRect) {view.frame.origin, {w, view.frame.size.height}};
}

+ (CGFloat) bottomOfLowestView:(NSArray *) views;
{
    CGFloat bottom = 0;
    for (UIView *view in views) {
        if (!view.hidden) {
            bottom = MAX(bottom, [view bottom]);
        }
    }
    return bottom;
}

+ (CGFloat) topOfHighestView:(NSArray *) views;
{
    CGFloat top = CGFLOAT_MAX;
    for (UIView *view in views) {
        if (!view.hidden) {
            top = MIN(top, view.frame.origin.y);
        }
    }
    return (top == CGFLOAT_MAX) ? 0 : top;
}


@end
