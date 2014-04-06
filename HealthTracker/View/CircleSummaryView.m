//
//  CircleSummaryView.m
//  HealthTracker
//
//  Created by Yoko Alpha on 09/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "CircleSummaryView.h"

@interface CircleSummaryView()
@property (nonatomic,weak) UIColor *colour;
@end
@implementation CircleSummaryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Color
    UIColor *color = nil;
    if (nil == self.colour)
    {
        color = [UIColor colorWithRed:216/255.0f green:247/255.0f blue:160/255.0f alpha:1.0f];
    }
    else
    {
        color = self.colour;
    }
    //Shadow
    UIColor* shadow = [UIColor blackColor];
    CGSize shadowOffset = CGSizeMake(0.1, -0.1);
    CGFloat shadowBlurRadius = 12.5;
    //Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: rect];
    [color setFill];
    [ovalPath fill];
                              
    //Oval Inner Shadow
    CGRect ovalBorderRect = CGRectInset([ovalPath bounds], -shadowBlurRadius, -shadowBlurRadius);
    ovalBorderRect = CGRectOffset(ovalBorderRect, -shadowOffset.width, -shadowOffset.height);
    ovalBorderRect = CGRectInset(CGRectUnion(ovalBorderRect, [ovalPath bounds]), -1, 1);
    
    UIBezierPath* ovalNegativePath = [UIBezierPath bezierPathWithRect:ovalBorderRect];
    [ovalNegativePath appendPath:ovalPath];
    ovalNegativePath.usesEvenOddFillRule =YES;
    
    CGContextSaveGState(context);
    {
        CGFloat xOffset = shadowOffset.width + round(ovalBorderRect.size.width);
        CGFloat yOffset = shadowOffset.height;
        CGContextSetShadowWithColor(context, CGSizeMake(xOffset +copysign(0.1, xOffset), yOffset + copysign(0.1,yOffset)),
                                    shadowBlurRadius, shadow.CGColor);
        [ovalPath addClip];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(ovalBorderRect.size.width), 0);
        [ovalNegativePath applyTransform:transform];
        [[UIColor grayColor] setFill];
        [ovalNegativePath fill];
    }
    CGContextRestoreGState(context);
}

- (void)updateColor:(UIColor *)colour
{
    self.colour = colour;
    [self.layer display];
}

@end
