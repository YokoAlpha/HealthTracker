//
//  BMIAddWeightViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 15/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "BMIAddWeightViewController.h"
#import "HealthTracker.h"

@interface BMIAddWeightViewController ()
@end

@implementation BMIAddWeightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.bmiWeightView.layer.cornerRadius = 16.0f;
    self.bmiWeightView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bmiWeightView.layer.borderWidth = 0.2f;
    self.bmiWeightInnerView.layer.cornerRadius = 16.0f;
    self.bmiWeightInnerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bmiWeightInnerView.layer.borderWidth = 0.2f;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateOnScreenElements) name:healthTrackerDidUpdateNotification object:[HealthTracker sharedHealthTracker]];//Adds observer which will be used if the data updates to change the on screen labels.
    [self updateOnScreenElements];
    [self.pickerView selectRow:30 inComponent:0 animated:NO];
    [self.pickerView selectRow:250 inComponent:1 animated:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self updateOnScreenElements];
}

- (void)updateOnScreenElements
{
    if ([[HealthTracker sharedHealthTracker]isMetricSystem])
    {
        self.heightLabel.text = @"Height (cm)";
        self.weightLabel.text = @"Weight (KG)";
    }
    else
    {
        self.heightLabel.text = @"Height (inch)";
        self.weightLabel.text = @"Weight (lbs)";
    }
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
    if (0 == component)//Height
    {
        if ([[HealthTracker sharedHealthTracker]isMetricSystem])
        {
            return 250;//250cm (8 feet is the max height covered)
        }
        else
        {
            return 314;//314 inches (8 feet is the max height covered)
        }
    }
    if (1 == component)//Weight
    {
        if ([[HealthTracker sharedHealthTracker]isMetricSystem])
        {
            return 500;//Half a ton (500KG)is the most tracked as weight that is seriously heavy
        }
        else
        {
            return 1100;//Half a ton (1100lbs)is the most tracked as weight that is seriously heavy
        }
    }
    else return 0;
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if (0 == component)
    {
        return [NSString stringWithFormat:@"%02ld",(long)row];
    }
    if (1 == component)
    {
        return [NSString stringWithFormat:@"%02ld",(long)row];
    }
    else return nil;
}

- (IBAction)confirmButtonPressed:(id)sender
{
    double weight = [self.pickerView selectedRowInComponent:1];
    double height = [self.pickerView selectedRowInComponent:0];
    [[HealthTracker sharedHealthTracker] updateHeight:height];
    [[HealthTracker sharedHealthTracker] updateWeight:weight];
    BMIDescription *bmiResults = [[BMIDescription alloc]init];
    bmiResults.weight = [NSNumber numberWithDouble:weight];
    bmiResults.height = [NSNumber numberWithDouble:height];
    bmiResults.date = [NSDate date];
    bmiResults.bmiResult = [NSNumber numberWithDouble:[[HealthTracker sharedHealthTracker] bmiCount]];
    [[HealthTracker sharedHealthTracker] addBMIResult:bmiResults];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
