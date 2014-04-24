
//
//  HealthTracker.m
//  HealthTracker
//
//  Created by Yoko Alpha on 02/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "HealthTracker.h"
#import "Food.h"
#import "User.h"
#import "Run.h"
#import "BMI.h"
#import "NotificationAdapter.h"

NSString *healthTrackerDidUpdateNotification = @"healthTrackerDidUpdateNotification";//String used in app for posted NSNotification for observers to updates

@interface HealthTracker()
@property (nonatomic,strong) NSMutableArray *testArrayOfFoods;//Testing array not used
@end

@implementation HealthTracker
@synthesize fetchedResultsController, managedObjectContext;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.testArrayOfFoods = [[NSMutableArray alloc]init];
    }
    return self;
}

#pragma mark - Overview

+ (HealthTracker *)sharedHealthTracker
{
    //Grand Central dispatch function using blocks to only return the object once.
    //This function is then used for making sure only one of this object can be used.
    static dispatch_once_t onceToken;//Static token for dispatching once
    static HealthTracker *sharedHealthTracker;//static health tracker
    dispatch_once(&onceToken, ^{
        sharedHealthTracker = [[HealthTracker alloc]init];//When Object is dispatched for the first time it is setup
    });
    return sharedHealthTracker;
}

/*
 Post notification to show that data set has changed for the health tracker.
 */
- (void)dataUpdated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:healthTrackerDidUpdateNotification object:self];
}

#pragma mark - User

- (BOOL)addUser:(UserDescription *)user
{
    if (0 == [self numberofUsers])//Only create a new user once!
    {
        NSManagedObjectContext *context = [self managedObjectContext];//get the current managed context
        User *userObjectToAdd = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                              inManagedObjectContext:context];//Creates a new user and inserts them into the database.
        userObjectToAdd.gender = user.gender;
        userObjectToAdd.dateOfBirth = user.dateOfBirth;
        userObjectToAdd.dayForBMICheck = [NSNumber numberWithInteger:user.dayForBMICheck];//Converts the number to a general NSNumber object so it can be saved.
        userObjectToAdd.breakfastReminder = user.breakfastReminder;
        userObjectToAdd.lunchReminder = user.lunchReminder;
        userObjectToAdd.dinnerReminder = user.dinnerReminder;
        userObjectToAdd.releventFeedback = [NSNumber numberWithBool:user.releventFeedback];//Converts the BOOL to a general NSNumber object so it can be saved.
        if (nil == user.measurementSystem)
        {
            userObjectToAdd.measurementSystem = @"Metric";//Default measurement system set
        }
        else
        {
            userObjectToAdd.measurementSystem = user.measurementSystem;//Otherwise we use the users preference
        }
        NSError *error;
        if (![context save:&error])//Log if error occurs when saving new user
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        [self dataUpdated];
        //remember dayForBMICheck position starts at 0
        [NotificationAdapter updateLocalNotificationsWithUser:user];//Tell health tracker to update observers on the changes.
        return YES;
    }
    else
    {
        NSLog(@"Could not add user as one already exists");
        [self updateUser:user];//Update user instead.
        return NO;
    }
}

- (UserDescription *)retrieveUserData
{
    NSManagedObjectContext *context = [self managedObjectContext];//Get current context of database
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];//Setup a fetch request
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"
                                              inManagedObjectContext:context];//Tell the context what kind of object we are looking for.
    [fetchRequest setEntity:entity];//Link the fetch request with our search criteria
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];//execute fetch request and store all results in array, + log any errors encounterd.
    
    if (fetchedObjects.count != 1)//Check if 1 user does not exist
    {
        //NSAssert(FALSE, @"There can only be one User currently, terminate app if this is the case");
    }
    else
    {
        //If one user does exist
        id objectFromUserData = [fetchedObjects firstObject];//get the first user in the returned results.
        if ([objectFromUserData isKindOfClass:[User class]])//Make sure the fetch request has returned a user.
        {
            User *userReturned = (User *)objectFromUserData;//Cast the ID type returned result as a User object because we know if is one from the check above.
            UserDescription *newUser = [[UserDescription alloc]init];
            //Transfer properties over to the local user description object.
            newUser.gender = userReturned.gender;
            newUser.dateOfBirth = userReturned.dateOfBirth;
            newUser.dayForBMICheck = [userReturned.dayForBMICheck integerValue];
            newUser.breakfastReminder = userReturned.breakfastReminder;
            newUser.lunchReminder = userReturned.lunchReminder;
            newUser.dinnerReminder = userReturned.dinnerReminder;
            newUser.releventFeedback = [userReturned.releventFeedback boolValue];
            newUser.measurementSystem = userReturned.measurementSystem;
            return newUser;
        }
    }
    return nil;
}

- (NSInteger)numberofUsers
{
    //Used to make sure that there is only one user.
    NSManagedObjectContext *context = [self managedObjectContext];//Get current context of database
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];//Setup a fetch request
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"
                                              inManagedObjectContext:context];//Tell the context what kind of object we are looking for.
    [fetchRequest setEntity:entity];//Link the fetch request with our search criteria
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];//execute fetch request and store all results in array, + log any errors
    return [fetchedObjects count];//Return total number of users from the fetched object count
}

- (void)updateUser:(UserDescription *)user
{
    //Retriveing object
    NSManagedObjectContext *context = [self managedObjectContext];//Get current context of database
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];//Setup a fetch request
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"
                                              inManagedObjectContext:context];//Tell the context what kind of object we are looking for.
    [fetchRequest setEntity:entity];//Link the fetch request with our search criteria
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];//execute fetch request and store all results in array, + log any errors
    
    /* Get Original object */
    if (fetchedObjects.count != 1)//Check if 1 user does not exist
    {
        NSAssert(FALSE, @"There can only be one User currently, terminate app if this is the case");
    }
    else
    {
        //If one user does exist
        //Overwrite it
        id objectFromUserData = [fetchedObjects firstObject];//get the first user in the returned results.
        if ([objectFromUserData isKindOfClass:[User class]])//Make sure the fetch request has returned a user.
        {
            //Transfer properties over to the core data dynamic properties.
            User *userReturned = (User *)objectFromUserData;//Cast the ID type returned result as a User object because we know if is one from the check above.
            userReturned.gender = user.gender;
            userReturned.dateOfBirth = user.dateOfBirth;
            userReturned.dayForBMICheck = [NSNumber numberWithInteger:user.dayForBMICheck];
            userReturned.breakfastReminder = user.breakfastReminder;
            userReturned.lunchReminder = user.lunchReminder;
            userReturned.dinnerReminder = user.dinnerReminder;
            userReturned.releventFeedback = [NSNumber numberWithBool:user.releventFeedback];
            userReturned.measurementSystem = user.measurementSystem;
            NSError *error = nil;
            BOOL savedSuccessfully = [self.managedObjectContext save:&error];//Save changes on the database context
            if (!savedSuccessfully)
            {
                NSLog(@"Could not save date change! Reason : %@", [error localizedDescription]);
            }
            //Make changes
        }
    }
    [NotificationAdapter updateLocalNotificationsWithUser:user];//Tell health tracker to update observers on the changes.
}

- (BOOL)isMetricSystem
{
    UserDescription *user = [self retrieveUserData];//Get the current user from the database
    return [user.measurementSystem isEqualToString:@"Metric"];//Returns if the user system is metric.
}

#pragma mark - Food

- (void)addConsumedFood:(FoodDescription *)food
           withQuantity:(NSInteger)quantity
{
    [self addConsumedFood:food withQuantity:quantity onDate:[NSDate date]];// reuse function with todays current time.
}

- (void)addConsumedFood:(FoodDescription *)food
           withQuantity:(NSInteger)quantity
                 onDate:(NSDate *)date
{
    NSManagedObjectContext *context = [self managedObjectContext];//Get current context of database
    //Link the fetch request with our search criteria
    Food *foodObjectToAdd = [NSEntityDescription insertNewObjectForEntityForName:@"Food"
                                      inManagedObjectContext:context];//Tell the context what kind of object we are looking for.
    /* Assing food details that are to be saved */
    foodObjectToAdd.name = food.foodName;
    foodObjectToAdd.measurement = food.measurement;
    foodObjectToAdd.category = food.foodCategory;
    foodObjectToAdd.dateConsumed = date;
    foodObjectToAdd.kind = food.kind;
    foodObjectToAdd.quantityConsumed = [NSNumber numberWithInteger:quantity];
    NSError *error;
    if (![context save:&error])//Save context to database
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    [self dataUpdated];
}


- (NSInteger)numberOfFoodsEatenForDate:(NSDate *)date
{
    NSManagedObjectContext *context = [self managedObjectContext];//Get current context of database
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];//Setup a fetch request
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Food"
                                              inManagedObjectContext:context];//Tell the context what kind of object we are looking for.
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];//Execute a fetch request on the context and record any errors
    return [fetchedObjects count];
}

- (NSInteger)numberOfFiveADayEatenForDate:(NSDate *)date
{
    NSManagedObjectContext *context = [self managedObjectContext];//Get current context of database
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];//Setup a fetch request
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Food"
                                              inManagedObjectContext:context];//Tell the context what kind of object we are looking for.
    [fetchRequest setEntity:entity];//Link the fetch request with our search criteria
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];//Execute a fetch request on the context and record any errors
    NSInteger numberOfFruitOrVegEaten = 0;
    for (id obj in fetchedObjects)//Interate over the objects returned from the array
    {
        Food *food = (Food *)obj;
        if ([food.kind isEqualToString:@"Vegetable"] || [food.kind isEqualToString:@"Fruit"])//check if fruit or veg
        {
            //Use day (parse day and find the number of fruit and veg eaten for that day)
            //Check if food was eaten today
            if ([self isSameDayWithDate1:date date2:food.dateConsumed])
            {
                numberOfFruitOrVegEaten++;//increase the counter by 1 each time it is found
            }
        }
    }
    return numberOfFruitOrVegEaten;//Return the total number of fruit and veg returned.
}

- (BOOL)isSameDayWithDate1:(NSDate*)date1
                     date2:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];//Gets the current iOS system calendar.
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;//Only uses day month and year as untes
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];//Split the first date into the above units
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];//Split the second date into the above units
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

- (NSArray *)allFoodsEaten
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Food"
                                              inManagedObjectContext:context];//Tell the context what kind of object we are looking for.
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];//Execute a fetch request on the context and record any errors
    return fetchedObjects;
}

#pragma mark - Runs

- (NSInteger)distanceRanForDate:(NSDate *)date
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Run"
                                              inManagedObjectContext:context];//Tell the context what kind of object we are looking for.
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];//Execute a fetch request on the context and record any errors
    double distanceRanOnDate = 0.0f;
    for (id obj in fetchedObjects)
    {
        Run *run = (Run *)obj;
        //Make sure dates are not nil
        if (nil != date && nil != run.runStartTime)
        {
            if ([self isSameDayWithDate1:date date2:run.runStartTime])
            {
                distanceRanOnDate += [run.distanceRan doubleValue];
            }
        }
    }
    return distanceRanOnDate;
}

- (void)addCompletedRun:(RunDescription *)run
{
    NSManagedObjectContext *context = [self managedObjectContext];//Get managed context
    Run *runObjectToAdd = [NSEntityDescription insertNewObjectForEntityForName:@"Run" inManagedObjectContext:context];//Create object to be inserted into database.
    /* Assign properties from refernce class. */
    runObjectToAdd.arrayOfRunPoints = run.arrayOfRunPoints;
    runObjectToAdd.distanceRan = [NSNumber numberWithDouble:run.distanceRan];
    runObjectToAdd.runStartTime = run.runStartTime;
    runObjectToAdd.runEndTime = run.runEndTime;
    NSError *error;
    if (![context save:&error])//Attempt to save modified context
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    [self dataUpdated];
}

- (NSArray *)allRunsCompleted
{
    NSManagedObjectContext *context = [self managedObjectContext];//Get managed context
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];//Initialise fetch request object
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Run" inManagedObjectContext:context];//Set the entity Run that is being searched for in the current context.
    [fetchRequest setEntity:entity];//Link entity with request
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];//Execute fetch request on context while collecting errors.
    return fetchedObjects;
}


#pragma mark - BMI

- (void)addBMIResult:(BMIDescription *)bmiResult
{
    NSManagedObjectContext *context = [self managedObjectContext];//Get managed context
    BMI *bmiObjectToAdd = [NSEntityDescription insertNewObjectForEntityForName:@"BMI" inManagedObjectContext:context];//Create object to be inserted into database.
    /* Assign properties from refernce class. */
    bmiObjectToAdd.bmiResult = bmiResult.bmiResult;
    bmiObjectToAdd.date = bmiResult.date;
    bmiObjectToAdd.height = bmiResult.height;
    bmiObjectToAdd.weight = bmiResult.height;
    NSError *error;
    if (![context save:&error])//Attempt to save modified context
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    [self dataUpdated];
}

- (NSArray *)allBMIResults
{
    NSManagedObjectContext *context = [self managedObjectContext];//Get managed context
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];//Initialise fetch request object
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BMI" inManagedObjectContext:context];//Set the entity BMI that is being searched for in the current context.
    [fetchRequest setEntity:entity];//Link entity with request
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];//Execute fetch request on context while collecting errors.
    return fetchedObjects;
}

- (double)bmiCount
{
    //http://www.whathealth.com/bmi/formula.html
    if ([[HealthTracker sharedHealthTracker]isMetricSystem])
    {
        /*
        METRIC
        BMI( kg/m² ) =  weight in kilograms
                            ————————————
                          height in meters²
        */
        double weight = [self retrieveWeight];//Gets current users weight from user defaults
        double height = [self retrieveHeight];//Gets current users height from user defaults
        return weight/(height/100*height/100);//need to devide by 100 to get meters
    }
    else
    {
        /*
         Imperial
         BMI ( lbs/inches² )   =  (weight in pounds * 703 )
                                        ————————————
                                      height in inches²
         */
        double weight = [self retrieveWeight];//Gets current users weight from user defaults
        double height = [self retrieveHeight];//Gets current users height from user defaults
        return (weight*703)/(height*height);
    }
}

/*
    These functions save small user details to nsuserdefaults, they syncronise to make sure that it has been save correctly to the device.
 */
- (void)updateWeight:(double)newWeight
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setDouble:newWeight forKey:@"userWeight"];
    [userDefaults synchronize];
    [self dataUpdated];
}

- (double)retrieveWeight
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults doubleForKey:@"userWeight"];
}

- (void)updateHeight:(double)newHeight
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setDouble:newHeight forKey:@"userHeight"];
    [userDefaults synchronize];
    [self dataUpdated];
}

- (double)retrieveHeight
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults doubleForKey:@"userHeight"];
}


@end
