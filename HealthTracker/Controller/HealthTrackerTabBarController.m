//
//  HealthTrackerTabBarController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 02/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "HealthTrackerTabBarController.h"
#import "HealthTracker.h"

@interface HealthTrackerTabBarController ()
@property (nonatomic)BOOL hasSetupScreenBeenPresentedYet;
@end

@implementation HealthTrackerTabBarController

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBadgeCounts) name:healthTrackerDidUpdateNotification object:[HealthTracker sharedHealthTracker]];//Adds observer which will be used if the data updates to change the on screen labels.
    [self updateBadgeCounts];//Updates the current badge count on the screen
}

- (void)viewDidAppear:(BOOL)animated
{
    if (NO == self.hasSetupScreenBeenPresentedYet)//If the setup screen has not been presented yet
    {
        if (NO == [[NSUserDefaults standardUserDefaults]boolForKey:@"enteredSetupPrefs"])//If the setup screen has never been presented before
        {
            [self performSegueWithIdentifier:@"showSetupVC" sender:self];//transfer to the setup screen
            self.hasSetupScreenBeenPresentedYet = YES;//Make sure the screen is not shown again for this session
        }
    }
    
}

- (void)updateBadgeCounts
{
    //Update BMI
    UITabBarItem *tbi = (UITabBarItem *)[self.tabBar.items objectAtIndex:1];//Get the BMI bar button item
    double bmiCount = [HealthTracker sharedHealthTracker].bmiCount;//Get the users current BMI score
    if (isnan(bmiCount))//If not a natrual number
    {
        bmiCount = 0.0;//Reset back to 0
    }
    tbi.badgeValue = [NSString stringWithFormat:@"%ld",(long)bmiCount];//Update badge count
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return NO;//Not allowed to rotate to a differnt orientation
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;//Tell the tab bar to remain in portrait
}

@end
