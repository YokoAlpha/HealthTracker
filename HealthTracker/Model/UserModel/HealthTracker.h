//
//  HealthTracker.h
//  HealthTracker
//
//  Created by Yoko Alpha on 02/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodDescription.h"
#import "UserDescription.h"
#import "HealthTrackerAppDelegate.h"
@import CoreData;

extern NSString *healthTrackerDidUpdateNotification;//Extern used to alow the private variable to be accessed

@interface HealthTracker : NSObject <NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


#pragma mark - Overview

/*!
 Important method returns global HealthTracker which means it can be used from any class when the app is running.
 */
+ (HealthTracker *)sharedHealthTracker;


#pragma mark - User
/*!
 Function for adding user,
 @return Success of failure of adding user.
 */
- (BOOL)addUser:(UserDescription *)user;

- (void)updateUser:(UserDescription *)user;


- (UserDescription *)retrieveUserData;

#pragma mark - Food

/*!
 User added Food using todays date with current time.
 */
- (void)addConsumedFood:(FoodDescription *)food
           withQuantity:(NSInteger)quantity;

/*!
 User added Food using user defined Argument.
 */
- (void)addConsumedFood:(FoodDescription *)food
           withQuantity:(NSInteger)quantity
                 onDate:(NSDate *)date;

- (NSInteger)numberOfFoodsEatenForDate:(NSDate *)date;

- (NSInteger)numberOfFiveADayEaten;

/*!
 Function for getting all the user consumed foods.
 @return Array on consumed foods.
 */
- (NSArray *)allFoodsEaten;

@end
