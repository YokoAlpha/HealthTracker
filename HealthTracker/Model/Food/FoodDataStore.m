//
//  FoodDataStore.m
//  HealthTracker
//
//  Created by Yoko Alpha on 25/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//


#import "FoodDataStore.h"
#import "Food.h"

@interface FoodDataStore()
@property (nonatomic, strong) NSMutableArray *sugarAndFats;
@property (nonatomic, strong) NSMutableArray *dairyAndMeat;
@property (nonatomic, strong) NSMutableArray *vegtables;

@end

@implementation FoodDataStore


- (id)init
{
    self = [super init];
    if (self)
    {
        [self populateData];
    }
    return self;
}


- (void)populateData
{
    self.sugarAndFats = [[NSMutableArray alloc]initWithArray:
                         [self transformDictionaryIntoArrayOfFoods:[self loadFromPlist:@"SugarAndFats"]]];
    self.dairyAndMeat = [[NSMutableArray alloc]initWithArray:
                         [self transformDictionaryIntoArrayOfFoods:[self loadFromPlist:@"DairyAndMeat"]]];
    self.vegtables = [[NSMutableArray alloc]initWithArray:
                      [self transformDictionaryIntoArrayOfFoods:[self loadFromPlist:@"Vegetable"]]];
}


- (NSArray *)transformDictionaryIntoArrayOfFoods:(NSDictionary *)dictionary
{
    NSMutableArray *returnedArray = [[NSMutableArray alloc]init];//To be send back
    NSArray *keys = [dictionary allKeys];
    //For each dictionary key (category name).
    for (NSString *key in keys)
    {
        //Get the food
        id food = [dictionary objectForKey:key];
        //Make sure it is a dictionary class or bad things will happen!
        if (YES == [food isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *foodDict = (NSDictionary *)food;
            //Get the array
            for (NSString *foodDictKey in [foodDict allKeys])
            {
                //Hopefully only one array will be returned
                id foodArray = [foodDict objectForKey:foodDictKey];
                if (YES == [foodArray isKindOfClass:[NSArray class]])
                {
                    NSArray *finalFoodArray = (NSArray *)foodArray;
                    //Transform each array into a food
                    Food *foodObj = [[Food alloc]init];
                    foodObj.foodName = foodDictKey;
                    foodObj.foodCategory = key;
                    foodObj.measurement = [finalFoodArray firstObject];//First element allways measurement type
                    [returnedArray addObject:foodObj];
                }
            }
        }
    }
    return [returnedArray copy];
}

- (NSDictionary *)loadFromPlist:(NSString *)plistFileName
{
    // Find out the path of recipes.plist
    NSString *path = [[NSBundle mainBundle] pathForResource:plistFileName ofType:@"plist"];
    // Load the file content and read the data into arrays
    return [[NSDictionary alloc] initWithContentsOfFile:path];
}

- (NSArray *)retrieveSugarAndFats
{
    return [self.sugarAndFats copy];
}

- (NSArray *)retrieveDairyAndMeat;
{
    return [self.dairyAndMeat copy];
}

- (NSArray *)retrieveVegtables
{
    return [self.vegtables copy];
}

@end
