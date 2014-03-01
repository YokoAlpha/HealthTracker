//
//  BMIViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 13/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "BMIViewController.h"
#import "HealthTracker.h"

@interface BMIViewController ()

@end

@implementation BMIViewController

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
    self.bmiWeightView.layer.cornerRadius = 16.0f;
    self.bmiWeightView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bmiWeightView.layer.borderWidth = 0.2f;
    self.bmiWeightInnerView.layer.cornerRadius = 16.0f;
    self.bmiWeightInnerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bmiWeightInnerView.layer.borderWidth = 0.2f;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.weight.text = [NSString stringWithFormat:@"%0.f KG", [HealthTracker sharedHealthTracker].retrieveWeight];
    self.height.text = [NSString stringWithFormat:@"%0.1f ft", [HealthTracker sharedHealthTracker].retrieveHeight];
                        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
