//
//  PortraitNavigationController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 05/04/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "PortraitNavigationController.h"

@interface PortraitNavigationController ()

@end

@implementation PortraitNavigationController

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;//Can only user portrait orientation
}

@end
