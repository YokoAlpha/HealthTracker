//
//  HealthTracker.m
//  HealthTracker
//
//  Created by Yoko Alpha on 02/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "HealthTracker.h"
#import "Profile.h"

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

- (BOOL)addUser:(User *)user
{
    return YES;
}

#pragma mark - Food

- (void)addConsumedFood:(Food *)food
           withQuantity:(NSInteger)quantity
{
    [self addConsumedFood:food withQuantity:quantity onDate:[NSDate date]];// reuse function with todays current time.
}

- (void)addConsumedFood:(Food *)food
           withQuantity:(NSInteger)quantity
                 onDate:(NSDate *)date
{
    Food *consumedFood = [[Food alloc]init];
    //Transfer existing food information.
    consumedFood.foodName = food.foodName;
    consumedFood.foodCategory = food.foodCategory;
    consumedFood.measurement = food.measurement;
    //Set additional properties.
    consumedFood.dateConsumed = date;
    consumedFood.quantityConsumed = [NSNumber numberWithInteger:quantity];
    [self.testArrayOfFoods addObject:consumedFood];
    //Add To core data
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *foodInfo = [NSEntityDescription
                                       insertNewObjectForEntityForName:@"Food"
                                       inManagedObjectContext:context];
    [foodInfo setValue:food.foodName forKey:@"name"];
    NSError *error;
    if (![context save:&error])
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Food" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    [self dataUpdated];
}


- (NSInteger)numberOfFoodsEatenForDate:(NSDate *)date
{
    return [self.testArrayOfFoods count];
}

- (NSArray *)allFoodsEaten
{
    return self.testArrayOfFoods;
}

@end
