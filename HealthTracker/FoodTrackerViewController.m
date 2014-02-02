//
//  FoodTrackerViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 13/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "FoodTrackerViewController.h"
#import "FoodSelectionViewController.h"
#import "FoodDataStore.h"

@interface FoodTrackerViewController ()

@end

@implementation FoodTrackerViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)foodButtonPressed:(id)sender
{
    [self performSegueWithIdentifier:@"gotoFoodList" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"gotoFoodList"])//Make sure it is the correct screen
    {
        // Get reference to the destination view controller
        FoodSelectionViewController *vc = [segue destinationViewController];
        FoodDataStore *foodDataStore = [[FoodDataStore alloc]init];
        if (1 == [sender tag])
        {
            vc.titleLabelName = @"Sugar & Fats";
            vc.foods = [[NSMutableArray alloc]initWithArray:[foodDataStore retrieveSugarAndFats]];
        }
        if (2 == [sender tag])
        {
            vc.titleLabelName = @"Dairy & Meat";
            vc.foods = [[NSMutableArray alloc]initWithArray:[foodDataStore retrieveDairyAndMeat]];
        }
        if (3 == [sender tag])
        {
            vc.titleLabelName = @"Vegetabless";
            vc.foods = [[NSMutableArray alloc]initWithArray:[foodDataStore retrieveVegetables]];
        }
        if (4 == [sender tag])
        {
            vc.titleLabelName = @"Fruit";
            vc.foods = [[NSMutableArray alloc]initWithArray:[foodDataStore retrieveFruit]];
        }
        if (5 == [sender tag])
        {
            vc.titleLabelName = @"Starch";
            vc.foods = [[NSMutableArray alloc]initWithArray:[foodDataStore retrieveStarch]];
        }
    }
}

@end
