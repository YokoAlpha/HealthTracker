//
//  User.h
//  HealthTracker
//
//  Created by Yoko Alpha on 22/03/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Food;

@interface User : NSManagedObject

@property (nonatomic, retain) NSDate * breakfastReminder;
@property (nonatomic, retain) NSDate * dateOfBirth;
@property (nonatomic, retain) NSNumber * dayForBMICheck;
@property (nonatomic, retain) NSDate * dinnerReminder;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSDate * lunchReminder;
@property (nonatomic, retain) NSString * measurementSystem;
@property (nonatomic, retain) NSNumber * releventFeedback;
@property (nonatomic, retain) NSSet *hasFood;
@property (nonatomic, retain) NSSet *hasRuns;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addHasFoodObject:(Food *)value;
- (void)removeHasFoodObject:(Food *)value;
- (void)addHasFood:(NSSet *)values;
- (void)removeHasFood:(NSSet *)values;

- (void)addHasRunsObject:(NSManagedObject *)value;
- (void)removeHasRunsObject:(NSManagedObject *)value;
- (void)addHasRuns:(NSSet *)values;
- (void)removeHasRuns:(NSSet *)values;

@end
