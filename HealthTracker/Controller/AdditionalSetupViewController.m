//
//  AdditionalSetupViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 02/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "AdditionalSetupViewController.h"

@interface AdditionalSetupViewController ()
@property (nonatomic) BOOL *relevantFeedback;
@end

@implementation AdditionalSetupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
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
    self.title = @"Notifications";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    //NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    //[standardUserDefaults setBool:YES forKey:@"enteredSetupPrefs"];//Make sure setup not shown again.
}

@end
