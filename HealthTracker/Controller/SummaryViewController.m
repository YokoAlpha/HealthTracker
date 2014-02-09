//
//  SummaryViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 13/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "SummaryViewController.h"

@interface SummaryViewController ()

@end

@implementation SummaryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.topbarView.layer.cornerRadius = 16.0f;//Add rounded corners to views
    self.bottombarView.layer.cornerRadius = 16.0f;//Add rounded corners to views
    [self isUserDoingWell:3];
}

/*
    Method to show how well the user s
 */
- (void)isUserDoingWell:(NSInteger)currentState
{
    if (1 == currentState)
    {
        //User is doing well
        [self.topbarView setBackgroundColor:[UIColor colorWithRed:216/255.0f green:247/255.0f blue:160/255.0f alpha:1.0f]];
        [self.bottombarView setBackgroundColor:[UIColor colorWithRed:216/255.0f green:247/255.0f blue:160/255.0f alpha:1.0f]];
        [self.circleView updateColor:[UIColor colorWithRed:216/255.0f green:247/255.0f blue:160/255.0f alpha:1.0f]];
    }
    else if (2 == currentState)
    {
        //User is doing ok
        self.topbarView.backgroundColor = [UIColor colorWithRed:239/255.0f green:143/255.0f blue:60/255.0f alpha:1.0f];
        self.bottombarView.backgroundColor = [UIColor colorWithRed:239/255.0f green:143/255.0f blue:60/255.0f alpha:1.0f];
        [self.circleView updateColor:[UIColor colorWithRed:239/255.0f green:143/255.0f blue:60/255.0f alpha:1.0f]];
    }
    else if (3 == currentState)
    {
        //User is doing bad
        self.topbarView.backgroundColor = [UIColor colorWithRed:237/255.0f green:70/255.0f blue:47/255.0f alpha:1.0f];
        self.bottombarView.backgroundColor = [UIColor colorWithRed:237/255.0f green:70/255.0f blue:47/255.0f alpha:1.0f];
        [self.circleView updateColor:[UIColor colorWithRed:237/255.0f green:70/255.0f blue:47/255.0f alpha:1.0f]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
