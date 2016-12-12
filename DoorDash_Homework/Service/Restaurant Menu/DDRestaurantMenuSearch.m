//
//  DDRestaurantMenu.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDRestaurantMenuSearch.h"

#import "DDConstants.h"
#import "DDAPIClient.h"
#import "DDRestaurantMenu.h"
#import "DDRestaurantMenuMapper.h"

static NSString * const kDDErrorDomain = @"com.doordash.homework.restaurant.menu";

@interface DDRestaurantMenuSearch ()

@property (nonatomic, copy) dispatch_queue_t workQueue;
@property (nonatomic, strong) DDAPIClient *apiClient;

@end

@implementation DDRestaurantMenuSearch

- (instancetype)init {
    self = [super init];
    if (self) {
        _workQueue = dispatch_queue_create("com.doordash.homework.restaurant.menu.queue", DISPATCH_QUEUE_SERIAL);
        _apiClient = [[DDAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kDDBaseURL]];
    }
    
    return self;
}

- (void)findRestaurantMenuForRestaurantWithID:(NSInteger)restaurantID
                                      success:(DDRestaurantMenuSearchSuccess)success
                                      failure:(DDrestaurantMenuSearchFailure)failure {
    if ([[AFNetworkReachabilityManager sharedManager] isReachable]) {
        NSString *url = [NSString stringWithFormat:kDDRestaurantMenuURL, restaurantID];
        
        __weak typeof (self) weakSelf = self;
        __strong typeof (self) strongWeakSelf = weakSelf;
        dispatch_async(self.workQueue, ^{
            [strongWeakSelf.apiClient
             GET:url
             parameters:nil
             progress:nil
             success:^(NSURLSessionTask *task, id responseObject) {
                 [strongWeakSelf handleSuccessResponse:responseObject
                                           withSuccess:success
                                               failure:failure];
             }
             failure:^(NSURLSessionTask *operation, NSError *error) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     if (failure != nil) {
                         failure(error);
                     }
                 });
             }];
        });
    } else  {
        NSLog(@"Error: No network");
        
        if (failure != nil) {
            NSDictionary *errorDescription = @{
                                               kDDErrorDescriptionKey : kDDNoNetworkErrorDescription
                                               };
            NSError *error = [NSError errorWithDomain:kDDErrorDomain
                                                 code:kDDNoNetworkErrorCode
                                             userInfo:errorDescription];
            if (failure != nil) {
                failure(error);
            }
        }
    }
}

- (void)handleSuccessResponse:(id)responseObject
                  withSuccess:(DDRestaurantMenuSearchSuccess)success
                      failure:(DDrestaurantMenuSearchFailure)failure {
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        DDRestaurantMenu *menu = [DDRestaurantMenuMapper restaurantMenuFromData:responseObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success != nil) {
                success(@[menu]);
            }
        });
    } else if ([responseObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *restaurantMenus = [NSMutableArray arrayWithCapacity:[responseObject count]];
        
        for (NSDictionary *data in responseObject) {
            DDRestaurantMenu *menu = [DDRestaurantMenuMapper restaurantMenuFromData:data];
            if (menu) {
                [restaurantMenus addObject:menu];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success != nil) {
                success(restaurantMenus);
            }
        });
    } else {
        NSLog(@"ERROR: Invalid response from server");
        NSDictionary *errorDescription = @{
                                           kDDErrorDescriptionKey : kDDInvalidDataErrorDescription
                                           };
        NSError *error = [NSError errorWithDomain:kDDErrorDomain
                                             code:kDDInvalidDataErrorCode
                                         userInfo:errorDescription];
        if (failure != nil) {
            failure(error);
        }
    }
}


@end
