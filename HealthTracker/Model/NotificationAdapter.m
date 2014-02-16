//
//  NotificationAdapter.m
//  HealthTracker
//
//  Created by Yoko Alpha on 16/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "NotificationAdapter.h"

@implementation NotificationAdapter

+ (void)updateLocalNotificationsWithUser:(User *)user
{
    //Clear all
    [[UIApplication sharedApplication] cancelAllLocalNotifications];//Cancels all existing local notifications.
    UILocalNotification* n1 = [[UILocalNotification alloc] init];
    n1.fireDate = [NSDate dateWithTimeIntervalSinceNow: 60];
    n1.alertBody = @"one";
    UILocalNotification* n2 = [[UILocalNotification alloc] init];
    n2.fireDate = [NSDate dateWithTimeIntervalSinceNow: 90];
    n2.alertBody = @"two";
    [[UIApplication sharedApplication] scheduleLocalNotification: n1];
    [[UIApplication sharedApplication] presentLocalNotificationNow: n2];
}

@end
