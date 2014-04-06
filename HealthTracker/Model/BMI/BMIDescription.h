//
//  BMIDescription.h
//  HealthTracker
//
//  Created by Yoko Alpha on 29/03/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMIDescription : NSObject
@property (nonatomic, strong) NSNumber * bmiResult;
@property (nonatomic, strong) NSDate * date;
@property (nonatomic, strong) NSNumber * height;
@property (nonatomic, strong) NSNumber * weight;

@end
