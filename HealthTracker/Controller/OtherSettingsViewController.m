//
//  OtherSettingsViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 16/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "OtherSettingsViewController.h"
#import "HealthTracker.h"

@interface OtherSettingsViewController ()
@end

@implementation OtherSettingsViewController

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
}

- (void)viewDidAppear:(BOOL)animated
{
    [self updateOnScreenElements];
}

- (void)updateOnScreenElements
{
    UserDescription *userDetails = [[HealthTracker sharedHealthTracker]retrieveUserData];
    if ([userDetails.measurementSystem isEqualToString:@"Imperial"])
    {
        self.measurementSystem.selectedSegmentIndex = 1;
    }
    else if ([userDetails.measurementSystem isEqualToString:@"Metric"])
    {
        self.measurementSystem.selectedSegmentIndex = 0;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateOtherSettings:(id)sender
{
    UserDescription *userDetails = [[HealthTracker sharedHealthTracker]retrieveUserData];
    if (1 == self.measurementSystem.selectedSegmentIndex)
    {
        userDetails.measurementSystem = @"Imperial";
    }
    else
    {
        userDetails.measurementSystem = @"Metric";
    }
    [[HealthTracker sharedHealthTracker]updateUser:userDetails];
}

@end
