//
//  GoogleMapViewViewController.h
//  lnbApp
//
//  Created by Yves Benchimol on 02/10/2014.
//  Copyright (c) 2014 Yves Benchimol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface GoogleMapViewViewController : UIViewController

@property(nonatomic,retain) CLLocationManager *locationManager;

@end
