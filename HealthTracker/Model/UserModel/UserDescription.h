//
//  UserDescription.h
//  HealthTracker
//
//  Created by Yoko Alpha on 02/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDescription : NSObject
@property (nonatomic,strong) NSString *gender;
@property (nonatomic,strong) NSDate *dateOfBirth;
@property (nonatomic) NSInteger dayForBMICheck;
@property (nonatomic,strong) NSDate *breakfastReminder;
@property (nonatomic,strong) NSDate *lunchReminder;
@property (nonatomic,strong) NSDate *dinnerReminder;
@property (nonatomic) BOOL releventFeedback;
@property (nonatomic,strong) NSString *measurementSystem;
@end
