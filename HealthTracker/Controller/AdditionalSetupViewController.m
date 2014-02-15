//
//  AdditionalSetupViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 02/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "AdditionalSetupViewController.h"

@interface AdditionalSetupViewController ()

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
    [self.picker selectRow:11 inComponent:0 animated:NO];
    [self.picker selectRow:29 inComponent:1 animated:NO];
    [self hidePicker];
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
    //Get
}

- (IBAction)notificationButtonPressed:(id)sender
{
    //Get the tag from the button pressed
    [self showPicker];
}

#pragma mark - PickerView Delegate

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if (0 == component)
    {
        return 24;
    }
    if (1 == component)
    {
        return 60;
    }
    else return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%02d",row+1];
}

- (IBAction)confirmPicker:(id)sender
{
    [self hidePicker];
}

- (IBAction)cancelPicker:(id)sender
{
    [self hidePicker];
}

- (void)showPicker
{
    CGRect newFrame =  self.pickerContainer.frame;
    //set y position to self.height - picker container height
    newFrame.origin.y = self.view.frame.size.height - self.pickerContainer.frame.size.height;
    self.pickerContainer.frame = newFrame;
    [UIView transitionWithView:self.pickerContainer
                      duration:0.6
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
}

- (void)hidePicker
{
    CGRect newFrame =  self.pickerContainer.frame;
    //set y position to self.height + picker container height
    newFrame.origin.y = self.view.frame.size.height + self.pickerContainer.frame.size.height;
    self.pickerContainer.frame = newFrame;
    [UIView transitionWithView:self.pickerContainer
                      duration:0.6
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
}

@end
