//
//  GraphViewController.h
//  HealthTracker
//
//  Created by Yoko Alpha on 05/04/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"

@interface GraphViewController : UIViewController
@property (nonatomic, strong) IBOutlet GraphView *graphView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *dataResults;
@property (nonatomic, strong) NSString *dataType;

- (IBAction)doneButtonPressed:(id)sender;

@end
