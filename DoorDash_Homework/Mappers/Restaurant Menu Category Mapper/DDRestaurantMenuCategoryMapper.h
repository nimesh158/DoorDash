//
//  DDRestaurantMenuCategoryMapper.h
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DDRestaurantMenuCategory;

@interface DDRestaurantMenuCategoryMapper : NSObject

/**
 This class takes in a NSDictionary of JSON data and creates an instance of DDRestaurantMenuCategory class from that data.
 @param data from which an instance of DDRestaurantMenuCategory is created.
 @returns An instance of DDRestaurantMenuCategory.
 */
+ (DDRestaurantMenuCategory * _Nonnull)restaurantMenuCategoryFromData:(NSDictionary * _Nonnull)data;

@end
