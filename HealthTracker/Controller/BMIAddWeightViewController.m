//
//  BMIAddWeightViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 15/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "BMIAddWeightViewController.h"

@interface BMIAddWeightViewController ()

@end

@implementation BMIAddWeightViewController

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
    self.bmiWeightView.layer.cornerRadius = 16.0f;
    self.bmiWeightView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bmiWeightView.layer.borderWidth = 0.2f;
    self.bmiWeightInnerView.layer.cornerRadius = 16.0f;
    self.bmiWeightInnerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bmiWeightInnerView.layer.borderWidth = 0.2f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
