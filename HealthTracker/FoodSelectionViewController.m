//
//  FoodSelectionViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 25/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "FoodSelectionViewController.h"
#import "FoodDetailViewController.h"
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
    [self.titleLabel setText:self.titleLabelName];
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
    return 1;    //TODO: need to specify number sections.
}



- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    
    return [self.foods count];//looks at the number of foods and adds the rows's.
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
    id food = [self.foods objectAtIndex:indexPath.row];
    if ([food isKindOfClass:[Food class]])
    {
        Food *foodObj = (Food *)food;
        cell.textLabel.text = foodObj.foodName;
        cell.detailTextLabel.text = foodObj.foodCategory;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id food = [self.foods objectAtIndex:indexPath.row];
    if ([food isKindOfClass:[Food class]])
    {
        self.foodForDestinationVC = (Food *)food;
        [self performSegueWithIdentifier:@"goToFoodDetail" sender:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"goToFoodDetail"])//Make sure it is the correct screen
    {
        // Get reference to the destination view controller
        FoodDetailViewController *vc = [segue destinationViewController];
        vc.foodData = self.foodForDestinationVC;
    }
}


@end
