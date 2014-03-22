//
//  RunDescription.h
//  HealthTracker
//
//  Created by Yoko Alpha on 22/03/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunDescription : NSObject
@property (nonatomic,strong) NSMutableArray *arrayOfRunPoints;
@property (nonatomic) double distanceRan;
@property (nonatomic,strong) NSDate *runStartTime;
@property (nonatomic,strong) NSDate *runEndTime;

@end
