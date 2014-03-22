//
//  RunHistoryViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 22/03/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "RunHistoryViewController.h"
#import "RunDescription.h"
#import "Run.h"
#import "HealthTracker.h"

@interface RunHistoryViewController ()

@end

@implementation RunHistoryViewController

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
    self.arrayOfPreviousRuns = [[HealthTracker sharedHealthTracker] allRunsCompleted];
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
    return [self.arrayOfPreviousRuns count];
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
    id rowObj = [self.arrayOfPreviousRuns objectAtIndex:indexPath.row];
    if ([rowObj isKindOfClass:[Run class]])
    {
        Run *run = (Run *)rowObj;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEE', 'dd' 'MMM' 'yyyy'"];
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:@"hh:mm"];
        NSString *dateStarted = [dateFormatter stringFromDate:run.runStartTime];
        NSTimeInterval timeInterval = [run.runEndTime timeIntervalSinceDate: run.runStartTime];
        //Convert the time correctly to present
        NSInteger minutes = floor(timeInterval/60);
        NSInteger seconds = round(timeInterval - minutes * 60);
        NSString *titleForCell = [NSString stringWithFormat:@"%@ Ran for %d:%02d", dateStarted, minutes, seconds];
        cell.textLabel.text = titleForCell;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%0.2f Meters",[run.distanceRan doubleValue]];
    }
    return cell;
}


@end
