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

@interface ViewController () <MKMapViewDelegate> //data

@end

@implementation ViewController

//logic
@synthesize mapMain;

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [locations lastObject];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.mapMain.delegate = self;

    
}
/*  Normal layout
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.locationManager requestAlwaysAuthorization];

}
*/

// Zoom on stadium
-(void)viewWillAppear:(BOOL)animated {
    [self.locationManager requestAlwaysAuthorization];
    CLLocationCoordinate2D zoomLocation;  //Zoom in on location
    zoomLocation.latitude = 41.69833;
    zoomLocation.longitude =-86.23389;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    //Limit location to confines of user (.5 miles)
    
    
    [mapMain setRegion:viewRegion animated: YES]; //display region
}



 //Focus on user
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapMain setRegion:[self.mapMain regionThatFits:region] animated:YES];
}



- (void)mapMain:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapMain setRegion:[self.mapMain regionThatFits:region] animated:YES];
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = userLocation.coordinate;
    point.title = @"Where am I?";
    point.subtitle = @"I'm here!!!";
    
    [self.mapMain addAnnotation:point];
}

//Show location
- (IBAction)whereAmI:(id)sender {
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    [self.locationManager startUpdatingLocation];
    
    
    self.mapMain.showsUserLocation = YES;
    self.locationManager = [[CLLocationManager alloc] init];
    [self.mapMain addAnnotation:[self.mapMain userLocation]];
    
}

- (IBAction)pinDrop:(id)sender {
    
}


@end
