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

+ (DDRestaurantMenu * _Nonnull)restaurantMenuFromData:(NSDictionary * _Nonnull)data;

@end
