//
//  HealthTracker.h
//  HealthTracker
//
//  Created by Yoko Alpha on 02/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Food.h"
#import "User.h"

extern NSString *healthTrackerDidUpdateNotification;//Extern used to alow the private variable to be accessed

@interface HealthTracker : NSObject

/*!
 Important method returns global HealthTracker which means it can be used from any class when the app is running.
 */
+ (HealthTracker *)sharedHealthTracker;


#pragma mark - User
/*!
 Function for adding user,
 @return Success of failure of adding user.
 */
- (BOOL)addUser:(User *)user;

#pragma mark - Food

/*!
 User added Food using todays date with current time.
 */
- (void)addConsumedFood:(Food *)food
           withQuantity:(NSInteger)quantity;

/*!
 User added Food using user defined Argument.
 */
- (void)addConsumedFood:(Food *)food
           withQuantity:(NSInteger)quantity
                 onDate:(NSDate *)date;

- (NSInteger)numberOfFoodsEatenForDate:(NSDate *)date;

@end
