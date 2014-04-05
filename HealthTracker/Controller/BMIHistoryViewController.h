//
//  BMIHistoryViewController.h
//  HealthTracker
//
//  Created by Yoko Alpha on 05/04/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMIHistoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSArray *arrayOfPreviousBMIResults;
@end
