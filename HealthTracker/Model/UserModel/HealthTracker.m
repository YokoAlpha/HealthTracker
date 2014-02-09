//
//  HealthTracker.m
//  HealthTracker
//
//  Created by Yoko Alpha on 02/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "HealthTracker.h"
#import "Profile.h"
#import "ConsumedFood.h"

NSString *healthTrackerDidUpdateNotification = @"healthTrackerDidUpdateNotification";

@interface HealthTracker()
@property (nonatomic,strong) NSMutableArray *testArrayOfFoods;
@end

@implementation HealthTracker

- (id)init
{
    self = [super init];
    if (self)
    {
        self.testArrayOfFoods = [[NSMutableArray alloc]init];
    }
    return self;
}

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
    ConsumedFood *consumedFood = [[ConsumedFood alloc]init];
    //Transfer existing food information.
    consumedFood.foodName = food.foodName;
    consumedFood.foodCategory = food.foodCategory;
    consumedFood.measurement = food.measurement;
    //Set additional properties.
    consumedFood.dateConsumed = date;
    consumedFood.quantityConsumed = [NSNumber numberWithInteger:quantity];
    [self.testArrayOfFoods addObject:consumedFood];
    [self dataUpdated];
}

- (NSInteger)numberOfFoodsEatenForDate:(NSDate *)date
{
    return [self.testArrayOfFoods count];
}

/*!
 Post notification to show that data set has changed for the health tracker.
 */
- (void)dataUpdated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:healthTrackerDidUpdateNotification object:self];
}

@end
