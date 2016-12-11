//
//  DDRestaurantMenuSearch.h
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DDRestaurantMenuSearchSuccess)(NSArray * _Nullable);
typedef void(^DDrestaurantMenuSearchFailure)(NSError * _Nullable);

@interface DDRestaurantMenuSearch : NSObject

- (void)findRestaurantMenuForRestaurantWithID:(NSInteger)restaurantID
                                      success:(DDRestaurantMenuSearchSuccess _Nonnull)success
                                      failure:(DDrestaurantMenuSearchFailure _Nonnull)failure;
- (void)cancel;

@end
