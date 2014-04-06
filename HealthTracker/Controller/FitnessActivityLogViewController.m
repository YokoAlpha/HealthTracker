//
//  FitnessActivityLogViewController.m
//  HealthTracker
//
//  Created by Yoko Alpha on 13/01/2014.
//  Copyright (c) 2014 Yoko. All rights reserved.
//

#import "FitnessActivityLogViewController.h"
#import "RunDescription.h"
#import "HealthTracker.h"

#import <CoreLocation/CoreLocation.h>
#import <MobileCoreServices/UTCoreTypes.h>

#define kRequiredAccuracy 500.0 //meters
#define kMaxAge 10.0 //seconds
#define M_PI   3.14159265358979323846264338327950288   /* pi */


@interface FitnessActivityLogViewController ()
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) RunDescription *runInProgress;
@end

@implementation FitnessActivityLogViewController

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
    self.statsContainer.backgroundColor = [UIColor colorWithRed:0 green:.62 blue:.984 alpha:0.3];
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    [self configureRoutes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButtonPressed:(id)sender
{
    /* Once start button pressed
        * Need to calculate distance covered (Maybe it needs to be put on screen).
        * Record start date
        * Start recording points (map view uses it).
     */
    [self startRun];
    self.runInProgress = [[RunDescription alloc]init];
    self.runInProgress.runStartTime = [NSDate date];//Started run using current time and date.
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                  target:self
                                                selector:@selector(showTime)
                                                userInfo:nil
                                                 repeats:YES];
    [self buttonStatesWithStartState:NO stopState:YES resetState:NO];
}


- (void)startRun
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
    [self.locationManager startUpdatingLocation];
    [self resetButtonPressed:nil];//Reset all on screen stuff
    [self configureRoutes];//Setup routes again
    //Zoom into map
    CLLocationCoordinate2D ground = _currentLocation.coordinate;
    ground.latitude = ground.latitude;//Move to left
    CLLocationCoordinate2D eye = CLLocationCoordinate2DMake(ground.latitude, ground.longitude);
    MKMapCamera *mapCamera = [MKMapCamera cameraLookingAtCenterCoordinate:ground
                                                        fromEyeCoordinate:eye
                                                              eyeAltitude:300];
    mapCamera.pitch = 30;
    mapCamera.heading = 90;
    [self.mapView selectAnnotation:[[self.mapView annotations] firstObject] animated:YES];
    [UIView animateWithDuration:6 animations:^{
        self.mapView.camera = mapCamera;
    }];
    //Start measuring distance
}

- (IBAction)stopButtonPressed:(id)sender
{
    self.runInProgress.runEndTime = [NSDate date];//Ended run using current time and date.
    [self.timer invalidate];
    self.timer = nil;
    [self buttonStatesWithStartState:YES stopState:NO resetState:YES];
}

- (IBAction)resetButtonPressed:(id)sender
{
    //Reset map drawing
    _points = nil;
    _runRouteLine = nil;
    _runRouteLineView = nil;
    self.runInProgress = nil;
    self.hoursLabel.text = @"0";
    self.minutesLabel.text = @"0";
    self.secondsLabel.text = @"0";
    self.hundredsOfSecondsLabel.text = @"0";
    [self buttonStatesWithStartState:YES stopState:NO resetState:NO];
    //Reset distance
    self.distanceCovered.text = @"0";
    [self.distanceTimer invalidate];
    self.distanceTimer = nil;
    self.speed = nil;
    self.currentSpeed = nil;
    self.distanceTravelled = 0;
}

- (void)showTime
{
    int hours = 0;
    int minutes = 0;
    int seconds = 0;
    int hundredths = 0;
    NSArray *timeArray = [NSArray arrayWithObjects:self.hundredsOfSecondsLabel.text, self.secondsLabel.text, self.minutesLabel.text, self.hoursLabel.text, nil];
    int startCount = [timeArray count] - 1;
    for (startCount; startCount >= 0;startCount--)
    {
        int timeComponent = [[timeArray objectAtIndex:startCount] intValue];
        switch (startCount)
        {
            case 3:
                hours = timeComponent;
                break;
            case 2:
                minutes = timeComponent;
                break;
            case 1:
                seconds = timeComponent;
                break;
            case 0:
                hundredths = timeComponent;
                hundredths++;
                break;
                
            default:
                break;
        }
    }
    if (hundredths == 100)
    {
        seconds++;
        hundredths = 0;
    }
    else if (seconds == 60)
    {
        minutes++;
        seconds = 0;
    }
    else if (minutes == 60)
    {
        hours++;
        minutes = 0;
    }
    self.hoursLabel.text = [NSString stringWithFormat:@"%.0d", hours];
    self.minutesLabel.text = [NSString stringWithFormat:@"%.2d", minutes];
    self.secondsLabel.text = [NSString stringWithFormat:@"%.2d", seconds];
    self.hundredsOfSecondsLabel.text = [NSString stringWithFormat:@"%.2d", hundredths];
    
}

- (void)buttonStatesWithStartState:(BOOL)startState
                         stopState:(BOOL)stopState
                        resetState:(BOOL)resetState
{
    self.startButton.enabled = startState;
    self.stopButton.enabled = stopState;
    self.resetButton.enabled = resetState;
    self.startButton.alpha = self.stopButton.alpha = self.resetButton.alpha = 0.5;
    if(YES == startState)
    {
        self.startButton.alpha = 1;
    }
    if(YES == stopState)
    {
        self.stopButton.alpha = 1;
    }
    if(YES == resetState)
    {
        self.resetButton.alpha = 1;
    }
}

- (IBAction)saveRun:(id)sender
{
    /*
     Test data
        RunDescription *rundescriptionToAdd = [[RunDescription alloc]init];
        rundescriptionToAdd.arrayOfRunPoints = [[NSMutableArray alloc]initWithObjects:@(1.5),@(3.6), nil];
        rundescriptionToAdd.distanceRan = 4.55;
        rundescriptionToAdd.runStartTime = [NSDate date];
        rundescriptionToAdd.runEndTime = [[NSDate date]dateByAddingTimeInterval:3600];
     */
    
    /* Save button pressed
     * Programatically call stop button (only if end date is nil).
     * Dump the description object and save it.
     * Call reset button internally.
     */
    if (nil == self.runInProgress.runEndTime)
    {
        [self stopButtonPressed:nil];//We ned to stop the run if the run hasn't been completed
    }
    self.runInProgress.distanceRan = self.distanceTravelled;
    self.runInProgress.arrayOfRunPoints = [self.points copy];//Make sure the array of points is added for future use.
    [[HealthTracker sharedHealthTracker] addCompletedRun: self.runInProgress];
    [self resetButtonPressed:nil];
}

#pragma mark
#pragma mark Polyline

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
        [self.mapView removeOverlay:_runRouteLine];
    }
    _runRouteLine = [MKPolyline polylineWithPoints:pointArray count:_points.count];
	if (nil != _runRouteLine)
    {
		[self.mapView addOverlay:_runRouteLine];//Route added to map as an MKOverlay
	}
}

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
    [self.mapView setCenterCoordinate:coordinate animated:YES];
}

#pragma mark
#pragma mark Distance covered

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Distance travelled in KM= %f",self.distanceTravelled);
    if(newLocation && oldLocation)
    {
        self.distanceTravelled += [self getDistanceInKm:newLocation fromLocation:oldLocation];
        self.distanceCovered.text = [NSString stringWithFormat:@"%0.1f",self.distanceTravelled];
    }
}

- (void)timeIntervalEnded:(NSTimer*)timer
{
    self.distanceTravelled = 0;
    [self startReadingLocation];
}

- (void)startReadingLocation
{
    [self.locationManager startUpdatingLocation];
}

-(float)getDistanceInKm:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    float lat1,lon1,lat2,lon2;
    
    lat1 = newLocation.coordinate.latitude  * M_PI / 180;
    lon1 = newLocation.coordinate.longitude * M_PI / 180;
    
    lat2 = oldLocation.coordinate.latitude  * M_PI / 180;
    lon2 = oldLocation.coordinate.longitude * M_PI / 180;
    
    float R = 6371;
    float dLat = lat2-lat1;
    float dLon = lon2-lon1;
    
    float a = sin(dLat/2) * sin(dLat/2) + cos(lat1) * cos(lat2) * sin(dLon/2) * sin(dLon/2);
    float c = 2 * atan2(sqrt(a), sqrt(1-a));
    float d = R * c;
    
    NSLog(@"Kms-->%f",d);
    
    return d;
}

-(float)getDistanceInMiles:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    float lat1,lon1,lat2,lon2;
    
    lat1 = newLocation.coordinate.latitude  * M_PI / 180;
    lon1 = newLocation.coordinate.longitude * M_PI / 180;
    
    lat2 = oldLocation.coordinate.latitude  * M_PI / 180;
    lon2 = oldLocation.coordinate.longitude * M_PI / 180;
    
    float R = 3963;
    float dLat = lat2-lat1;
    float dLon = lon2-lon1;
    
    float a = sin(dLat/2) * sin(dLat/2) + cos(lat1) * cos(lat2) * sin(dLon/2) * sin(dLon/2);
    float c = 2 * atan2(sqrt(a), sqrt(1-a));
    float d = R * c;
    
    NSLog(@"Miles-->%f",d);
    
    return d;
}

@end
