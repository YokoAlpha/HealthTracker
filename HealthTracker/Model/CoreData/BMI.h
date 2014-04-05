//
//  BMI.h
//  HealthTracker
//
//  Created by Yoko Alpha on 05/04/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface BMI : NSManagedObject

@property (nonatomic, retain) NSNumber * bmiResult;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) User *newRelationship;

@end
