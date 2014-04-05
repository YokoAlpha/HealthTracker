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
{
	MKMapView* _mapHealthTracker;
    NSMutableArray* _points;
	MKPolyline* _runRouteLine;
	MKPolylineView* _runRouteLineView;
	MKMapRect _runRouteRect;
    CLLocationManager* _locationManager;
    CLLocation* _currentLocation;
}
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

@property (nonatomic, retain) NSMutableArray * points;
@property (nonatomic, retain) MKPolyline * _runRouteLine;
@property (nonatomic, retain) MKPolylineView * _runRouteLineView;
@property (nonatomic, retain) CLLocationManager * locationManager;
-(void) configureRoutes;

@end
