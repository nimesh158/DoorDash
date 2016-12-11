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

@interface DDTabBarController () <DDChooseAddressViewControllerProtocol>

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
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.isLaunchingFirstTime) {
        self.isLaunchingFirstTime = NO;
        
        DDChooseAddressViewController *chooseAddressViewController = [[DDChooseAddressViewController alloc] initWithNibName:NSStringFromClass([DDChooseAddressViewController class])
                                                                                                                     bundle:[NSBundle mainBundle]];
        chooseAddressViewController.delegate = self;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:chooseAddressViewController];
        [self presentViewController:navigationController
                           animated:YES
                         completion:nil];
    }
}

#pragma mark - DDChooseAddressViewControllerProtocol Conformation
- (void)didTapConfirmAddressButtonForAddress:(CLLocationCoordinate2D)address {
    DDExploreTableViewController *exploreTableViewController = [[[self.viewControllers firstObject] viewControllers] firstObject]; //embedded inside a navigation controller
    if (exploreTableViewController) {
        [exploreTableViewController updateControllerForLatitude:address.latitude
                                                      longitude:address.longitude];
    }
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

@end
