//
//  FoodDataStore.m
//  HealthTracker
//
//  Created by Yoko Alpha on 25/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//


#import "FoodDataStore.h"
#import "FoodDescription.h"

@interface FoodDataStore()
@property (nonatomic, strong) NSMutableArray *sugarAndFats;
@property (nonatomic, strong) NSMutableArray *dairyAndMeat;
@property (nonatomic, strong) NSMutableArray *vegetables;
@property (nonatomic, strong) NSMutableArray *fruit;
@property (nonatomic, strong) NSMutableArray *starch;

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
                         [self transformDictionaryIntoArrayOfFoods:[self loadFromPlist:@"SugarAndFats"] withKind:@"SugarAndFats"]];
    self.dairyAndMeat = [[NSMutableArray alloc]initWithArray:
                         [self transformDictionaryIntoArrayOfFoods:[self loadFromPlist:@"DairyAndMeat"] withKind:@"DairyAndMeat"]];
    self.vegetables = [[NSMutableArray alloc]initWithArray:
                      [self transformDictionaryIntoArrayOfFoods:[self loadFromPlist:@"Vegetable"] withKind:@"Vegetable"]];
    self.fruit = [[NSMutableArray alloc]initWithArray:
                      [self transformDictionaryIntoArrayOfFoods:[self loadFromPlist:@"Fruit"] withKind:@"Fruit"]];
    self.starch = [[NSMutableArray alloc]initWithArray:
                      [self transformDictionaryIntoArrayOfFoods:[self loadFromPlist:@"Starch"] withKind:@"Starch"]];
}


- (NSArray *)transformDictionaryIntoArrayOfFoods:(NSDictionary *)dictionary
                                        withKind:(NSString *)kind;
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
                    FoodDescription *foodObj = [[FoodDescription alloc]init];
                    foodObj.foodName = foodDictKey;
                    foodObj.foodCategory = key;
                    foodObj.kind = kind;
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
    return [self foodCategoryArraysWithArray:[self.sugarAndFats copy]];
}

- (NSArray *)retrieveDairyAndMeat;
{
    return [self foodCategoryArraysWithArray:[self.dairyAndMeat copy]];
}

- (NSArray *)retrieveVegetables
{
    return [self foodCategoryArraysWithArray:[self.vegetables copy]];
}

- (NSArray *)retrieveFruit;
{
    return [self foodCategoryArraysWithArray:[self.fruit copy]];
}

- (NSArray *)retrieveStarch;
{
    return [self foodCategoryArraysWithArray:[self.starch copy]];
}

#pragma mark - Utility Methods.

- (NSArray *)foodCategoryArraysWithArray:(NSArray *)array
{
    NSMutableArray *foodCategorySortedArrays = [[NSMutableArray alloc]init];
    NSArray *foodCategories = [FoodDataStore foodTypesInArray:array];
    //For each food type that exists
    for (NSString* foodCategory in foodCategories)
    {
        //Create array
        NSMutableArray *foodTypeArray = [[NSMutableArray alloc]init];
        //Add food
        for (FoodDescription *food in array)
        {
            if ([food.foodCategory isEqualToString:foodCategory])
            {
                [foodTypeArray addObject:food];
            }
        }
        //Add array to array of types
        [foodCategorySortedArrays addObject:foodTypeArray];
    }
    return [foodCategorySortedArrays copy];
}

+ (NSArray *)foodTypesInArray:(NSArray *)foodsArray
{
    NSMutableArray *differentFoodTypes = [[NSMutableArray alloc]init];
    for (id foodObj in foodsArray)
    {
        if ([foodObj isKindOfClass:[FoodDescription class]])
        {
            FoodDescription *foodCorrectDataType = (FoodDescription*)foodObj;
            [differentFoodTypes addObject:foodCorrectDataType.foodCategory];
        }
    }
    NSMutableArray * unique = [NSMutableArray array];
    NSMutableSet * processed = [NSMutableSet set];
    for (NSString * string in differentFoodTypes) {
        if ([processed containsObject:string] == NO) {
            [unique addObject:string];
            [processed addObject:string];
        }
    }
    return [unique copy];
    //return [[NSOrderedSet orderedSetWithArray:differentFoodTypes] array];
}

+ (NSInteger)numberOfFoodsForCategory:(NSString *)category
                            withArray:(NSArray *)array
{
    NSInteger foodCount = 0;
    for (FoodDescription *foodObj in array)
    {
        if ([foodObj.foodCategory isEqualToString:category])
        {
            foodCount++;
        }
    }
    return foodCount;
}

@end
