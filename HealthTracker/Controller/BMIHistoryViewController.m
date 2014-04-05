//
//  BMIHistoryViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 05/04/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "BMIHistoryViewController.h"
#import "RunDescription.h"
#import "BMI.h"
#import "HealthTracker.h"

@interface BMIHistoryViewController ()

@end

@implementation BMIHistoryViewController

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
    self.arrayOfPreviousBMIResults = [[HealthTracker sharedHealthTracker] allBMIResults];
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

#pragma mark - TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayOfPreviousBMIResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"bmiCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    id rowObj = [self.arrayOfPreviousBMIResults objectAtIndex:indexPath.row];
    if ([rowObj isKindOfClass:[BMI class]])
    {
        BMI *bmi = (BMI *)rowObj;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEE', 'dd' 'MMM' 'yyyy'"];
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:@"hh:mm"];
        NSString *dateConsumedString = [dateFormatter stringFromDate:bmi.date];
        NSString *timeConsumedString = [timeFormatter stringFromDate:bmi.date];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", timeConsumedString, dateConsumedString];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Weight: %0.1f BMI: %0.1f", [bmi.weight doubleValue], [bmi.bmiResult doubleValue]];
    }
    return cell;
}
@end
