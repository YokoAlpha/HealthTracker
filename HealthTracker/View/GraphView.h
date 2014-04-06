//
//  GraphView.h
//  HealthTracker
//
//  Created by Yoko Alpha on 05/04/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BAR_WIDTH 50.0f
#define BAR_SPACEING 50.0f

@interface GraphView : UIView
@property (nonatomic, strong) NSArray *arrayOfResultValues;
@property (nonatomic, strong) NSArray *arrayOfResultLabel;
@property (nonatomic, strong) UIColor *barColor;


@end
