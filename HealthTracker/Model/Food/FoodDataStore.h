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
- (NSArray *)retrieveVegetables;
- (NSArray *)retrieveFruit;
- (NSArray *)retrieveStarch;
+ (NSArray *)foodTypesInArray:(NSArray *)foodsArray;
+ (NSInteger)numberOfFoodsForCategory:(NSString *)category
                            withArray:(NSArray *)array;
@end
