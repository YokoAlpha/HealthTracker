//
//  GraphViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 05/04/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "GraphViewController.h"

@interface GraphViewController ()

@end

@implementation GraphViewController

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
}

- (void)viewDidAppear:(BOOL)animated
{
    self.graphView = [[GraphView alloc]initWithFrame:CGRectMake(0, -50, (20 * ((BAR_WIDTH + BAR_SPACEING) + 40)), self.view.frame.size.height - 50)];
    [self.scrollView addSubview:self.graphView];
    self.graphView.backgroundColor = [UIColor blackColor];
    self.scrollView.contentSize = CGSizeMake(self.graphView.frame.size.width, self.graphView.frame.size.height-50);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButtonPressed:(id)sender;
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
