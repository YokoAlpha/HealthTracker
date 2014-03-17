//
//  MapViewController.h
//  HealthTracker
//
//  Created by Yoko Alpha on 14/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

@import MapKit;
@import CoreLocation;

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
{
	MKMapView* _mapHealthTracker;
    NSMutableArray* _points;
	MKPolyline* _runRouteLine;
	MKPolylineView* _runRouteLineView;
	MKMapRect _runRouteRect;
    CLLocationManager* _locationManager;
    CLLocation* _currentLocation;
}
@property (nonatomic, strong) IBOutlet MKMapView * mapHealthTracker;
@property (nonatomic, retain) NSMutableArray * points;
@property (nonatomic, retain) MKPolyline * _runRouteLine;
@property (nonatomic, retain) MKPolylineView * _runRouteLineView;
@property (nonatomic, retain) CLLocationManager * locationManager;
-(void) configureRoutes;
@end
