//
//  DDStoreSearch.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDStoreSearch.h"

#import "DDConstants.h"
#import "DDAPIClient.h"
#import "DDStore.h"
#import "DDStoreMapper.h"

static NSString * const kDDErrorDomain = @"com.doordash.homework.store.search";

@interface DDStoreSearch ()

@property (nonatomic, strong) dispatch_queue_t workQueue;
@property (nonatomic, strong) DDAPIClient *apiClient;

@end

@implementation DDStoreSearch

- (instancetype)init {
    self = [super init];
    if (self) {
        _workQueue = dispatch_queue_create("com.doordash.homework.store.search.queue", DISPATCH_QUEUE_SERIAL);
        _apiClient = [[DDAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kDDBaseURL]];
        [_apiClient setCompletionQueue:_workQueue];
    }
    
    return self;
}

- (void)searchStoresInAreaWithLatitude:(CGFloat)latitude
                             longitude:(CGFloat)longitude
                               success:(DDStoreSearchSuccess)success
                               failure:(DDStoreSearchFailure)failure {
    if ([[AFNetworkReachabilityManager sharedManager] isReachable]) {
        NSDictionary *parameters = @{
                                     kDDLatKey : [NSNumber numberWithFloat:latitude],
                                     kDDLongKey : [NSNumber numberWithFloat:longitude]
                                     };
        __weak typeof (self) weakSelf = self;
        __strong typeof (self) strongWeakSelf = weakSelf;
        dispatch_async(self.workQueue, ^{
            [strongWeakSelf.apiClient
             GET:kDDStoreSearchURL
             parameters:parameters
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
                  withSuccess:(DDStoreSearchSuccess)success
                      failure:(DDStoreSearchFailure)failure {
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        DDStore *store = [DDStoreMapper storeFromData:responseObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success != nil) {
                success(@[store]);
            }
        });
    } else if ([responseObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *data = [NSMutableArray arrayWithCapacity:[responseObject count]];
        
        for (NSDictionary *dictionary in responseObject) {
            DDStore *store = [DDStoreMapper storeFromData:dictionary];
            [data addObject:store];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success != nil) {
                success(data);
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
