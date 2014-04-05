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
- (IBAction)doneButtonPressed:(id)sender;

@end
