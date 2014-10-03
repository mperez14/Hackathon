//
//  ViewController.h
//  Hackathon
//
//  Created by Matthew Perez on 9/26/14.
//  Copyright (c) 2014 Matthew Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet MKMapView *mapMain;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
-(IBAction)whereAmI:(id)sender;
@end

