//
//  FoodDataStore.h
//  HealthTracker
//
//  Created by Yoko Alpha on 25/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodDataStore : NSObject
- (NSArray *)retrieveSugarAndFats;
- (NSArray *)retrieveDairyAndMeat;
- (NSArray *)retrieveVegtables;
@end
