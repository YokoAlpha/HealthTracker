//
//  HealthTrackerAppDelegate.m
//  HealthTracker
//
//  Created by Yoko Alpha on 13/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "HealthTrackerAppDelegate.h"
#import "SetupViewController.h"

@implementation HealthTrackerAppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [HealthTracker sharedHealthTracker].managedObjectContext = self.managedObjectContext;//Must ensure that reference has been kept to core data database.
    //Handle Local notification
    if([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    UILocalNotification *locationNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];// Handle launching from a notification
    if (locationNotification)
    {
        // Set icon badge number to zero
        application.applicationIconBadgeNumber = 0;
    }
    return YES;
}
					
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    application.applicationIconBadgeNumber = 0;//Reset when opened
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Local notifications

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification
{
    //Handle notifications that are recieved when the app is opened.
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive)//Check the app is open
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reminder"
                                                        message:notification.alertBody
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];//Create alert with notification payload
        [alert show];
    }
    // Set icon badge number to zero
    application.applicationIconBadgeNumber = 0;
}

#pragma mark - Core Data

//Explicitly write Core Data accessors
- (NSManagedObjectContext *)managedObjectContext
{
    if (managedObjectContext != nil)//Check we have a managed context
    {
        return managedObjectContext;//We do so dont bother creating one
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];//Create a persistent mediator to manage writing to iPhone file system
    if (coordinator != nil)
    {
        managedObjectContext = [[NSManagedObjectContext alloc] init];//Create new managed context
        [managedObjectContext setPersistentStoreCoordinator: coordinator];//Assign the coordiantor
    }
    return managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (managedObjectModel != nil)
    {
        return managedObjectModel;//Return existing managed model
    }
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];//Create a new model
    return managedObjectModel;//Return new model
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (persistentStoreCoordinator != nil)
    {
        return persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent: @"HealthTrackerDatabaseModel.sqlite"]];//Create url path to sqlite database
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                  initWithManagedObjectModel:[self managedObjectModel]];//Initialise with model
    if(![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                 configuration:nil URL:storeUrl options:nil error:&error])
    {
        /*Error for store creation should be handled in here*/
        NSLog(@"Persistent Store Coordinator error = %@",error);
    }
    
    return persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];//Get the current application file path
}

@end
