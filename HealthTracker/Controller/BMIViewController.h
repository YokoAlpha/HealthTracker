//
//  BMIViewController.h
//  HealthTracker
//
//  Created by Yoko Alpha on 13/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMIViewController : UIViewController
@property (nonatomic, strong)IBOutlet UIView * bmiWeightView;
@property (nonatomic, strong)IBOutlet UIView * bmiWeightInnerView;
@property (nonatomic, strong)IBOutlet UILabel * weight;
@property (nonatomic, strong)IBOutlet UILabel * height;
@property (nonatomic, strong)IBOutlet UILabel * bmiDescription;
@property (nonatomic, strong)IBOutlet UILabel * bmiResult;
@property (nonatomic, strong)IBOutlet UIProgressView * bmiProgressBar;

@end
