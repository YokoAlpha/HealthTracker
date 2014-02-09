//
//  ConsumedFood.h
//  HealthTracker
//
//  Created by Yoko Alpha on 02/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "Food.h"

@interface ConsumedFood : Food
@property (nonatomic,strong) NSNumber *quantityConsumed;//NSNumber used for more precision in future.
@property (nonatomic,strong) NSDate *dateConsumed;

@end
