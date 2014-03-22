//
//  FitnessActivityLogViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 13/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "FitnessActivityLogViewController.h"
#import "RunDescription.h"
#import "HealthTracker.h"

@interface FitnessActivityLogViewController ()
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation FitnessActivityLogViewController

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

- (IBAction)startButtonPressed:(id)sender
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                  target:self
                                                selector:@selector(showTime)
                                                userInfo:nil
                                                 repeats:YES];
    [self buttonStatesWithStartState:NO stopState:YES resetState:NO];
}

- (IBAction)stopButtonPressed:(id)sender
{
    [self.timer invalidate];
    self.timer = nil;
    [self buttonStatesWithStartState:YES stopState:NO resetState:YES];
}

- (IBAction)resetButtonPressed:(id)sender
{
    self.hoursLabel.text = @"0";
    self.minutesLabel.text = @"0";
    self.secondsLabel.text = @"0";
    self.hundredsOfSecondsLabel.text = @"0";
    [self buttonStatesWithStartState:YES stopState:NO resetState:NO];
}


- (void)showTime
{
    int hours = 0;
    int minutes = 0;
    int seconds = 0;
    int hundredths = 0;
    NSArray *timeArray = [NSArray arrayWithObjects:self.hundredsOfSecondsLabel.text, self.secondsLabel.text, self.minutesLabel.text, self.hoursLabel.text, nil];
    int startCount = [timeArray count] - 1;
    for (startCount; startCount >= 0;startCount--)
    {
        int timeComponent = [[timeArray objectAtIndex:startCount] intValue];
        switch (startCount)
        {
            case 3:
                hours = timeComponent;
                break;
            case 2:
                minutes = timeComponent;
                break;
            case 1:
                seconds = timeComponent;
                break;
            case 0:
                hundredths = timeComponent;
                hundredths++;
                break;
                
            default:
                break;
        }
    }
    if (hundredths == 100)
    {
        seconds++;
        hundredths = 0;
    }
    else if (seconds == 60)
    {
        minutes++;
        seconds = 0;
    }
    else if (minutes == 60)
    {
        hours++;
        minutes = 0;
    }
    self.hoursLabel.text = [NSString stringWithFormat:@"%.0d", hours];
    self.minutesLabel.text = [NSString stringWithFormat:@"%.2d", minutes];
    self.secondsLabel.text = [NSString stringWithFormat:@"%.2d", seconds];
    self.hundredsOfSecondsLabel.text = [NSString stringWithFormat:@"%.2d", hundredths];
    
}

- (void)buttonStatesWithStartState:(BOOL)startState
                         stopState:(BOOL)stopState
                        resetState:(BOOL)resetState
{
    self.startButton.enabled = startState;
    self.stopButton.enabled = stopState;
    self.resetButton.enabled = resetState;
    self.startButton.alpha = self.stopButton.alpha = self.resetButton.alpha = 0.5;
    if(YES == startState)
    {
        self.startButton.alpha = 1;
    }
    if(YES == stopState)
    {
        self.stopButton.alpha = 1;
    }
    if(YES == resetState)
    {
        self.resetButton.alpha = 1;
    }
}

- (IBAction)saveRun:(id)sender
{
    RunDescription *rundescriptionToAdd = [[RunDescription alloc]init];
    rundescriptionToAdd.arrayOfRunPoints = [[NSMutableArray alloc]initWithObjects:@(1.5),@(3.6), nil];
    rundescriptionToAdd.distanceRan = 4.55;
    rundescriptionToAdd.runStartTime = [NSDate date];
    rundescriptionToAdd.runEndTime = [[NSDate date]dateByAddingTimeInterval:3600];
    [[HealthTracker sharedHealthTracker] addCompletedRun:rundescriptionToAdd];
}

@end
