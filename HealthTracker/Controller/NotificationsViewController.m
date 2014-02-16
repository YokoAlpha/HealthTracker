//
//  NotificationsViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 16/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "NotificationsViewController.h"

@interface NotificationsViewController ()
@property (nonatomic,strong) NSDate *breakfastTimeToSet;
@property (nonatomic,strong) NSDate *lunchTimeToSet;
@property (nonatomic,strong) NSDate *dinnerTimeToSet;
@property (nonatomic) NSInteger selectedPicker;
@end

@implementation NotificationsViewController

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
    [self hidePicker];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateNotifications:(id)sender
{
    BOOL releventFeedback = NO;
    if (0 == self.feedBackSwitch.selectedSegmentIndex)
    {
        //YES
        releventFeedback = YES;
    }
    else if (1 == self.feedBackSwitch.selectedSegmentIndex)
    {
        //NO
        releventFeedback = NO;
    }
    self.userDetailsToTransfer.releventFeedback = releventFeedback;
    self.userDetailsToTransfer.dayForBMICheck = self.weekdaySwitch.selectedSegmentIndex;
    self.userDetailsToTransfer.breakfastReminder = self.breakfastTimeToSet;
    self.userDetailsToTransfer.lunchReminder = self.lunchTimeToSet;
    self.userDetailsToTransfer.dinnerReminder = self.dinnerTimeToSet;
    [[HealthTracker sharedHealthTracker]updateUser:self.userDetailsToTransfer];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)updateOnscreenElements
{
    self.userDetailsToTransfer = [[HealthTracker sharedHealthTracker]retrieveUserData];//Get current data
    if (YES == self.userDetailsToTransfer.releventFeedback)
    {
        [self.feedBackSwitch setSelectedSegmentIndex:0];
    }
    else
    {
        [self.feedBackSwitch setSelectedSegmentIndex:1];
    }
    [self.weekdaySwitch setSelectedSegmentIndex:self.userDetailsToTransfer.dayForBMICheck];
    //Date labels
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm"];
    [self.breakfastTimeLabel setText:[timeFormatter stringFromDate:self.userDetailsToTransfer.breakfastReminder]];
    [self.lunchTimeLabel setText:[timeFormatter stringFromDate:self.userDetailsToTransfer.lunchReminder]];
    [self.dinnerTimeLabel setText:[timeFormatter stringFromDate:self.userDetailsToTransfer.dinnerReminder]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self updateOnscreenElements];
    [self.breakfastTimeLabel sizeToFit];
    [self.lunchTimeLabel sizeToFit];
    [self.dinnerTimeLabel sizeToFit];
}

- (IBAction)notificationButtonPressed:(id)sender
{
    UIButton *notificationButton = (UIButton *)sender;
    //Get the tag from the button pressed
    self.selectedPicker = notificationButton.tag;
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
    return [NSString stringWithFormat:@"%02d",row];
}

- (IBAction)confirmPicker:(id)sender
{
    /* Build NSDate for reminder */
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setHour:[self.picker selectedRowInComponent:0]];
    [comps setMinute:[self.picker selectedRowInComponent:1]];
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [cal dateFromComponents:comps];
    /* Build string from current picker selected row position */
    NSString *time = [NSString stringWithFormat:@"%02d : %02d",[self.picker selectedRowInComponent:0],[self.picker selectedRowInComponent:1]];
    /* Update labels */
    if (1 == self.selectedPicker)
    {
        self.breakfastTimeToSet = date;
        self.breakfastTimeLabel.text = time;
        [self.breakfastTimeLabel sizeToFit];
    }
    else if (2 == self.selectedPicker)
    {
        self.lunchTimeToSet = date;
        self.lunchTimeLabel.text = time;
        [self.lunchTimeLabel sizeToFit];
    }
    else if (3 == self.selectedPicker)
    {
        self.dinnerTimeToSet = date;
        self.dinnerTimeLabel.text = time;
        [self.dinnerTimeLabel sizeToFit];
    }
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
    self.selectedPicker = 0;
}


@end
