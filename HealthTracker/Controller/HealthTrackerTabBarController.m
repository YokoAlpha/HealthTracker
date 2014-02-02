//
//  HealthTrackerTabBarController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 02/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "HealthTrackerTabBarController.h"

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
}

- (void)viewDidAppear:(BOOL)animated
{
    if (NO == self.hasSetupScreenBeenPresentedYet)
    {
        if (NO == [[NSUserDefaults standardUserDefaults]boolForKey:@"enteredSetupPrefs"])
        {
            [self performSegueWithIdentifier:@"showSetupVC" sender:self];
            self.hasSetupScreenBeenPresentedYet = YES;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
