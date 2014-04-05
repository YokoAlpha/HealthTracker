//
//  Food.h
//  HealthTracker
//
//  Created by Yoko Alpha on 05/04/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Food : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSDate * dateConsumed;
@property (nonatomic, retain) NSString * kind;
@property (nonatomic, retain) NSString * measurement;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * quantityConsumed;
@property (nonatomic, retain) User *newRelationship;

@end
