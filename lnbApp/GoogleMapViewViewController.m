//
//  GoogleMapViewViewController.m
//  lnbApp
//
//  Created by Yves Benchimol on 02/10/2014.
//  Copyright (c) 2014 Yves Benchimol. All rights reserved.
//

#import "GoogleMapViewViewController.h"
#import "SWRevealViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "utilsLocalisation.h"

@interface GoogleMapViewViewController () <CLLocationManagerDelegate>
@end

@implementation GoogleMapViewViewController{
     GMSMapView *mapView_;
     BOOL firstLocationUpdate_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = NSLocalizedString(@"Map", nil);
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    

    
        //ask for localisation
    
        self.locationManager = [[CLLocationManager alloc] init];
    
        self.locationManager.delegate = self;
    
        // check before requesting, otherwise it might crash in older version
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
    
        [self.locationManager startUpdatingLocation];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
}

- (void)loadView {
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.mapType = kGMSTypeSatellite;
    mapView_.myLocationEnabled = YES;
    NSLog(@"User's location: %@", mapView_.myLocation);
    
    mapView_.settings.myLocationButton = YES;
    
    self.view = mapView_;

    // Listen to the myLocation property of GMSMapView.
//    [mapView_ addObserver:self
//               forKeyPath:@"myLocation"
//                  options:NSKeyValueObservingOptionNew
//                  context:NULL];
//    
//    self.view = mapView_;
//    
//    // Ask for My Location data after the map has already been added to the UI.
//    dispatch_async(dispatch_get_main_queue(), ^{
//        mapView_.myLocationEnabled = YES;
//    });

    

    
}

//- (void)dealloc {
//    [mapView_ removeObserver:self
//                  forKeyPath:@"myLocation"
//                     context:NULL];
//}

//#pragma mark - KVO updates
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//    
//    if (!firstLocationUpdate_) {
//        // If the first location update has not yet been recieved, then jump to that
//        // location.
//        firstLocationUpdate_ = YES;
//        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
//        mapView_.camera = [GMSCameraPosition cameraWithTarget:location.coordinate zoom:14];
//    }
//}


- (void)locationManager:(CLLocationManager *)locationManager didUpdateLocations:(NSArray *)locations
{
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    //View Area
    
    CLLocationCoordinate2D positionUser = self.locationManager.location.coordinate;
    
    mapView_.camera = [GMSCameraPosition cameraWithTarget:positionUser zoom:18];
    [self.locationManager stopUpdatingLocation];
    
    //calcul of the unity in the map
    GMSMapPoint point1 = GMSProject(positionUser);
    GMSMapPoint point2 = GMSProject(positionUser);
    GMSMapPoint point3 = GMSProject(positionUser);
    point2.y = point1.y + 0.000001;
    point3.x = point1.x + 0.000001;
    
    //distance of x
    double distanceMetres1 = getDistanceMetresBetweenLocationCoordinates(positionUser, GMSUnproject(point2));
    
    //distance of y
    double distanceMetres2 = getDistanceMetresBetweenLocationCoordinates(positionUser, GMSUnproject(point3));
    
    double averageUnity = (distanceMetres1 + distanceMetres2)/2.0 * 1000000;
    
    //create 3 points on the map
    GMSMapPoint firstPoint = GMSProject(CLLocationCoordinate2DMake(37.784590, -122.406997));
    GMSMapPoint secondPoint = GMSProject(CLLocationCoordinate2DMake(37.786354, -122.406881));
    GMSMapPoint thirdPoint = GMSProject(positionUser);
    
    //get the position of the ball with the algo
    NSArray *points = [NSArray arrayWithObjects:[NSNumber numberWithDouble:firstPoint.x],[NSNumber numberWithDouble:firstPoint.y],[NSNumber numberWithDouble:secondPoint.x],[NSNumber numberWithDouble:secondPoint.y],[NSNumber numberWithDouble:thirdPoint.x],[NSNumber numberWithDouble:thirdPoint.y], nil];
    NSArray *distances = [NSArray arrayWithObjects:[NSNumber numberWithDouble:147.0/averageUnity],[NSNumber numberWithDouble:70.0/averageUnity],[NSNumber numberWithDouble:1.0/averageUnity], nil];
    
    CGPoint resultPoint = [utilsLocalisation localtionOfBallWithNumberOfPoints:3 withPoints:points withDistances:distances];
    
    // Creates a marker where the ball is
    GMSMarker *marker1 = [[GMSMarker alloc] init];
    marker1.position = GMSUnproject(firstPoint);
    marker1.title = @"Marker 1";
    marker1.snippet = @"2 metres";
    marker1.map = mapView_;
    
    GMSMarker *marker2 = [[GMSMarker alloc] init];
    marker2.position = GMSUnproject(secondPoint);
    marker2.title = @"Marker 3";
    marker2.snippet = @"3 metres";
    marker2.map = mapView_;
    
    GMSMarker *marker3 = [[GMSMarker alloc] init];
    GMSMapPoint ballMapPoint = {resultPoint.x, resultPoint.y};
    CLLocationCoordinate2D resultPosition = GMSUnproject(ballMapPoint);
    marker3.position = CLLocationCoordinate2DMake(resultPosition.latitude, resultPosition.longitude);
    marker3.title = @"Ball";
    marker3.snippet = @"J1";
    marker3.map = mapView_;
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{

}

double getDistanceMetresBetweenLocationCoordinates(CLLocationCoordinate2D coord1, CLLocationCoordinate2D coord2){
    CLLocation* location1 =[[CLLocation alloc] initWithLatitude:coord1.latitude longitude:coord1.longitude];
    CLLocation* location2 =[[CLLocation alloc] initWithLatitude:coord2.latitude longitude: coord2.longitude];
    
    return [location1 distanceFromLocation: location2];
}

- (NSString *)deviceLocation {
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
}
- (NSString *)deviceLat {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
}
- (NSString *)deviceLon {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
}
- (NSString *)deviceAlt {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.altitude];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end

