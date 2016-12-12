//
//  DDStoreSearch.h
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

typedef void(^DDStoreSearchSuccess)(NSArray * _Nullable);
typedef void(^DDStoreSearchFailure)(NSError * _Nullable);

@interface DDStoreSearch : NSObject

/**
 Retrieves all the stores for the location, via lat, long passed in.
 @param latitude of the location near which restaurants are to be retrieved.
 @param longitude of the location near which restaurants are to be retrieved.
 @param success block on which the stores are delievered to the caller.
 @param failure block on which the failure notification along with the error object is delievered to the caller.
 */
- (void)searchStoresInAreaWithLatitude:(CGFloat)latitude
                             longitude:(CGFloat)longitude
                               success:(DDStoreSearchSuccess _Nonnull)success
                               failure:(DDStoreSearchFailure _Nonnull)failure;

@end
