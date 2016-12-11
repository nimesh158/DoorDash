//
//  DDChosoeAddressViewController.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/11/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDChosoeAddressViewController.h"

#import <MapKit/MapKit.h>

#import "DDHeaderView.h"

@interface DDChosoeAddressViewController () <MKMapViewDelegate>

@property (nonatomic, weak) IBOutlet DDHeaderView *headerView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmAddressButton;

@end

@implementation DDChosoeAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpHeaderView];
    [self setUpConfirmAddressButton];
    [self setUpMapView];
}

- (void)setUpHeaderView {
    [self.headerView setBackgroundColor:[UIColor clearColor]];
    [self.headerView setTitle:@"Choose an Address"];
    [self.headerView setTitleColor:[UIColor colorWithRed:24.0 green:24.0 blue:24.0 alpha:1.0]];
}

- (void)setUpConfirmAddressButton {
    [self.confirmAddressButton setBackgroundColor:[UIColor colorWithRed:255.0 green:26.0 blue:64.0 alpha:1.0]];
    [self.confirmAddressButton setTitleColor:[UIColor whiteColor]
                                    forState:UIControlStateNormal | UIControlStateSelected];
}

- (void)setUpMapView {
    self.mapView.delegate = self;
}

#pragma mark - MKMapViewDelegate Conformation


- (IBAction)confirmAddressButtonTapped:(UIButton *)sender {
    
}

@end
