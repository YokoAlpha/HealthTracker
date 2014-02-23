//
//  HealthTracker.m
//  HealthTracker
//
//  Created by Yoko Alpha on 02/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "HealthTracker.h"
#import "Food.h"
#import "User.h"
#import "NotificationAdapter.h"

NSString *healthTrackerDidUpdateNotification = @"healthTrackerDidUpdateNotification";

@interface HealthTracker()
@property (nonatomic,strong) NSMutableArray *testArrayOfFoods;
@end

@implementation HealthTracker
@synthesize fetchedResultsController, managedObjectContext;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.testArrayOfFoods = [[NSMutableArray alloc]init];
    }
    return self;
}

#pragma mark - Overview

+ (HealthTracker *)sharedHealthTracker
{
    //Grand Central dispatch function using blocks to only return the object once.
    static dispatch_once_t onceToken;
    static HealthTracker *sharedHealthTracker;
    dispatch_once(&onceToken, ^{
        sharedHealthTracker = [[HealthTracker alloc]init];
    });
    return sharedHealthTracker;
}

/*!
 Post notification to show that data set has changed for the health tracker.
 */
- (void)dataUpdated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:healthTrackerDidUpdateNotification object:self];
}

#pragma mark - User

- (BOOL)addUser:(UserDescription *)user
{
    if (0 == [self numberofUsers])
    {
        NSManagedObjectContext *context = [self managedObjectContext];
        User *userObjectToAdd = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                              inManagedObjectContext:context];
        userObjectToAdd.gender = user.gender;
        userObjectToAdd.dateOfBirth = user.dateOfBirth;
        userObjectToAdd.dayForBMICheck = [NSNumber numberWithInteger:user.dayForBMICheck];
        userObjectToAdd.breakfastReminder = user.breakfastReminder;
        userObjectToAdd.lunchReminder = user.lunchReminder;
        userObjectToAdd.dinnerReminder = user.dinnerReminder;
        userObjectToAdd.releventFeedback = [NSNumber numberWithBool:user.releventFeedback];
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        [self dataUpdated];
        //remember dayForBMICheck position starts at 0
        [NotificationAdapter updateLocalNotificationsWithUser:user];
        return YES;
    }
    else
    {
        NSLog(@"Could not add user as one already exists");
        [self updateUser:user];//Update user instead.
        return NO;
    }
}

- (UserDescription *)retrieveUserData
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    if (fetchedObjects.count != 1)
    {
        NSAssert(FALSE, @"There can only be one User currently, terminate app if this is the case");
    }
    else
    {
        id objectFromUserData = [fetchedObjects firstObject];
        if ([objectFromUserData isKindOfClass:[User class]])
        {
            User *userReturned = (User *)objectFromUserData;
            UserDescription *newUser = [[UserDescription alloc]init];
            newUser.gender = userReturned.gender;
            newUser.dateOfBirth = userReturned.dateOfBirth;
            newUser.dayForBMICheck = [userReturned.dayForBMICheck integerValue];
            newUser.breakfastReminder = userReturned.breakfastReminder;
            newUser.lunchReminder = userReturned.lunchReminder;
            newUser.dinnerReminder = userReturned.dinnerReminder;
            newUser.releventFeedback = [userReturned.releventFeedback boolValue];
            return newUser;
        }
    }
    return nil;
}

- (NSInteger)numberofUsers
{
    //Used to make sure that there is only one user.
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    return [fetchedObjects count];
}

- (void)updateUser:(UserDescription *)user
{
    //Retriveing object
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    /* Get Original object */
    if (fetchedObjects.count != 1)
    {
        NSAssert(FALSE, @"There can only be one User currently, terminate app if this is the case");
    }
    else
    {
        //Overwrite it
        id objectFromUserData = [fetchedObjects firstObject];
        if ([objectFromUserData isKindOfClass:[User class]])
        {
            User *userReturned = (User *)objectFromUserData;
            userReturned.gender = user.gender;
            userReturned.dateOfBirth = user.dateOfBirth;
            userReturned.dayForBMICheck = [NSNumber numberWithInteger:user.dayForBMICheck];
            userReturned.breakfastReminder = user.breakfastReminder;
            userReturned.lunchReminder = user.lunchReminder;
            userReturned.dinnerReminder = user.dinnerReminder;
            userReturned.releventFeedback = [NSNumber numberWithBool:user.releventFeedback];
            NSError *error = nil;
            BOOL savedSuccessfully = [self.managedObjectContext save:&error];
            if (!savedSuccessfully)
            {
                NSLog(@"Could not save date change! Reason : %@", [error localizedDescription]);
            }
            //Make changes
        }
    }
    [NotificationAdapter updateLocalNotificationsWithUser:user];
}

#pragma mark - Food

- (void)addConsumedFood:(FoodDescription *)food
           withQuantity:(NSInteger)quantity
{
    [self addConsumedFood:food withQuantity:quantity onDate:[NSDate date]];// reuse function with todays current time.
}

- (void)addConsumedFood:(FoodDescription *)food
           withQuantity:(NSInteger)quantity
                 onDate:(NSDate *)date
{
    NSManagedObjectContext *context = [self managedObjectContext];
    Food *foodObjectToAdd = [NSEntityDescription insertNewObjectForEntityForName:@"Food"
                                      inManagedObjectContext:context];
    foodObjectToAdd.name = food.foodName;
    foodObjectToAdd.measurement = food.measurement;
    foodObjectToAdd.category = food.foodCategory;
    foodObjectToAdd.dateConsumed = date;
    foodObjectToAdd.quantityConsumed = [NSNumber numberWithInteger:quantity];
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    [self dataUpdated];
}


- (NSInteger)numberOfFoodsEatenForDate:(NSDate *)date
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Food"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    return [fetchedObjects count];
}

- (NSInteger)numberOfFiveADayEaten
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Food"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    //Use day (parse day and find the number of fruit and veg eaten for that day)
    
    return [fetchedObjects count];
}


- (NSArray *)allFoodsEaten
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Food"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
}

@end
