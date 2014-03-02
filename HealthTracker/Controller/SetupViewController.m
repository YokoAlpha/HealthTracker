//
//  SetupViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 02/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "SetupViewController.h"
#import "HealthTracker.h"
#import "AdditionalSetupViewController.h"

@interface SetupViewController ()
@property (nonatomic,strong)NSMutableArray *genders;
@property (nonatomic,strong)NSMutableArray *months;
@property (nonatomic,strong)NSMutableArray *years;
@end

@implementation SetupViewController

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
    self.title = @"Setup";
	// Do any additional setup after loading the view.
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
    [self.pickerView selectRow:90 inComponent:2 animated:NO];//Select a more appropriate default year.
    [self.pickerView selectRow:5 inComponent:1 animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextButtonPressed:(id)sender
{
    [self performSegueWithIdentifier:@"pushToAdditionalSetupInfo" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pushToAdditionalSetupInfo"])
    {
        
        // Get reference to the destination view controller
        AdditionalSetupViewController *vc = [segue destinationViewController];
        UserDescription *userDetails = [[UserDescription alloc]init];
        userDetails.gender = [self.genders objectAtIndex:[self.pickerView selectedRowInComponent:0]];
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
        userDetails.dateOfBirth = [calendar dateFromComponents:dateComponents];
        vc.userDetailsToTransfer = userDetails;
    }
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
        title = [NSString stringWithFormat:@"%ld",(long)[year integerValue]];
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
