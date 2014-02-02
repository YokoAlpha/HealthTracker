//
//  FoodSelectionViewController.h
//  HealthTracker
//
//  Created by Yoko Alpha on 25/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodSelectionViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) IBOutlet UITableView *tableview;
@property (nonatomic,strong) IBOutlet UIButton *doneButton;
@property (nonatomic,strong) NSMutableArray *foods;
- (IBAction)doneButtonPressed:(id)sender;
@end
