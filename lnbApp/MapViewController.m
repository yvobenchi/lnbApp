//
//  MapViewController.m
//  lnbApp
//
//  Created by Yves Benchimol on 27/09/2014.
//  Copyright (c) 2014 Yves Benchimol. All rights reserved.
//

#import "MapViewController.h"
#import "SWRevealViewController.h"
#import <GoogleMaps/GoogleMaps.h>


@interface MapViewController ()

@end

@implementation MapViewController{
    GMSMapView *mapView_;
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
    
//    //ask for localisation
//    
//    self.locationManager = [[CLLocationManager alloc] init];
//    
//    self.mapView.delegate = self;
//    self.locationManager.delegate = self;
//    
//    // check before requesting, otherwise it might crash in older version
//    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//        [self.locationManager requestWhenInUseAuthorization];
//    }
//    
//    [self.mapView setShowsUserLocation:YES];
//    [self.mapView setZoomEnabled:YES];
//    [self.mapView setScrollEnabled:YES];
//    self.mapView.mapType = MKMapTypeSatellite;
//    [self.locationManager startUpdatingLocation];
}

-(void) loadView{
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView_;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
}

//- (void)locationManager:(CLLocationManager *)locationManager didUpdateLocations:(NSArray *)locations
//{
//    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    
//    //View Area
//    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
//    region.center.latitude = self.locationManager.location.coordinate.latitude;
//    region.center.longitude = self.locationManager.location.coordinate.longitude;
//    region.span.latitudeDelta = 0.005f;
//    region.span.longitudeDelta = 0.005f;
//    
//    [self.mapView setRegion:region animated:YES];
//    [self.locationManager stopUpdatingLocation];
//    
//}
//
//-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
//    
//}
//
//- (NSString *)deviceLocation {
//    return [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
//}
//- (NSString *)deviceLat {
//    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
//}
//- (NSString *)deviceLon {
//    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
//}
//- (NSString *)deviceAlt {
//    return [NSString stringWithFormat:@"%f", self.locationManager.location.altitude];
//}

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
