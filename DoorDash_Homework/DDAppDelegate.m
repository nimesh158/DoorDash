//
//  DDAppDelegate.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDAppDelegate.h"

#import <AFNetworking/AFNetworkReachabilityManager.h>

#import "DDStoreSearch.h"
#import "DDRestaurantMenuSearch.h"
#import "DDTabBarController.h"

@interface DDAppDelegate ()

@property (nonatomic, strong) DDTabBarController *tabBarController;
@property (nonatomic, assign) BOOL isFirstTimeLaunch;

@end

@implementation DDAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:255.0/255.0 green:26.0/255.0 blue:64.0/255.0 alpha:1.0]];
    
    self.tabBarController = (DDTabBarController *)self.window.rootViewController;
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}


@end
