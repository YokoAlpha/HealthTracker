//
//  UserSettingsViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 16/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "UserSettingsViewController.h"
#import "HealthTracker.h"
#import "UserDescription.h"

@interface UserSettingsViewController ()
@property (nonatomic,strong) NSMutableArray *genders;
@property (nonatomic,strong) NSMutableArray *months;
@property (nonatomic,strong) NSMutableArray *years;
@property (nonatomic,strong) UserDescription *userData;
@end

@implementation UserSettingsViewController

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
    self.userData = [[HealthTracker sharedHealthTracker]retrieveUserData];//Get current user data
    self.genders = [[NSMutableArray alloc]initWithObjects:@"Male",@"Female", nil];
    self.months = [[NSMutableArray alloc]init];
    //Get array of months in current calendar format (Forward thinking for if app is localised).
    self.years = [[NSMutableArray alloc]init];
    NSDate           *today           = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSCalendar       *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *yearComponents  = [currentCalendar components:NSYearCalendarUnit  fromDate:today];
    //    int currentYear  = [yearComponents year];
    for(int months = 0; months < 12; months++)
    {
        [self.months addObject:[NSString stringWithFormat:@"%@",[[dateFormatter monthSymbols]objectAtIndex: months]]];
    }
    for (NSInteger i = 1900; i < [yearComponents year]+1; i++)
    {
        [self.years addObject:@(i)];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [self updateOnScreenUserData];
}

- (void)updateOnScreenUserData
{
    //Gender
    if ([self.userData.gender isEqualToString:@"Male"])
    {
        [self.pickerView selectRow:0 inComponent:0 animated:NO];
    }
    if ([self.userData.gender isEqualToString:@"Female"])
    {
        [self.pickerView selectRow:1 inComponent:0 animated:NO];
    }
    //GetYearDetails
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:(NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSWeekCalendarUnit) fromDate:self.userData.dateOfBirth];
    //set date components
    NSInteger year = [dateComponents year];
    NSInteger month = [dateComponents month];
    [self.pickerView selectRow:month-1 inComponent:1 animated:NO];
    [self.pickerView selectRow:year-1900 inComponent:2 animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateDetails:(id)sender
{
    self.userData.gender = [self.genders objectAtIndex:[self.pickerView selectedRowInComponent:0]];
    //Work out date of birth
    //gather current calendar
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //gather date components from date
    NSDateComponents *dateComponents = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[NSDate date]];
    //set date components
    [dateComponents setDay:1];//Day not currently stored.
    [dateComponents setMonth:[self.pickerView selectedRowInComponent:1]+1];
    NSInteger year = [[self.years objectAtIndex:[self.pickerView selectedRowInComponent:2]]integerValue];
    [dateComponents setYear:year];
    //save date relative from date
    self.userData.dateOfBirth = [calendar dateFromComponents:dateComponents];
    [[HealthTracker sharedHealthTracker]updateUser:self.userData];
}

#pragma mark - PickerView Delegate


- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
}

//Tells how many rows to show
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if (0 == component)
    {
        return [self.genders count];
    }
    if (1 == component)
    {
        return [self.months count];
    }
    if (2 == component)
    {
        return [self.years count];
    }
    else
    {
        return 0;
    }
}

//Tells how many columns to show.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

//Title for each element in picker.
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    NSString *title = nil;
    if (0 == component)
    {
        title = [self.genders objectAtIndex:row];
    }
    if (1 == component)
    {
        title = [self.months objectAtIndex:row];
    }
    if (2 == component)
    {
        NSNumber *year = [self.years objectAtIndex:row];
        title = [NSString stringWithFormat:@"%d",[year integerValue]];
    }
    return title;
}

//Override width for long month names.
-(CGFloat)pickerView:(UIPickerView *)pickerView
   widthForComponent:(NSInteger)component

{
    if (component == 0)
    {
        return (self.view.frame.size.width * 27 ) / 100;
    }
    if (component == 1)
    {
        return (self.view.frame.size.width * 40 ) / 100;
    }
    if (component == 2)
    {
        return (self.view.frame.size.width * 20 ) / 100;
    }
    else
    {
        return 0;
    }
}

@end
