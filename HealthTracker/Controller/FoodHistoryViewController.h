//
//  FoodHistoryViewController.h
//  HealthTracker
//
//  Created by Yoko Alpha on 09/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodHistoryViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSArray *arrayOfPreviousFoods;
@end
