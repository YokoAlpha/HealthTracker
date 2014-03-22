//
//  RunHistoryViewController.h
//  HealthTracker
//
//  Created by Yoko Alpha on 22/03/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RunHistoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSArray *arrayOfPreviousRuns;

@end
