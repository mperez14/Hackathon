//
//  ViewController.m
//  Hackathon
//
//  Created by Matthew Perez on 9/26/14.
//  Copyright (c) 2014 Matthew Perez. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#define METERS_PER_MILE 1609.344

@interface ViewController () <CLLocationManagerDelegate> //data


@end

@implementation ViewController{ CLLocationManager *locationManager;}

//logic
@synthesize mapMain;
@synthesize longitudeLabel;
@synthesize locationManager;
@synthesize latitudeLabel;


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [locations lastObject];
}


-(void)viewDidLoad{
    [super viewDidLoad];
    self.mapMain.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    
    
    [self.locationManager startUpdatingLocation];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.mapMain.showsUserLocation = YES;
    [self.mapMain addAnnotation:[self.mapMain userLocation]];
    
    //Parse
  /*  PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
  */

}

//Normal layout (request location for current location)
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.locationManager requestAlwaysAuthorization];

}



 //Focus on user
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapMain setRegion:[self.mapMain regionThatFits:region] animated:YES];
    
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id )annotation {
    if (annotation==mapView.userLocation)
        return nil;
    return nil;
}




//Show location
- (IBAction)whereAmI:(id)sender {
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
    self.mapMain.showsUserLocation = YES; //tokyo Japan, blue pin with ripple displays on Default Location that I set in XCode = Tokyo, Japan
    
    NSLog(@"using MapView.userLocation, user location = %@", self.mapMain.userLocation.location); //output = null
    NSLog(@"using MapView.userLocation, latitude = %f", self.mapMain.userLocation.location.coordinate.latitude); //output = 0.000000
    NSLog(@"using MapView.userLocation, longitude = %f", self.mapMain.userLocation.location.coordinate.longitude); //output = 0.000000
    
    CLLocationCoordinate2D centerCoord = {self.mapMain.userLocation.location.coordinate.latitude, self.mapMain.userLocation.location.coordinate.longitude};
    [self.mapMain setCenterCoordinate:centerCoord animated:TRUE]; //nothing happens, as latitude and longitude = 0.000000
    
    
    //Change labels to display current longitude and latitude
    self.longitudeLabel.text = [NSString stringWithFormat:@"%.8f", self.mapMain.userLocation.location.coordinate.longitude];
    self.latitudeLabel.text = [NSString stringWithFormat:@"%.8f", self.mapMain.userLocation.location.coordinate.latitude];
    
}

//Drop pin
- (IBAction)pinDrop:(id)sender {
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = [self.mapMain userLocation].coordinate;
    point.title = @"Where am I?";
    point.subtitle = @"I'm here!!!";
    
    [self.mapMain addAnnotation:point];



}
 

@end
