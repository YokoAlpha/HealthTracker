//
//  AnimationView.m
//  HealthTracker
//
//  Created by Yoko Alpha on 05/04/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
// Used https://github.com/lichtschlag/Dazzle  To help me with working out how to do Particle effects
//

#import "AnimationView.h"

@interface AnimationView()
@property (nonatomic,strong) NSArray *animationPoints;
@property (nonatomic) NSInteger currentPointToAnimation;


@end

@implementation AnimationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    CGRect viewBounds = self.layer.bounds;
    // Create the emitter layer
    self.ringEmitter = [CAEmitterLayer layer];
    // Cells spawn in a 50pt circle around the position
    self.ringEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height/2.0);
    self.ringEmitter.emitterSize	= CGSizeMake(50, 0);
    self.ringEmitter.emitterMode	= kCAEmitterLayerOutline;
    self.ringEmitter.emitterShape	= kCAEmitterLayerCircle;
    self.ringEmitter.renderMode		= kCAEmitterLayerBackToFront;
    // Create the fire emitter cell
    CAEmitterCell* ring = [CAEmitterCell emitterCell];
    [ring setName:@"ring"];
    ring.birthRate			= 0;
    ring.velocity			= 250;
    ring.scale				= 0.5;
    ring.scaleSpeed			=-0.2;
    ring.greenSpeed			=-0.2;	// shifting to green
    ring.redSpeed			=-0.5;
    ring.blueSpeed			=-0.5;
    ring.lifetime			= 2;
    ring.color = [[UIColor whiteColor] CGColor];
    ring.contents = (id) [[UIImage imageNamed:@"Triangle"] CGImage];
    CAEmitterCell* circle = [CAEmitterCell emitterCell];
    [circle setName:@"circle"];
    circle.birthRate		= 5;			// every triangle creates 20
    circle.emissionLongitude = M_PI * 0.5;	// sideways to triangle vector
    circle.velocity			= 50;
    circle.scale			= 0.5;
    circle.scaleSpeed		=-0.2;
    circle.greenSpeed		=-0.1;	// shifting to blue
    circle.redSpeed			=-0.2;
    circle.blueSpeed		= 0.1;
    circle.alphaSpeed		=-0.2;
    circle.lifetime			= 4;
    circle.color = [[UIColor whiteColor] CGColor];
    circle.contents = (id) [[UIImage imageNamed:@"Ring"] CGImage];
    CAEmitterCell* star = [CAEmitterCell emitterCell];
    [star setName:@"star"];
    star.birthRate		= 5;	// every triangle creates 20
    star.velocity		= 100;
    star.zAcceleration  = -1;
    star.emissionLongitude = -M_PI;	// back from triangle vector
    star.scale			= 0.5;
    star.scaleSpeed		=-0.2;
    star.greenSpeed		=-0.1;
    star.redSpeed		= 0.4;	// shifting to red
    star.blueSpeed		=-0.1;
    star.alphaSpeed		=-0.2;
    star.lifetime		= 2;
    star.color = [[UIColor whiteColor] CGColor];
    star.contents = (id) [[UIImage imageNamed:@"StarOutline"] CGImage];
    // First traigles are emitted, which then spawn circles and star along their path
    self.ringEmitter.emitterCells = [NSArray arrayWithObject:ring];
    ring.emitterCells = [NSArray arrayWithObjects:circle, star, nil];
    //	circle.emitterCells = [NSArray arrayWithObject:star];	// this is SLOW!
    [self.layer addSublayer:self.ringEmitter];
    [self startAnimations];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(startAnimations) userInfo:nil repeats:YES];//Make sure animations repeat
}

- (void)startAnimations
{
    if(nil == self.animationPoints)//Create array if it has not allready been created.
    {
        self.animationPoints = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(50, 50)],[NSValue valueWithCGPoint:CGPointMake(50, 50)],[NSValue valueWithCGPoint:CGPointMake(150, 150)],[NSValue valueWithCGPoint:CGPointMake(300, 300)],[NSValue valueWithCGPoint:CGPointMake(0, 300)],[NSValue valueWithCGPoint:CGPointMake(100, 50)],[NSValue valueWithCGPoint:CGPointMake(50, 50)], nil];
        self.currentPointToAnimation = 0;
    }
    //Start animation from point in array
    if (self.currentPointToAnimation < 6)//Make sure we don't go over array
    {
        self.currentPointToAnimation++;//Add one on each time
    }
    else
    {
        self.currentPointToAnimation = 0;//Reset
    }
    //Animate at point
    NSValue *currentValue = (NSValue *)[self.animationPoints objectAtIndex:self.currentPointToAnimation];
    [self touchAtPosition:[currentValue CGPointValue]];
}


- (void)touchAtPosition:(CGPoint)position
{
	// Bling bling..
	CABasicAnimation *burst = [CABasicAnimation animationWithKeyPath:@"emitterCells.ring.birthRate"];
	burst.fromValue			= [NSNumber numberWithFloat: 125.0];	// short but intense burst
	burst.toValue			= [NSNumber numberWithFloat: 0.0];		// each birth creates 20 aditional cells!
	burst.duration			= 0.5;
	burst.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	[self.ringEmitter addAnimation:burst forKey:@"burst"];
	// Move to touch point
	[CATransaction begin];
	[CATransaction setDisableActions: YES];
	self.ringEmitter.emitterPosition	= position;
	[CATransaction commit];
}


@end
