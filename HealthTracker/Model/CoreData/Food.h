//
//  Food.h
//  HealthTracker
//
//  Created by Yoko Alpha on 09/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Food : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSDate * dateConsumed;
@property (nonatomic, retain) NSString * measurement;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * quantityConsumed;

@end
