//
//  SummaryViewController.h
//  HealthTracker
//
//  Created by Yoko Alpha on 13/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleSummaryView.h"

@interface SummaryViewController : UIViewController
@property (nonatomic,strong) IBOutlet UIView *topbarView;
@property (nonatomic,strong) IBOutlet UIProgressView *fiveADayBar;
@property (nonatomic,strong) IBOutlet UILabel *fiveADayPercentageLabel;
@property (nonatomic,strong) IBOutlet UIView *bottombarView;
@property (nonatomic,strong) IBOutlet CircleSummaryView *circleView;
@end
