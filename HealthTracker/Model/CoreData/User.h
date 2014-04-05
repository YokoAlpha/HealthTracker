//
//  User.h
//  HealthTracker
//
//  Created by Yoko Alpha on 05/04/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BMI, Food, Run;

@interface User : NSManagedObject

@property (nonatomic, retain) NSDate * breakfastReminder;
@property (nonatomic, retain) NSDate * dateOfBirth;
@property (nonatomic, retain) NSNumber * dayForBMICheck;
@property (nonatomic, retain) NSDate * dinnerReminder;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSDate * lunchReminder;
@property (nonatomic, retain) NSString * measurementSystem;
@property (nonatomic, retain) NSNumber * releventFeedback;
@property (nonatomic, retain) NSSet *hasBMI;
@property (nonatomic, retain) NSSet *hasFood;
@property (nonatomic, retain) NSSet *hasRuns;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addHasBMIObject:(BMI *)value;
- (void)removeHasBMIObject:(BMI *)value;
- (void)addHasBMI:(NSSet *)values;
- (void)removeHasBMI:(NSSet *)values;

- (void)addHasFoodObject:(Food *)value;
- (void)removeHasFoodObject:(Food *)value;
- (void)addHasFood:(NSSet *)values;
- (void)removeHasFood:(NSSet *)values;

- (void)addHasRunsObject:(Run *)value;
- (void)removeHasRunsObject:(Run *)value;
- (void)addHasRuns:(NSSet *)values;
- (void)removeHasRuns:(NSSet *)values;

@end
