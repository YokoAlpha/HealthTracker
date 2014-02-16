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
@property (nonatomic,strong)User *userDetails;
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
    self.userDetails = [[HealthTracker sharedHealthTracker]retrieveUserData];
    if ([self.userDetails.measurementSystem isEqualToString:@"Imperial"])
    {
        self.measurementSystem.selectedSegmentIndex = 1;
    }
    else if ([self.userDetails.measurementSystem isEqualToString:@"Metric"])
    {
        self.measurementSystem.selectedSegmentIndex = 0;
    }
    else
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
    if (1 == self.measurementSystem.selectedSegmentIndex)
    {
        self.userDetails.measurementSystem = @"Imperial";
    }
    else
    {
        self.userDetails.measurementSystem = @"Metric";
    }
    [[HealthTracker sharedHealthTracker]updateUser:self.userDetails];
}

@end
