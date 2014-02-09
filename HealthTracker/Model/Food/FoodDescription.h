//
//  FoodDescription.h
//  HealthTracker
//
//  Created by Yoko Alpha on 25/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodDescription : NSObject
@property (nonatomic,strong) NSString *foodName;
@property (nonatomic,strong) NSString *foodCategory;
@property (nonatomic,strong) NSString *measurement;
@property (nonatomic,strong) NSNumber *quantityConsumed;//NSNumber used for more precision in future.
@property (nonatomic,strong) NSDate *dateConsumed;
@end
