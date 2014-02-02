//
//  FoodDetailViewController.h
//  HealthTracker
//
//  Created by Yoko Alpha on 26/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"

@interface FoodDetailViewController : UIViewController <UIPickerViewDelegate>
@property (nonatomic,strong) IBOutlet UILabel *foodLabel;
@property (nonatomic,strong) IBOutlet UIPickerView *pickerView;
@property (nonatomic,strong) Food *foodData;
@end
