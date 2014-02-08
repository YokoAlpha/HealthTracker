//
//  IntroViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 08/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "IntroViewController.h"

@interface IntroViewController ()

@end

@implementation IntroViewController

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
    [self.textLabel sizeToFit];

    self.scrollView.scrollEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.textLabel.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
