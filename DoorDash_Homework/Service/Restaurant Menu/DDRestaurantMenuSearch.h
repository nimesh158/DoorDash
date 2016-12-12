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

/**
 Retrieves all the menus for the restaurant with ID passed in.
 @param restaurantID id of the restaurant whose menus are to be retrieved.
 @param success block on which the menus are delievered to the caller.
 @param failure block on which the failure notification along with the error object is delievered to the caller.
 */
- (void)findRestaurantMenuForRestaurantWithID:(NSInteger)restaurantID
                                      success:(DDRestaurantMenuSearchSuccess _Nonnull)success
                                      failure:(DDrestaurantMenuSearchFailure _Nonnull)failure;
@end
