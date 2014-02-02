//
//  FoodSelectionViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 25/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "FoodSelectionViewController.h"
#import "FoodDetailViewController.h"
#import "FoodDataStore.h"
#import "Food.h"

@interface FoodSelectionViewController ()
@property (nonatomic,strong) Food *foodForDestinationVC;
@end

@implementation FoodSelectionViewController

#pragma mark - ViewController lifecycle


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
    return [self.foods count];
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    //Get section array
    id sectObj = [self.foods objectAtIndex:section];
    if ([sectObj isKindOfClass:[NSArray class]])
    {
        NSArray *sectArray = (NSArray *)sectObj;
        return [[FoodDataStore foodTypesInArray:sectArray]firstObject];
    }
    else
    {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    //Get section array
    id sectObj = [self.foods objectAtIndex:section];
    if ([sectObj isKindOfClass:[NSArray class]])
    {
        NSArray *sectArray = (NSArray *)sectObj;
        return [sectArray count];
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"foodCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
            reuseIdentifier:MyIdentifier];
    }
    //Get section array
    id sectObj = [self.foods objectAtIndex:indexPath.section];
    if ([sectObj isKindOfClass:[NSArray class]])
    {
        NSArray *sectArray = (NSArray *)sectObj;
        id food = [sectArray objectAtIndex:indexPath.row];
        if ([food isKindOfClass:[Food class]])
        {
            Food *foodObj = (Food *)food;
            cell.textLabel.text = foodObj.foodName;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Get section array
    id sectObj = [self.foods objectAtIndex:indexPath.section];
    if ([sectObj isKindOfClass:[NSArray class]])
    {
        NSArray *sectArray = (NSArray *)sectObj;
        id food = [sectArray objectAtIndex:indexPath.row];
        if ([food isKindOfClass:[Food class]])
        {
            self.foodForDestinationVC = (Food *)food;
            [self performSegueWithIdentifier:@"goToFoodDetail" sender:nil];
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"goToFoodDetail"])//Make sure it is the correct screen
    {
        // Get reference to the destination view controller
        FoodDetailViewController *vc = [segue destinationViewController];
        vc.title = self.foodForDestinationVC.foodName;
        vc.foodData = self.foodForDestinationVC;
    }
}


@end
