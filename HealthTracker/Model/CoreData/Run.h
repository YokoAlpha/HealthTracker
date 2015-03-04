//
//  Run.h
//  HealthTracker
//
//  Created by Yoko Alpha on 04/03/2015.
//  Copyright (c) 2015 Yoko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Run : NSManagedObject

@property (nonatomic, retain) id arrayOfRunPoints;
@property (nonatomic, retain) NSNumber * distanceRan;
@property (nonatomic, retain) NSDate * runEndTime;
@property (nonatomic, retain) NSDate * runStartTime;
@property (nonatomic, retain) User *relationship;

@end
