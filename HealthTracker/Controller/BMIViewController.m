//
//  BMIViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 13/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "BMIViewController.h"
#import "HealthTracker.h"

@interface BMIViewController ()

@end

@implementation BMIViewController

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
    self.bmiWeightView.layer.cornerRadius = 16.0f;
    self.bmiWeightView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bmiWeightView.layer.borderWidth = 0.2f;
    self.bmiWeightInnerView.layer.cornerRadius = 16.0f;
    self.bmiWeightInnerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bmiWeightInnerView.layer.borderWidth = 0.2f;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateOnScreenElements) name:healthTrackerDidUpdateNotification object:[HealthTracker sharedHealthTracker]];//Adds observer which will be used if the data updates to change the on screen labels.
    [self updateOnScreenElements];
}

- (void)updateOnScreenElements
{
    //Current user weight and height
    self.weight.text = [NSString stringWithFormat:@"%0.f KG", [HealthTracker sharedHealthTracker].retrieveWeight];
    //    self.height.text = [NSString stringWithFormat:@"%0.1f ft", [HealthTracker sharedHealthTracker].retrieveHeight];//Imperial
    self.height.text = [NSString stringWithFormat:@"%0.f CM", [HealthTracker sharedHealthTracker].retrieveHeight];

    /* Update BMI labels */
    double bmiResult = [HealthTracker sharedHealthTracker].bmiCount;
    float percentageOfObease = (bmiResult/30.0)*100;
    float progressBarPlot = percentageOfObease/100;
    if(bmiResult < 18.5)//UnderWeight
    {
        self.bmiDescription.text = @"Your BMI is in underweight range";
    }
    else if(bmiResult > 18.4 && bmiResult < 25.0)//Normal Weight
    {
        self.bmiDescription.text = @"Your BMI is in healthy range";
    }
    else if(bmiResult > 24.9 && bmiResult < 30.0)//Overweight
    {
        self.bmiDescription.text = @"Your BMI is in overweight range";
    }
    else if(bmiResult > 30.0)//Obesity
    {
        self.bmiDescription.text = @"Your BMI is in obesity range";
    }
    [self.bmiProgressBar setProgress:progressBarPlot];
    if (isnan(bmiResult))//Result is not a natural number
    {
        self.bmiResult.text = @"0";
    }
    else
    {
        self.bmiResult.text = [NSString stringWithFormat:@"%0.1f",bmiResult];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
