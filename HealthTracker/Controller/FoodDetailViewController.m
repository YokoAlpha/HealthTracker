//
//  FoodDetailViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 26/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "FoodDetailViewController.h"
#import "HealthTracker.h"

@interface FoodDetailViewController ()
@property (nonatomic,strong) NSMutableArray *pickerData;
@end

@implementation FoodDetailViewController

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
    //Setup picker view
    self.pickerData = [[NSMutableArray alloc]init];
    for (NSInteger i = 1; i <201; i++)
    {
        [self.pickerData addObject:[NSNumber numberWithInt:(int)i*10]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addButtonPressed:(id)sender
{
    //Action when user selects quantity.
    //Save to shared user profile.
    NSInteger quantityConsumed = [[self.pickerData objectAtIndex:[self.pickerView selectedRowInComponent:0]]integerValue];
    [[HealthTracker sharedHealthTracker]addConsumedFood:self.foodData withQuantity:quantityConsumed];
    [self dismissViewControllerAnimated:YES completion:nil];
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
    return [self.pickerData count];
}

//Tells how many columns to show.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//Title for each element in picker.
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    NSString *title;
    NSNumber *numberForRow = [self.pickerData objectAtIndex:row];
    if ([self.foodData.measurement isEqualToString:@"grams"])
    {
        title = [NSString stringWithFormat:@"%dg",[numberForRow intValue]];
    }
    else if ([self.foodData.measurement isEqualToString:@"mL"])
    {
        title = [NSString stringWithFormat:@"%dml",[numberForRow intValue]];
    }
    else
    {
        //Food measurement not included in data type
        title = [NSString stringWithFormat:@"%d",[numberForRow intValue]];
    }
    return title;
}

@end
