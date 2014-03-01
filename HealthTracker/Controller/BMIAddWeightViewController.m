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
@property (nonatomic,strong) NSArray *arrayOfHeights;
@end

@implementation BMIAddWeightViewController

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
    self.arrayOfHeights = [NSArray arrayWithObjects:@(3.0),
                           @(3.1),
                           @(3.2),
                           @(3.3),
                           @(3.4),
                           @(3.5),
                           @(3.6),
                           @(3.7),
                           @(3.8),
                           @(3.9),
                           @(3.10),
                           @(3.11),
                           @(4.0),
                           @(4.1),
                           @(4.2),
                           @(4.3),
                           @(4.4),
                           @(4.5),
                           @(4.6),
                           @(4.7),
                           @(4.8),
                           @(4.9),
                           @(4.10),
                           @(4.11),
                           @(5.0),
                           @(5.1),
                           @(5.2),
                           @(5.3),
                           @(5.4),
                           @(5.5),
                           @(5.6),
                           @(5.7),
                           @(5.8),
                           @(5.9),
                           @(5.10),
                           @(5.11),
                           @(6.0),
                           @(6.1),
                           @(6.2),
                           @(6.3),
                           @(6.4),
                           @(6.5),
                           @(6.6),
                           @(6.7),
                           @(6.8),
                           @(6.9),
                           @(6.10),
                           @(6.11),
                           @(7.0),
                           @(7.1),
                           @(7.2),
                           @(7.3),
                           @(7.4),
                           @(7.5),
                           @(7.6),
                           @(7.7),
                           @(7.8),
                           @(7.9),
                           @(7.10),
                           @(7.11)
                           , nil];
    self.bmiWeightView.layer.cornerRadius = 16.0f;
    self.bmiWeightView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bmiWeightView.layer.borderWidth = 0.2f;
    self.bmiWeightInnerView.layer.cornerRadius = 16.0f;
    self.bmiWeightInnerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bmiWeightInnerView.layer.borderWidth = 0.2f;
    [self.pickerView selectRow:30 inComponent:0 animated:NO];
    [self.pickerView selectRow:250 inComponent:1 animated:NO];
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
        return [self.arrayOfHeights count];
    }
    if (1 == component)
    {
        return 500;
    }
    else return 0;
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if (0 == component)
    {
        NSNumber *number = [self.arrayOfHeights objectAtIndex:row];
        return [NSString stringWithFormat:@"%0.1f",number.doubleValue];
    }
    if (1 == component)
    {
        return [NSString stringWithFormat:@"%02d",row];
    }
    else return nil;
}

- (IBAction)confirmButtonPressed:(id)sender
{
    double weight = [self.pickerView selectedRowInComponent:0];
    NSNumber *height = [self.arrayOfHeights objectAtIndex:[self.pickerView selectedRowInComponent:0]];
    [[HealthTracker sharedHealthTracker] updateHeight:height.doubleValue];
    [[HealthTracker sharedHealthTracker] updateWeight:weight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
