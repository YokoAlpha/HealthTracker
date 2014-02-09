//
//  FoodHistoryViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 09/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "FoodHistoryViewController.h"
#import "ConsumedFood.h"

@interface FoodHistoryViewController ()

@end

@implementation FoodHistoryViewController

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
    return [self.arrayOfPreviousFoods count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"foodHistoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    id rowObj = [self.arrayOfPreviousFoods objectAtIndex:indexPath.row];
    if ([rowObj isKindOfClass:[ConsumedFood class]])
    {
        ConsumedFood *food = (ConsumedFood *)rowObj;
        cell.textLabel.text = food.foodName;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEE', 'dd' 'MMM' 'yyyy'"];
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:@"hh:mm"];
        NSString *dateConsumedString = [dateFormatter stringFromDate:food.dateConsumed];
        NSString *timeConsumedString = [timeFormatter stringFromDate:food.dateConsumed];
        NSString *units = nil;
        if ([food.measurement isEqualToString:@"grams"])
        {
            units = @"g";
        }
        else if ([food.measurement isEqualToString:@"mL"])
        {
            units = @"ml";
        }
        NSString *amountString = [NSString stringWithFormat:@"%d%@",[food.quantityConsumed integerValue],units];
       
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ @ %@ %@",amountString,timeConsumedString,dateConsumedString];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


@end
