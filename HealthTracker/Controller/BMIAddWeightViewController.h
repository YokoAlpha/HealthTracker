//
//  BMIAddWeightViewController.h
//  HealthTracker
//
//  Created by Yoko Alpha on 15/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMIAddWeightViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong)IBOutlet UIView * bmiWeightView;
@property (nonatomic, strong)IBOutlet UIView * bmiWeightInnerView;
@property (nonatomic, strong)IBOutlet UIPickerView * pickerView;

@end
