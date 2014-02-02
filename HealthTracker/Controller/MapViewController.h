//
//  MapViewController.h
//  HealthTracker
//
//  Created by Yoko Alpha on 14/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>
@property (nonatomic, strong) IBOutlet MKMapView *mapHealthTracker;

@end
