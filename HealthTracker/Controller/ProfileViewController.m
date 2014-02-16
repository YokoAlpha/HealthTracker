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
    [self.settingsScreenSelector setSelectedSegmentIndex:0];
    [self addChildViewController:vc];
    vc.view.frame = self.containerView.bounds;
    [self.containerView addSubview:vc.view];
    self.embeddedVC = vc;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentChanged:(UISegmentedControl *)sender
{
    UIViewController *vc = [self viewControllerForSegmentIndex:sender.selectedSegmentIndex];
    [self addChildViewController:vc];
    [self transitionFromViewController:self.embeddedVC toViewController:vc duration:0 options:UIViewAnimationOptionTransitionNone
                            animations:^{
                                [self.embeddedVC.view removeFromSuperview];
                                vc.view.frame = self.containerView.bounds;
                                [self.containerView addSubview:vc.view];
                            }
                            completion:^(BOOL finished)
     {
         [vc didMoveToParentViewController:self];
         [self.embeddedVC removeFromParentViewController];
         self.embeddedVC = vc;
     }];
}

- (UIViewController *)viewControllerForSegmentIndex:(NSInteger)index
{
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
