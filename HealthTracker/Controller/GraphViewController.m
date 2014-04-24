//
//  GraphViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 05/04/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "GraphViewController.h"
#import "HealthTracker.h"
#import "Run.h"
#import "BMI.h"
#import "Food.h"

@interface GraphViewController ()

@end

@implementation GraphViewController

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
    [self setupGraph];
}

- (void)setupGraph
{
    /*
     
     This function sets up the graph view with the style of the data its representing for good code reuse so we dont have 4 different graph view classes
     
     */
    self.graphView = [[GraphView alloc]init];
    NSMutableArray *arrayOfValues = [[NSMutableArray alloc]init];
    NSMutableArray *arrayOfDescriptions = [[NSMutableArray alloc]init];
    double bmiResult = 0;
    //Change color depending on bmi etc
    if([self.dataType isEqualToString:@"Run"])
    {
        for(Run *runObj in self.dataResults)
        {
            double percentageRan = ([runObj.distanceRan doubleValue]/5.0)*100;
            if (percentageRan > 100.0)
            {
                percentageRan = 100.0;
            }
            [arrayOfValues addObject:[NSNumber numberWithDouble:percentageRan]];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd/MM/yyyy @ HH:mm"];
            NSString *dateStarted = [dateFormatter stringFromDate:runObj.runStartTime];
            NSTimeInterval timeInterval = [runObj.runEndTime timeIntervalSinceDate: runObj.runStartTime];
            //Convert the time correctly to present
            NSInteger minutes = floor(timeInterval/60);
            NSInteger seconds = round(timeInterval - minutes * 60);
            [arrayOfDescriptions addObject:[NSString stringWithFormat:@"%0.0f%% %0.1fKM  in %d:%02d on %@",percentageRan,[runObj.distanceRan doubleValue],minutes, seconds,dateStarted]];
        }
    }
    if([self.dataType isEqualToString:@"Food"])
    {
        //Create array of all the dates foods have been consumed
        NSMutableArray *arrayOfUniqueDatesThatFoodHasBeenConsumedOn = [[NSMutableArray alloc]init];
        for(Food *food in self.dataResults)
        {
            //Make sure no dates are duplicated
            BOOL doesDateExistAlready = YES;
            for (NSDate *date in arrayOfUniqueDatesThatFoodHasBeenConsumedOn)
            {
                if(YES == [[HealthTracker sharedHealthTracker]isSameDayWithDate1:date date2:food.dateConsumed])
                {
                    //Date alleady exists.
                    doesDateExistAlready = YES;
                    break;//Leave loop
                }
                else
                {
                    doesDateExistAlready = NO;
                }
            }
            if (NO == doesDateExistAlready || arrayOfUniqueDatesThatFoodHasBeenConsumedOn.count == 0)//Need to make sure if it is empty we add it
            {
                //If no dates are duplicated store the date
                [arrayOfUniqueDatesThatFoodHasBeenConsumedOn addObject:food.dateConsumed];
            }
        }
        for(NSDate *date in arrayOfUniqueDatesThatFoodHasBeenConsumedOn)
        {
            //For each date get the 5 a day stats
            float numberOfFiveADay = [[HealthTracker sharedHealthTracker]numberOfFiveADayEatenForDate:date];
            float percentageEaten = (numberOfFiveADay/5)*100;
            if (percentageEaten > 100.0f)
            {
                //Cannot be over 100%
                percentageEaten = 100.0f;
            }
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd/MM/yyyy @ HH:mm"];
            //Setup graphing stuff
            [arrayOfValues addObject:[NSNumber numberWithDouble:percentageEaten]];
            [arrayOfDescriptions addObject:[NSString stringWithFormat:@"%d / 5 Fruit & veg %@",[[HealthTracker sharedHealthTracker]numberOfFiveADayEatenForDate:date],[dateFormatter stringFromDate:date]]];
        }
    }
    if([self.dataType isEqualToString:@"BMI"])
    {
        for(BMI *bmiObj in self.dataResults)
        {
            bmiResult = [bmiObj.bmiResult doubleValue];
            double maxBMI = 40;
            double percentageBMI = (bmiResult/maxBMI)*100;
            if (percentageBMI > 100.0)
            {
                percentageBMI = 100.0;
            }
            [arrayOfValues addObject:[NSNumber numberWithDouble:percentageBMI]];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd/MM/yyyy @ HH:mm"];
            [arrayOfDescriptions addObject:[NSString stringWithFormat:@"%0.1f BMI on %@", bmiResult, [dateFormatter stringFromDate:bmiObj.date]]];
        }
    }
    //Setup array and copy to view;
    self.graphView.arrayOfResultValues = [arrayOfValues mutableCopy];
    self.graphView.arrayOfResultLabel = [arrayOfDescriptions mutableCopy];
    self.graphView.bmiResult = bmiResult;
    self.graphView.dataType = self.dataType;
}

- (void)viewDidAppear:(BOOL)animated
{
    self.graphView.frame = CGRectMake(0, -50, (self.dataResults.count * ((BAR_WIDTH + BAR_SPACEING) + 60)), self.view.frame.size.height - 50);//Creates correctly sized graph
    [self.scrollView addSubview:self.graphView];
    self.graphView.backgroundColor = [UIColor lightGrayColor];
    self.scrollView.backgroundColor = [UIColor lightGrayColor];
    self.scrollView.contentSize = CGSizeMake(self.graphView.frame.size.width, self.graphView.frame.size.height-50);//Make sure the content is the correct size to hold it so it is scrollable
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButtonPressed:(id)sender;
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
