//
//  DDRestaurantMenuMapper.h
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DDRestaurantMenu;

@interface DDRestaurantMenuMapper : NSObject

/**
 This class takes in a NSDictionary of JSON data and creates an instance of DDRestaurantMenu class from that data.
 @param data from which an instance of DDRestaurantMenu is created.
 @returns An instance of DDRestaurantMenu.
 */
+ (DDRestaurantMenu * _Nonnull)restaurantMenuFromData:(NSDictionary * _Nonnull)data;

@end
