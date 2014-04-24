//
//  NotificationAdapter.m
//  HealthTracker
//
//  Created by Yoko Alpha on 16/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "NotificationAdapter.h"
//Defines used for easy changing of messages without havign to look through code
#define OPEN_BUTTON_NAME @"Open"
#define BREAKFAST_REMINDER @"Enter food consumed for Breakfast"
#define LUNCH_REMINDER @"Enter food consumed for Lunch"
#define DINNER_REMINDER @"Enter food consumed for Dinner"
#define BMI_REMINDER @"Enter BMI result"

@implementation NotificationAdapter

+ (void)updateLocalNotificationsWithUser:(UserDescription *)user
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];//Cancels all existing local notifications.
    [self scheduleDailyNotificationForDate:user.breakfastReminder withBody:BREAKFAST_REMINDER withRepeatCalendarUnit:NSCalendarUnitDay];//Schedules a breakfast reminder
    [self scheduleDailyNotificationForDate:user.lunchReminder withBody:LUNCH_REMINDER withRepeatCalendarUnit:NSCalendarUnitDay];//Schedules a lunchtime reminder
    [self scheduleDailyNotificationForDate:user.dinnerReminder withBody:DINNER_REMINDER withRepeatCalendarUnit:NSCalendarUnitDay];//Schedules a dinner reminder
    /* Weekly reminder */
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    int weekday = 0;
    //Apple weekday starts from Saturday (0) array positions start from 0
    if (0 == user.dayForBMICheck)// Monday
    {
        weekday = 2;
    }
    if (1 == user.dayForBMICheck)// Tuesday
    {
        weekday = 3;
    }
    if (2 == user.dayForBMICheck)// Wednesday
    {
        weekday = 4;
    }
    if (3 == user.dayForBMICheck)// Thursday
    {
        weekday = 5;
    }
    if (4 == user.dayForBMICheck)// Friday
    {
        weekday = 6;
    }
    if (5 == user.dayForBMICheck)// Saturday
    {
        weekday = 7;
    }
    if (6 == user.dayForBMICheck)// Sunday
    {
        weekday = 1;
    }
    //Sets up a dummy date object so we can just use the weekday
    [comps setDay:1];
    [comps setWeekday:weekday];
    [comps setMonth:2];
    [comps setYear:2014];
    [comps setHour:9];
    [comps setMinute:00];
    [comps setSecond:00];
    NSDate *bmiCheckDate = [[NSCalendar currentCalendar] dateFromComponents:comps];//Creates date from the above componenets
    [self scheduleDailyNotificationForDate:bmiCheckDate withBody:BMI_REMINDER withRepeatCalendarUnit:NSWeekCalendarUnit];//Schedule a bmi notication.
}

+ (void)scheduleDailyNotificationForDate:(NSDate *)date
                                withBody:(NSString *)body
                  withRepeatCalendarUnit:(NSCalendarUnit)repeatUnit;
{
    //Function generalised so code was not repeated which is good Object Oriented design.
    UILocalNotification  *notification = [[UILocalNotification alloc]init];//Create local notification object
    notification.fireDate = date;//create date for the notication
    notification.alertBody = body;//Uses the passed body message
    notification.alertAction = OPEN_BUTTON_NAME;//Use the default open name
    notification.soundName = UILocalNotificationDefaultSoundName;//Default sound
    notification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;//Increment application badge count
    notification.repeatInterval = NSDayCalendarUnit;//Set how many times this nofication should be repeated
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];//Schedules the notification on the device
}

@end
