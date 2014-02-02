//
//  FoodTrackerViewController.h
//  HealthTracker
//
//  Created by Yoko Alpha on 13/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodTrackerViewController : UIViewController
@property (nonatomic,strong) IBOutlet UILabel *numberOfFoodsEatenTodayLabel;
- (IBAction)foodButtonPressed:(id)sender;
@end
