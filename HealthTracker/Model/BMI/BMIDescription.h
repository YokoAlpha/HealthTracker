//
//  BMIDescription.h
//  HealthTracker
//
//  Created by Yoko Alpha on 29/03/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMIDescription : NSObject
@property (nonatomic, weak) NSNumber * bmiResult;
@property (nonatomic, weak) NSDate * date;
@property (nonatomic, weak) NSNumber * height;
@property (nonatomic, weak) NSNumber * weight;

@end
