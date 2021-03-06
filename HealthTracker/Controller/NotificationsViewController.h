//
//  NotificationsViewController.h
//  HealthTracker
//
//  Created by Yoko Alpha on 16/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDescription.h"
#import "HealthTracker.h"

@interface NotificationsViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,strong)IBOutlet UILabel *breakfastTimeLabel;
@property (nonatomic,strong)IBOutlet UILabel *lunchTimeLabel;
@property (nonatomic,strong)IBOutlet UILabel *dinnerTimeLabel;
@property (nonatomic,strong)IBOutlet UISegmentedControl *weekdaySwitch;
@property (nonatomic,strong)IBOutlet UISegmentedControl *feedBackSwitch;
@property (nonatomic,strong)IBOutlet UIView *pickerContainer;
@property (nonatomic,strong)IBOutlet UIPickerView *picker;
@property (nonatomic,strong) UserDescription *userDetailsToTransfer;
@end
