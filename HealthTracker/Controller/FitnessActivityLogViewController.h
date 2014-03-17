//
//  FitnessActivityLogViewController.h
//  HealthTracker
//
//  Created by Yoko Alpha on 13/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FitnessActivityLogViewController : UIViewController
@property (nonatomic,strong) IBOutlet UILabel *distanceRunLabel;
@property (nonatomic,strong) IBOutlet UILabel *hoursLabel;
@property (nonatomic,strong) IBOutlet UILabel *minutesLabel;
@property (nonatomic,strong) IBOutlet UILabel *secondsLabel;
@property (nonatomic,strong) IBOutlet UILabel *hundredsOfSecondsLabel;
@property (nonatomic,strong) IBOutlet UIButton *startButton;
@property (nonatomic,strong) IBOutlet UIButton *stopButton;
@property (nonatomic,strong) IBOutlet UIButton *resetButton;
@end
