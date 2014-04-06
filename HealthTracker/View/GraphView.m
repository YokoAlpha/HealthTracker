//
//  GraphView.m
//  HealthTracker
//
//  Created by Yoko Alpha on 05/04/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "GraphView.h"

@implementation GraphView

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        // Initialization code
    }
    return self;
}

- (void)drawBarWithPercentage:(float)percentage
                withXPosition:(float)position
                   withColour:(UIColor *)colour
         withDescriptionText:(NSString *)descriptionText
      withPerspectiveLeftSide:(BOOL)isLeftSide//Used to set the 3d effect from the right or left
{
    //Work out width of bar
    float barWidth = BAR_WIDTH;
    float barMaxHeight = ((self.frame.size.height - (4.0f)) - 5);
    float barActualHeight = ((barMaxHeight - 20) / 100) * percentage;//Padding needs to be taken off the top (20) of it won't be given 3D effect
    float boxTopOrigin = 0;
    if(YES == isLeftSide)
    {
        boxTopOrigin = (position * 1.5) + (barWidth / 3);//Left
        
    }
    else
    {
        boxTopOrigin = (position * 1.5) - (barWidth / 3);//Right
    }
    //Draw bars on screen
    [colour set];
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(currentContext,1);
    //Front of Box
    CGContextMoveToPoint(currentContext,position * 1.5, barMaxHeight);
    CGContextAddLineToPoint(currentContext,position * 1.5, barMaxHeight - barActualHeight);
    CGContextAddLineToPoint(currentContext,(position * 1.5) + barWidth, barMaxHeight - barActualHeight);
    CGContextAddLineToPoint(currentContext,(position * 1.5) + barWidth, barMaxHeight);
    CGContextAddLineToPoint(currentContext,position * 1.5, barMaxHeight);
    
    CGContextFillPath(currentContext);
    //Top of Box
    [[self lighterColorForColor:colour
           withMuchLighterValue:0.2] set];
    CGContextMoveToPoint(currentContext,position * 1.5, barMaxHeight - barActualHeight);
    CGContextAddLineToPoint(currentContext,boxTopOrigin, (barMaxHeight - barActualHeight) - barWidth / 8);
    CGContextAddLineToPoint(currentContext,boxTopOrigin + barWidth, (barMaxHeight - barActualHeight) - barWidth / 8);
    CGContextAddLineToPoint(currentContext,(position * 1.5) + barWidth, barMaxHeight - barActualHeight);
    CGContextAddLineToPoint(currentContext,position * 1.5, barMaxHeight - barActualHeight);
    CGContextFillPath(currentContext);
    //Left hand side of box
    [[self lighterColorForColor:colour
           withMuchLighterValue:0.1] set];
    if(YES == isLeftSide)
    {
        CGContextMoveToPoint(currentContext,(position * 1.5) + barWidth, barMaxHeight - barActualHeight);
        CGContextAddLineToPoint(currentContext,(position * 1.5) + barWidth * 1.3, (barMaxHeight - barActualHeight) - barWidth / 8);
        CGContextAddLineToPoint(currentContext,(position * 1.5) + barWidth * 1.3, barMaxHeight - barWidth / 7.0);
        CGContextAddLineToPoint(currentContext, (position * 1.5) + barWidth, barMaxHeight);
        CGContextAddLineToPoint(currentContext, (position * 1.5) + barWidth, barMaxHeight - barActualHeight);
    }
    else
    {
        CGContextMoveToPoint(currentContext,position * 1.5, barMaxHeight - barActualHeight);
        CGContextAddLineToPoint(currentContext,boxTopOrigin, (barMaxHeight - barActualHeight) - barWidth / 8);
        CGContextAddLineToPoint(currentContext,(position * 1.5) - (barWidth / 3), barMaxHeight - barWidth / 7.0);
        CGContextAddLineToPoint(currentContext,position * 1.5, barMaxHeight);
        CGContextAddLineToPoint(currentContext,position * 1.5, barMaxHeight - barActualHeight);
    }
    CGContextFillPath(currentContext);
    CGContextStrokePath(currentContext);
    //Graph Bar Label
    UILabel *descriptionLabel = [[UILabel alloc]init];
    descriptionLabel.frame = CGRectMake(boxTopOrigin - BAR_WIDTH, 110, 220, 20);
    descriptionLabel.text = descriptionText;
    descriptionLabel.adjustsFontSizeToFitWidth = YES;
    descriptionLabel.textAlignment = NSTextAlignmentLeft;
    [descriptionLabel setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
    [self addSubview:descriptionLabel];
}

- (UIColor *)lighterColorForColor:(UIColor *)c
             withMuchLighterValue:(float)value
{
    CGFloat r, g, b, a;
    if([c getRed:&r green:&g blue:&b alpha:&a])
    {
        return [UIColor colorWithRed:MIN(r + value, 1.0)
                               green:MIN(g + value, 1.0)
                                blue:MIN(b + value, 1.0)
                               alpha:a];
    }
    return nil;
}

- (void)setupScreen
{
    //Draw bars on screen
    [[UIColor whiteColor] set];
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(currentContext,4.0f);
    CGContextMoveToPoint(currentContext,5.0f, 0);
    CGContextAddLineToPoint(currentContext,5.0f, self.frame.size.height);
    CGContextMoveToPoint(currentContext,5.0f, self.frame.size.height - (2.0f));
    CGContextAddLineToPoint(currentContext, self.frame.size.width,self.frame.size.height - (2.0f));
    CGContextStrokePath(currentContext);
    
    //Enlarge view to caiter for more bars
    float currentXPosition = 20;
    //Draw result bars
    for (int i = 0; i <self.arrayOfResultValues.count; i++)
    {
        BOOL perspective = NO;
//        if(i % 2)//Modules
//        {
//            // odd
//            perspective = YES;
//        }
//        else
//        {
//            // even
//            perspective = NO;
//        }
        
        //Bar color setup
        if([self.dataType isEqualToString:@"Run"])
        {
            float percentageToPlot = [[self.arrayOfResultValues objectAtIndex:i]floatValue];
            if(percentageToPlot > 1.0f)
            {
                //Cannot be over 100%
                percentageToPlot = 1.0f;
            }
            else if(percentageToPlot < 50)
            {
                self.barColor = [UIColor colorWithRed:237/255.0f green:70/255.0f blue:47/255.0f alpha:1.0f];//Bad
            }
            else if (percentageToPlot > 49 && percentageToPlot <70)
            {
                self.barColor  = [UIColor colorWithRed:239/255.0f green:143/255.0f blue:60/255.0f alpha:1.0f];//Ok
            }
            else if (percentageToPlot > 69 && percentageToPlot <=100)
            {
                self.barColor = [UIColor colorWithRed:216/255.0f green:247/255.0f blue:160/255.0f alpha:1.0f];//Good
            }
        }
        [self drawBarWithPercentage:[[self.arrayOfResultValues objectAtIndex:i]floatValue] withXPosition:currentXPosition withColour:self.barColor withDescriptionText:[self.arrayOfResultLabel objectAtIndex:i] withPerspectiveLeftSide:perspective];
        currentXPosition += BAR_WIDTH + BAR_SPACEING;
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self setupScreen];
}

@end
