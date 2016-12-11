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

+ (DDRestaurantMenuCategory * _Nonnull)restaurantMenuCategoryFromData:(NSDictionary * _Nonnull)data;

@end
