//
//  ProfileViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 13/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "ProfileViewController.h"
#import "UserSettingsViewController.h"
#import "NotificationsViewController.h"
#import "OtherSettingsViewController.h"


@interface ProfileViewController ()
@property (nonatomic,strong) UIViewController *embeddedVC;
@end

@implementation ProfileViewController

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
    UIViewController *vc = [self viewControllerForSegmentIndex:0];//Must start on Month view
    [self.settingsScreenSelector setSelectedSegmentIndex:0];//Change the segment at the top to dispay the start screen
    [self addChildViewController:vc];//Add in the first child view controller
    vc.view.frame = self.containerView.bounds;//Setup the frame size for it
    [self.containerView addSubview:vc.view];//Assign the view controller to the container view
    self.embeddedVC = vc;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentChanged:(UISegmentedControl *)sender
{
    UIViewController *vc = [self viewControllerForSegmentIndex:sender.selectedSegmentIndex];//Uses utilty method to find the view controller for each segment on the control
    [self addChildViewController:vc];//Adds the new child view controller in
    [self transitionFromViewController:self.embeddedVC toViewController:vc duration:0 options:UIViewAnimationOptionTransitionNone
                            animations:^{//Transition to the new controller
                                [self.embeddedVC.view removeFromSuperview];//Remove the existing one
                                vc.view.frame = self.containerView.bounds;//Assign its frame
                                [self.containerView addSubview:vc.view];//Add the new view
                            }
                            completion:^(BOOL finished)
     {
         //Update its parent
         [vc didMoveToParentViewController:self];
         [self.embeddedVC removeFromParentViewController];
         self.embeddedVC = vc;
     }];
}

- (UIViewController *)viewControllerForSegmentIndex:(NSInteger)index
{
    /*
     This function gets the UI out of storyboard and returns the accociated view controller.
     */
    UserSettingsViewController *userDetailsVC = nil;
    NotificationsViewController *notificationsVC = nil;
    OtherSettingsViewController *otherSettingsVC = nil;
    switch (index)
    {
        case 0:
            userDetailsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserSettingsViewController"];
            return userDetailsVC;
        case 1:
            notificationsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsViewController"];
            return notificationsVC;
        case 2:
            otherSettingsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OtherSettingsViewController"];
            return otherSettingsVC;
    }
    return nil;
}

@end
