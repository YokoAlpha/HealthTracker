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
#import "RunDescription.h"
#import "BMIDescription.h"
#import "HealthTrackerAppDelegate.h"
@import CoreData; // New style of importing framework

extern NSString *healthTrackerDidUpdateNotification;//Extern used to alow the private variable to be accessed

@interface HealthTracker : NSObject <NSFetchedResultsControllerDelegate>//Delegate for controlling returned results from Core Data
{
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;//Used to interact with fetching data from core Data
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;// Holds to context that is in memory


#pragma mark - Overview

/*!
 Important method returns global HealthTracker which means it can be used from any class when the app is running.
 */
+ (HealthTracker *)sharedHealthTracker;

/*!
 Unility method for checking matching date
 @return Returns YES if date 1 occurs on same day as date2.
 */
- (BOOL)isSameDayWithDate1:(NSDate*)date1
                     date2:(NSDate*)date2;

#pragma mark - User
/*!
 Function for adding user,
 @return Success of failure of adding user.
 */
- (BOOL)addUser:(UserDescription *)user;

/*!
 Function for changing users preferences,
 */
- (void)updateUser:(UserDescription *)user;

/*!
 Function for getting users preferences,
 @return users preferences.
 */
- (UserDescription *)retrieveUserData;

/*!
 Function for adding finding apps set measurement system,
 @return Success of failure of adding user.
 */
- (BOOL)isMetricSystem;

#pragma mark - Runs

/*!
 @return Returns distance covered as a interger value for an NSDate.
 */
- (NSInteger)distanceRanForDate:(NSDate *)date;

/*!
 Used to store a run into Core Data.
 */
- (void)addCompletedRun:(RunDescription *)run;

/*!
 @return Returns all of the runs from Core Data.
 */
- (NSArray *)allRunsCompleted;

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

/*!
 Function for getting number of foods per day
 @return Number of foods items consumed.
 */
- (NSInteger)numberOfFoodsEatenForDate:(NSDate *)date;

/*!
 Function for getting number of 5 a day
 @return Number of fruit and vegtables consumed.
 */
- (NSInteger)numberOfFiveADayEatenForDate:(NSDate *)date;

/*!
 Function for getting all the user consumed foods.
 @return Array on consumed foods.
 */
- (NSArray *)allFoodsEaten;

#pragma mark - BMI

/*!
 Function for getting users BMI score.
 @return BMI count.
 */
- (double)bmiCount;

/*!
 Function for changing users BMI.
 */
- (void)addBMIResult:(BMIDescription *)bmiResult;

/*!
 Function for getting users BMI results.
 @return all BMI objects stored in Core Data.
 */
- (NSArray *)allBMIResults;

/*!
 Function for changing users weight.
 */
- (void)updateWeight:(double)newWeight;

/*!
 Function for getting users weight.
 @return weight.
 */
- (double)retrieveWeight;

/*!
 Function for changing users height.
 */
- (void)updateHeight:(double)newHeight;

/*!
 Function for getting users height.
 @return height.
 */
- (double)retrieveHeight;

@end
