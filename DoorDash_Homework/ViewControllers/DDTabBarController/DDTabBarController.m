//
//  DDTabBarController.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/11/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDTabBarController.h"

#import "DDTabBar.h"
#import "DDChosoeAddressViewController.h"

@interface DDTabBarController ()

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet DDTabBar *tabBar;
@property (nonatomic, assign) BOOL isFirstLaunch;

@end

@implementation DDTabBarController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        _isFirstLaunch = YES;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _isFirstLaunch = YES;
//        [[[UINib nibWithNibName:NSStringFromClass([DDTabBar class]) bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTabBar];
    
    [self checkAndPerformFirstLaunch];
}

#pragma mark - SetUp Tab Bar
- (void)setUpTabBar {
    [self.tabBar setBackgroundColor:[UIColor redColor]];
    
    [self.tabBar setLeftTabItemImage:[UIImage imageNamed:@"tab-explore"]];
    [self.tabBar setRightTabItemImage:[UIImage imageNamed:@"tab-star"]];
    
    __weak typeof(self)weakSelf = self;
    __strong typeof(weakSelf) strongWeakSelf = weakSelf;
    
    [self.tabBar
     setLeftItemTappedListener:^{
         [strongWeakSelf leftTabTapped];
    }
     rightItemListener:^{
         [strongWeakSelf rightTabTapped];
     }];
}

- (void)leftTabTapped {
    
}

- (void)rightTabTapped {
    
}

- (void)checkAndPerformFirstLaunch {
    if (self.isFirstLaunch) {
        self.isFirstLaunch = NO;
        DDChosoeAddressViewController *chooseAddressViewController = [[DDChosoeAddressViewController alloc] initWithNibName:NSStringFromClass([DDChosoeAddressViewController class])
                                                                                                                     bundle:[self nibBundle]];
//        [self presentViewController:chooseAddressViewController
//                           animated:YES
//                         completion:^{
//                             
//                         }];
    }
}

@end
