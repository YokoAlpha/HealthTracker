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
#import "HealthTracker.h"
#import "FoodHistoryViewController.h"


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
    [self updateOnScreenElements];//Update on first start to get data from persistent storage.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateOnScreenElements) name:healthTrackerDidUpdateNotification object:[HealthTracker sharedHealthTracker]];//Adds observer which will be used if the data updates to change the on screen labels.
}

- (void)updateOnScreenElements
{
    self.numberOfFoodsEatenTodayLabel.text = [NSString stringWithFormat:@"You had %d Food items today",[[HealthTracker sharedHealthTracker]numberOfFoodsEatenForDate:[NSDate date]]];
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
    UINavigationController *naviController = segue.destinationViewController;
    if ([[segue identifier] isEqualToString:@"gotoFoodList"])//Make sure it is the correct screen
    {
        //Work around for destination being inside navigation controller.
        for (id targetVC in naviController.viewControllers)
        {
            if (YES == [targetVC isKindOfClass:[FoodSelectionViewController class]])
            {
                // Get reference to the destination view controller
                FoodSelectionViewController *vc = (FoodSelectionViewController *)targetVC;
                FoodDataStore *foodDataStore = [[FoodDataStore alloc]init];
                if (1 == [sender tag])
                {
                    vc.title = @"Sugar & Fats";
                    vc.foods = [[NSMutableArray alloc]initWithArray:[foodDataStore retrieveSugarAndFats]];
                }
                if (2 == [sender tag])
                {
                    vc.title = @"Dairy & Meat";
                    vc.foods = [[NSMutableArray alloc]initWithArray:[foodDataStore retrieveDairyAndMeat]];
                }
                if (3 == [sender tag])
                {
                    vc.title = @"Vegetabless";
                    vc.foods = [[NSMutableArray alloc]initWithArray:[foodDataStore retrieveVegetables]];
                }
                if (4 == [sender tag])
                {
                    vc.title = @"Fruit";
                    vc.foods = [[NSMutableArray alloc]initWithArray:[foodDataStore retrieveFruit]];
                }
                if (5 == [sender tag])
                {
                    vc.title = @"Starch";
                    vc.foods = [[NSMutableArray alloc]initWithArray:[foodDataStore retrieveStarch]];
                }
            }
        }
    }
    else if ([[segue identifier] isEqualToString:@"modalFoodHistory"])//Make sure it is the correct screen
    {
        // Get reference to the destination view controller
        for (id targetVC in naviController.viewControllers)
        {
            if (YES == [targetVC isKindOfClass:[FoodHistoryViewController class]])
            {
                // Get reference to the destination view controller
                FoodHistoryViewController *vc = (FoodHistoryViewController *)targetVC;
                vc.title = @"Food History";
                vc.arrayOfPreviousFoods = [[NSArray alloc]initWithArray:[[HealthTracker sharedHealthTracker]allFoodsEaten]];
            }
        }
    }
}

@end
