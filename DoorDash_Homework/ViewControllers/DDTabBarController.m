//
//  DDTabBarController.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/11/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDTabBarController.h"

#import "DDChooseAddressViewController.h"
#import "DDExploreTableViewController.h"

@interface DDTabBarController () <DDChooseAddressViewControllerProtocol, DDExploreTableViewControllerProtocol>

@property (nonatomic, assign) BOOL isLaunchingFirstTime;

@end

@implementation DDTabBarController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _isLaunchingFirstTime = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTabBarViewControllers];
}

- (void)setUpTabBarViewControllers {
    for (UINavigationController *navigationController in self.viewControllers) {
        DDExploreTableViewController *viewController = [[navigationController viewControllers] firstObject];
        viewController.delegate = self;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.isLaunchingFirstTime) {
        self.isLaunchingFirstTime = NO;
        
        [self showChooseAddressViewController];
    }
}

- (void)showChooseAddressViewController {
    DDChooseAddressViewController *chooseAddressViewController = [[DDChooseAddressViewController alloc] initWithNibName:NSStringFromClass([DDChooseAddressViewController class])
                                                                                                                 bundle:[NSBundle mainBundle]];
    chooseAddressViewController.delegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:chooseAddressViewController];
    [self presentViewController:navigationController
                       animated:YES
                     completion:nil];
}

#pragma mark - DDChooseAddressViewControllerProtocol conformance
- (void)didTapConfirmAddressButtonForAddress:(CLLocationCoordinate2D)address {
    UINavigationController *navigationController = self.viewControllers[0];
    [navigationController popToRootViewControllerAnimated:NO];
    DDExploreTableViewController *exploreTableViewController = [[navigationController viewControllers] firstObject]; //embedded inside a navigation controller
    [exploreTableViewController updateControllerForLatitude:address.latitude
                                                  longitude:address.longitude];
    
    [self setSelectedIndex:0];
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

#pragma mark - DDExploreTableViewControllerProtocol conformance
- (void)didTapShowMaputton {
    [self showChooseAddressViewController];
}

- (void)didTapSearchButton {
    
}

@end
