//
//  NotificationAdapter.h
//  HealthTracker
//
//  Created by Yoko Alpha on 16/02/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface NotificationAdapter : NSObject

+ (void)updateLocalNotificationsWithUser:(User *)user;

@end
