//
//  BMI.h
//  HealthTracker
//
//  Created by Yoko Alpha on 04/03/2015.
//  Copyright (c) 2015 Yoko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface BMI : NSManagedObject

@property (nonatomic, retain) NSNumber * bmiResult;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) User *relationship;

@end
