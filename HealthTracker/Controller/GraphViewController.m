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
    self.graphView = [[GraphView alloc]init];
    NSMutableArray *arrayOfValues = [[NSMutableArray alloc]init];
    NSMutableArray *arrayOfDescriptions = [[NSMutableArray alloc]init];
    //Change color depending on bmi etc
    if([self.dataType isEqualToString:@"Run"])
    {
        self.graphView.barColor = [UIColor blueColor];
        for(Run *runObj in self.dataResults)
        {
            double percentageRan = ([runObj.distanceRan doubleValue]/5.0)*100;
            [arrayOfValues addObject:[NSNumber numberWithDouble:percentageRan]];
            [arrayOfDescriptions addObject:[NSString stringWithFormat:@"10%% 5.5KM 16/04/2014"]];
        }
    }
    if([self.dataType isEqualToString:@"Food"])
    {
        self.graphView.barColor = [UIColor greenColor];
    }
    if([self.dataType isEqualToString:@"BMI"])
    {
        self.graphView.barColor = [UIColor redColor];
    }
    //Setup array and copy to view;
    self.graphView.arrayOfResultValues = [arrayOfValues mutableCopy];
    self.graphView.arrayOfResultLabel = [arrayOfDescriptions mutableCopy];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    self.graphView.frame = CGRectMake(0, -50, (self.dataResults.count * ((BAR_WIDTH + BAR_SPACEING) + 60)), self.view.frame.size.height - 50);
    [self.scrollView addSubview:self.graphView];
    self.graphView.backgroundColor = [UIColor lightGrayColor];
    self.scrollView.backgroundColor = [UIColor lightGrayColor];
    self.scrollView.contentSize = CGSizeMake(self.graphView.frame.size.width, self.graphView.frame.size.height-50);
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
