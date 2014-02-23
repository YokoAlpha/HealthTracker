//
//  NotificationAdapter.m
//  HealthTracker
//
//  Created by Yoko Alpha on 16/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "NotificationAdapter.h"
#define OPEN_BUTTON_NAME @"Open"
#define BREAKFAST_REMINDER @"Enter food consumed for Breakfast"
#define LUNCH_REMINDER @"Enter food consumed for Lunch"
#define DINNER_REMINDER @"Enter food consumed for Dinner"
#define BMI_REMINDER @"Enter BMI result"

@implementation NotificationAdapter

+ (void)updateLocalNotificationsWithUser:(UserDescription *)user
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];//Cancels all existing local notifications.
    [self scheduleDailyNotificationForDate:user.breakfastReminder withBody:BREAKFAST_REMINDER withRepeatCalendarUnit:NSCalendarUnitDay];
    [self scheduleDailyNotificationForDate:user.lunchReminder withBody:LUNCH_REMINDER withRepeatCalendarUnit:NSCalendarUnitDay];
    [self scheduleDailyNotificationForDate:user.dinnerReminder withBody:DINNER_REMINDER withRepeatCalendarUnit:NSCalendarUnitDay];
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
    [comps setDay:1];
    [comps setWeekday:weekday];
    [comps setMonth:2];
    [comps setYear:2014];
    [comps setHour:9];
    [comps setMinute:00];
    [comps setSecond:00];
    NSDate *bmiCheckDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
    [self scheduleDailyNotificationForDate:bmiCheckDate withBody:BMI_REMINDER withRepeatCalendarUnit:NSWeekCalendarUnit];
}

+ (void)scheduleDailyNotificationForDate:(NSDate *)date
                                withBody:(NSString *)body
                  withRepeatCalendarUnit:(NSCalendarUnit)repeatUnit;
{
    UILocalNotification  *notification = [[UILocalNotification alloc]init];
    notification.fireDate = date;
    notification.alertBody = body;
    notification.alertAction = OPEN_BUTTON_NAME;
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    notification.repeatInterval = NSDayCalendarUnit;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

@end
