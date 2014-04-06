//
//  FitnessActivityLogViewController.h
//  HealthTracker
//
//  Created by Yoko Alpha on 13/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

@import MapKit;
@import CoreLocation;

@interface FitnessActivityLogViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
@property (nonatomic,strong) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) IBOutlet UILabel *hoursLabel;
@property (nonatomic,strong) IBOutlet UILabel *minutesLabel;
@property (nonatomic,strong) IBOutlet UILabel *secondsLabel;
@property (nonatomic,strong) IBOutlet UILabel *hundredsOfSecondsLabel;
@property (nonatomic,strong) IBOutlet UIButton *startButton;
@property (nonatomic,strong) IBOutlet UIButton *stopButton;
@property (nonatomic,strong) IBOutlet UIButton *resetButton;
@property (nonatomic,strong) IBOutlet UIView *statsContainer;
@property (nonatomic,strong) IBOutlet UILabel *distanceCovered;

//Polyline
@property (nonatomic, retain) NSMutableArray * points;
@property (nonatomic, retain) MKPolyline * runRouteLine;
@property (nonatomic, retain) MKPolylineView * runRouteLineView;
@property (nonatomic, retain) CLLocationManager * locationManager;
@property (nonatomic) MKMapRect runRouteRect;
@property (nonatomic, retain) CLLocation* currentLocation;

//Distance covered
@property (nonatomic,weak) NSTimer *distanceTimer;
@property (nonatomic) CLLocationSpeed *speed;
@property (nonatomic) CLLocationSpeed *currentSpeed;
@property (nonatomic) CLLocationSpeed distanceTravelled;

-(float)getDistanceInKm:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;
-(float)getDistanceInMiles:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;


-(void) configureRoutes;

@end
