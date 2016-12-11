//
//  DDChooseAddressViewController.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/11/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDChooseAddressViewController.h"

@interface DDChooseAddressViewController () <MKMapViewDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UIButton *confirmAddressButton;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGestureRecognizer;
@property (nonatomic, assign) CLLocationCoordinate2D currentlySelectedLocation;

@end

@implementation DDChooseAddressViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Choose an Address";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpMapView];
}

- (void)setUpMapView {
    self.mapView.delegate = self;
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(longPressedOnMap:)];
    self.longPressGestureRecognizer.minimumPressDuration = 0.5;
    [self.mapView addGestureRecognizer:self.longPressGestureRecognizer];
}

- (void)longPressedOnMap:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.longPressGestureRecognizer) {
        CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
        self.currentlySelectedLocation = [self.mapView convertPoint:touchPoint
                                               toCoordinateFromView:self.mapView];
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = self.currentlySelectedLocation;
        for (id annotation in self.mapView.annotations) {
            [self.mapView removeAnnotation:annotation];
        }
        [self.mapView addAnnotation:point];
        
        [self convertCLCoordinateLocationIntoAddress:self.currentlySelectedLocation];
    }
}

- (void)convertCLCoordinateLocationIntoAddress:(CLLocationCoordinate2D)coordinate {
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location
                        completionHandler: ^(NSArray *placemarks, NSError *error) {
                            if (placemarks.count > 0) {
                                CLPlacemark *placemark = placemarks[0];
                                [self.addressLabel setText:placemark.name];
                            }
                        }];
}

#pragma mark - MKMapViewDelegate Conformation

- (IBAction)confirmAddressButtonTapped:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didTapConfirmAddressButtonForAddress:)]) {
        [self.delegate didTapConfirmAddressButtonForAddress:self.currentlySelectedLocation];
    }
}

@end
