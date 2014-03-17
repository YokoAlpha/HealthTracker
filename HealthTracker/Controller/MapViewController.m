//
//  MapViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 14/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

#pragma mark
#pragma mark View Controller Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Setup MapView
    self.mapHealthTracker.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    //As many properties as possible set in storyboard
    [self configureRoutes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark
#pragma mark Map View

- (void)configureRoutes
{
	MKMapPoint northEastPoint = MKMapPointMake(0.f, 0.f);
	MKMapPoint southWestPoint = MKMapPointMake(0.f, 0.f);
    //Convert points into points 2 dimensional array
	MKMapPoint* pointArray = malloc(sizeof(CLLocationCoordinate2D) * _points.count);
    for(int index = 0; index < _points.count; index++)
	{
        CLLocation *location = [_points objectAtIndex:index];
        CLLocationDegrees latitude  = location.coordinate.latitude;
		CLLocationDegrees longitude = location.coordinate.longitude;
		// Core location created with Lat Long
		CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
		MKMapPoint point = MKMapPointForCoordinate(coordinate);
		if (index == 0)//First point used if no others exist
        {
			northEastPoint = point;
			southWestPoint = point;
		}
        else
        {
			if (point.x > northEastPoint.x)
            {
                northEastPoint.x = point.x;
            }
			if(point.y > northEastPoint.y)
            {
				northEastPoint.y = point.y;
            }
			if (point.x < southWestPoint.x)
            {
				southWestPoint.x = point.x;
            }
			if (point.y < southWestPoint.y)
            {
				southWestPoint.y = point.y;
            }
		}
		pointArray[index] = point;
	}
    if (_runRouteLine)
    {
        [self.mapHealthTracker removeOverlay:_runRouteLine];
    }
    _runRouteLine = [MKPolyline polylineWithPoints:pointArray count:_points.count];
	if (nil != _runRouteLine)
    {
		[self.mapHealthTracker addOverlay:_runRouteLine];//Route added to map as an MKOverlay
	}
//	free(pointArray);//Points C array cleared in memory.
}

/*
 #pragma mark
 #pragma mark Location Manager
 
 - (void)configureLocationManager
 {
 // Create the location manager if this object does not already have one.
 if (nil == _locationManager)
 _locationManager = [[CLLocationManager alloc] init];
 
 _locationManager.delegate = self;
 _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
 _locationManager.distanceFilter = 50;
 [_locationManager startUpdatingLocation];
 // [_locationManager startMonitoringSignificantLocationChanges];
 }
 */

#pragma mark
#pragma mark MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView
didAddOverlayViews:(NSArray *)overlayViews
{
}

- (void)mapView:(MKMapView *)mapView
didAddAnnotationViews:(NSArray *)views
{
}

- (MKOverlayView *)mapView:(MKMapView *)mapView
            viewForOverlay:(id <MKOverlay>)overlay
{
	MKOverlayView* overlayView = nil;
	if(overlay == _runRouteLine)
	{
        if (_runRouteLineView)
        {
            [_runRouteLineView removeFromSuperview];
        }
        _runRouteLineView = [[MKPolylineView alloc] initWithPolyline:_runRouteLine];
         _runRouteLineView.fillColor = [UIColor redColor];
        _runRouteLineView.strokeColor = [UIColor redColor];
         _runRouteLineView.lineWidth = 10;
		overlayView =  _runRouteLineView;
	}
	return overlayView;
}

- (void)mapView:(MKMapView *)mapView
didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude
                                                      longitude:userLocation.coordinate.longitude];
    if  (userLocation.coordinate.latitude == 0.0f ||
         userLocation.coordinate.longitude == 0.0f)
    {
        return;//Exit if 0 Value
    }
    //Watch for runner changing location (we need to be careful how much the runner is moving)
    if (_points.count > 0)
    {
        CLLocationDistance distance = [location distanceFromLocation:_currentLocation];
        if (distance < 5)
        {
            return;
        }
    }
    if (nil == _points)
    {
        _points = [[NSMutableArray alloc] init];
    }
    [_points addObject:location];
    _currentLocation = location;
    [self configureRoutes];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    [self.mapHealthTracker setCenterCoordinate:coordinate animated:YES];
}


@end
