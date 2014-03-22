//
//  Run.h
//  HealthTracker
//
//  Created by Yoko Alpha on 22/03/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Run : NSManagedObject

@property (nonatomic, retain) id arrayOfRunPoints;
@property (nonatomic, retain) NSDate * runEndTime;
@property (nonatomic, retain) NSDate * runStartTime;
@property (nonatomic, retain) NSNumber * distanceRan;
@property (nonatomic, retain) User *newRelationship;

@end
