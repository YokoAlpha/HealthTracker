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

- (IBAction)updateNotifications:(id)sender//When user presses save
{
    //Check relevant feedback
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
    //Get the changed user details and assign them to local object
    self.userDetailsToTransfer.releventFeedback = releventFeedback;
    self.userDetailsToTransfer.dayForBMICheck = self.weekdaySwitch.selectedSegmentIndex;
    self.userDetailsToTransfer.breakfastReminder = self.breakfastTimeToSet;
    self.userDetailsToTransfer.lunchReminder = self.lunchTimeToSet;
    self.userDetailsToTransfer.dinnerReminder = self.dinnerTimeToSet;
    [[HealthTracker sharedHealthTracker]updateUser:self.userDetailsToTransfer];//save to user details which will write to database
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)updateOnscreenElements
{
    self.userDetailsToTransfer = [[HealthTracker sharedHealthTracker]retrieveUserData];//Get current user data
    if (YES == self.userDetailsToTransfer.releventFeedback)
    {
        [self.feedBackSwitch setSelectedSegmentIndex:0];
    }
    else
    {
        [self.feedBackSwitch setSelectedSegmentIndex:1];
    }
    //Setup initial valies
    [self.weekdaySwitch setSelectedSegmentIndex:self.userDetailsToTransfer.dayForBMICheck];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm"];
    self.breakfastTimeToSet = self.userDetailsToTransfer.breakfastReminder;
    self.lunchTimeToSet = self.userDetailsToTransfer.lunchReminder;
    self.dinnerTimeToSet = self.userDetailsToTransfer.dinnerReminder;
    [self.breakfastTimeLabel setText:[timeFormatter stringFromDate:self.userDetailsToTransfer.breakfastReminder]];
    [self.lunchTimeLabel setText:[timeFormatter stringFromDate:self.userDetailsToTransfer.lunchReminder]];
    [self.dinnerTimeLabel setText:[timeFormatter stringFromDate:self.userDetailsToTransfer.dinnerReminder]];
}

- (void)viewDidAppear:(BOOL)animated
{
    //Update onscreen UIWhen loaded and change some labels to fit
    [self updateOnscreenElements];
    [self.breakfastTimeLabel sizeToFit];
    [self.lunchTimeLabel sizeToFit];
    [self.dinnerTimeLabel sizeToFit];
}

- (IBAction)notificationButtonPressed:(id)sender
{
    //When this is called the picker will move onto the screen
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
    return [NSString stringWithFormat:@"%02ld",(long)row];
}

- (IBAction)confirmPicker:(id)sender
{
    /* Build NSDate for reminder */
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:[NSDate date]];
    [comps setHour:[self.picker selectedRowInComponent:0]];
    [comps setMinute:[self.picker selectedRowInComponent:1]];
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [cal dateFromComponents:comps];
    /* Build string from current picker selected row position */
    NSString *time = [NSString stringWithFormat:@"%02ld:%02ld",(long)[self.picker selectedRowInComponent:0],(long)[self.picker selectedRowInComponent:1]];
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
    //Moves the picker onto screen by using a transition and altering its cordinates
    CGRect newFrame =  self.pickerContainer.frame;
    //set y position to self.height - picker container height
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (screenSize.height > 480.0f)
    {
        /*Do iPhone 5 stuff here.*/
        newFrame.origin.y = self.view.frame.size.height - self.pickerContainer.frame.size.height;
    }
    else
    {
        /*Do iPhone Classic stuff here.*/
        newFrame.origin.y = 160;
    }
    self.pickerContainer.frame = newFrame;
    [UIView transitionWithView:self.pickerContainer
                      duration:0.6
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
}

- (void)hidePicker
{
    //Moves the picker off screen by using a transition and altering its cordinates 
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
