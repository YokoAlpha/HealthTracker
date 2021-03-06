//
//  SummaryViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 13/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "SummaryViewController.h"
#import "HealthTracker.h"
#import "GraphViewController.h"

@interface SummaryViewController ()

@end

@implementation SummaryViewController

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
    self.topbarView.layer.cornerRadius = 16.0f;//Add rounded corners to views
    self.bottombarView.layer.cornerRadius = 16.0f;//Add rounded corners to views
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateOnScreenElements) name:healthTrackerDidUpdateNotification object:[HealthTracker sharedHealthTracker]];//Adds observer which will be used if the data updates to change the on screen labels.
    [self updateOnScreenElements];
    self.animationView = [[AnimationView alloc]init]; //Setup animations
}

- (void)viewWillAppear:(BOOL)animated
{
    [self updateOnScreenElements];
}

- (void)updateOnScreenElements
{
    //Five a day tracking.
    float numberOfFiveADay = [[HealthTracker sharedHealthTracker]numberOfFiveADayEatenForDate:[NSDate date]];
    float percentageEaten = (numberOfFiveADay/5)*100;
    self.fiveADayPercentageLabel.text = [NSString stringWithFormat:@"%0.f",percentageEaten];
    float progressBarPlot = percentageEaten/100;
    if (progressBarPlot > 1.0f)
    {
        //Cannot be over 100%
        progressBarPlot = 1.0f;
    }
    [self.fiveADayBar setProgress:progressBarPlot];
    if (percentageEaten > 0 && percentageEaten <50)
    {
        [self fiveADayState:3];//Bad
    }
    else if (percentageEaten > 49 && percentageEaten <70)
    {
        [self fiveADayState:2];//Ok
    }
    else if (percentageEaten > 69 && percentageEaten <=100)
    {
        [self fiveADayState:1];//Good
    }
    //BMI tracking
    //https://www.nhlbi.nih.gov/guidelines/obesity/BMI/bmi-m.htm
    double bmiResult = [HealthTracker sharedHealthTracker].bmiCount;
    if (isnan(bmiResult))//Result is not a natural number
    {
        bmiResult = 0;
    }
    if(bmiResult < 18.5)//UnderWeight
    {
        [self bmiState:3];//Bad
    }
    else if(bmiResult > 18.4 && bmiResult < 25.0)//Normal Weight
    {
        [self bmiState:1];//Good
    }
    else if(bmiResult > 24.9 && bmiResult < 30.0)//Overweight
    {
        [self bmiState:2];//Still bad
    }
    else if(bmiResult > 30.0)//Obesity
    {
        [self bmiState:3];//Bad
    }
    self.bmiResultLabel.text = [NSString stringWithFormat:@"%0.1f",bmiResult];
    //Fitness (Ideally someone would run 5 miles aday (good))
    double fitnessResult = [[HealthTracker sharedHealthTracker] distanceRanForDate:[NSDate date]];
    double percentageRan = (fitnessResult/5.0)*100;
    float progressBarPlotFitness = percentageRan/100;
    if (progressBarPlotFitness > 1.0f)
    {
        //Cannot be over 100%
        progressBarPlotFitness = 1.0f;
    }
    if (percentageRan < 50)
    {
        [self fitnessState:3];//Bad
    }
    else if (percentageRan > 49 && percentageRan <70)
    {
        [self fitnessState:2];//Ok
    }
    else if (percentageRan > 69 && percentageRan <=100)
    {
        [self fitnessState:1];//Good
    }
    [self.fiveADayBar setProgress:progressBarPlot];
    self.fitnessResultLabel.text = [NSString stringWithFormat:@"%0.1f",fitnessResult];

}

/*
    Method to show how well the user is doing
 */
- (void)fiveADayState:(NSInteger)currentState
{
    if (1 == currentState)
    {
        //User is doing well
        [self.topbarView setBackgroundColor:[UIColor colorWithRed:216/255.0f green:247/255.0f blue:160/255.0f alpha:1.0f]];
    }
    else if (2 == currentState)
    {
        //User is doing ok
        self.topbarView.backgroundColor = [UIColor colorWithRed:239/255.0f green:143/255.0f blue:60/255.0f alpha:1.0f];
    }
    else if (3 == currentState)
    {
        //User is doing bad
        self.topbarView.backgroundColor = [UIColor colorWithRed:237/255.0f green:70/255.0f blue:47/255.0f alpha:1.0f];
    }
}

- (void)fitnessState:(NSInteger)currentState
{
    if (1 == currentState)
    {
        //User is doing well
        [self.bottombarView setBackgroundColor:[UIColor colorWithRed:216/255.0f green:247/255.0f blue:160/255.0f alpha:1.0f]];
    }
    else if (2 == currentState)
    {
        //User is doing ok
        [self.bottombarView setBackgroundColor:[UIColor colorWithRed:239/255.0f green:143/255.0f blue:60/255.0f alpha:1.0f]];
    }
    else if (3 == currentState)
    {
        //User is doing bad
        [self.bottombarView setBackgroundColor:[UIColor colorWithRed:237/255.0f green:70/255.0f blue:47/255.0f alpha:1.0f]];
    }
}

- (void)bmiState:(NSInteger)currentState
{
    if (1 == currentState)
    {
        //User is doing well
        [self.circleView updateColor:[UIColor colorWithRed:216/255.0f green:247/255.0f blue:160/255.0f alpha:1.0f]];
    }
    else if (2 == currentState)
    {
        //User is doing ok
        [self.circleView updateColor:[UIColor colorWithRed:239/255.0f green:143/255.0f blue:60/255.0f alpha:1.0f]];
    }
    else if (3 == currentState)
    {
        //User is doing bad
        [self.circleView updateColor:[UIColor colorWithRed:237/255.0f green:70/255.0f blue:47/255.0f alpha:1.0f]];
    }
}

- (IBAction)shareButtonPressed:(id)sender
{
    //Get screenshot
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(window.bounds.size);
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    //Description
    double bmiScore = [HealthTracker sharedHealthTracker].bmiCount;
    NSInteger numberOfFruitAndVeg = [[HealthTracker sharedHealthTracker] numberOfFiveADayEatenForDate:[NSDate date]];
    NSString *shareDescription = [NSString stringWithFormat:@"My health stats BMI= %0.1f, I have had %ld fruit and veg eaten today, fitness score = 0",bmiScore,(long)numberOfFruitAndVeg];
    if (nil != shareDescription && nil != screenshot)
    {
        NSArray *objectsToShare = @[shareDescription,screenshot];
        UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
        NSArray *excludedActivities = @[UIActivityTypePostToWeibo, UIActivityTypePostToTencentWeibo,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo];//Exclude these types of sharing
        controller.excludedActivityTypes = excludedActivities;
        // Present the controller
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    UINavigationController *naviController = segue.destinationViewController;
    //Work around for destination being inside navigation controller.
    for (id targetVC in naviController.viewControllers)
    {
        if (YES == [targetVC isKindOfClass:[GraphViewController class]])
        {
            GraphViewController *vc = (GraphViewController *)targetVC;
            if ([[segue identifier] isEqualToString:@"foodGraph"])//Make sure data is sent to destination controller correctly
            {
                vc.title = @"Food Graph";
                vc.dataResults = [[[HealthTracker sharedHealthTracker] allFoodsEaten]copy];
                vc.dataType =  @"Food";
            }
            if ([[segue identifier] isEqualToString:@"fitnessGraph"])//Make sure data is sent to destination controller correctly
            {
                vc.title = @"Runs Graph";
                vc.dataResults = [[[HealthTracker sharedHealthTracker] allRunsCompleted]copy];
                vc.dataType =  @"Run";
            }
            if ([[segue identifier] isEqualToString:@"bmiGraph"])//Make sure data is sent to destination controller correctly
            {
                vc.title = @"BMI Graph";
                vc.dataResults = [[[HealthTracker sharedHealthTracker] allBMIResults]copy];
                vc.dataType =  @"BMI";
            }
        }
    }
}

@end
