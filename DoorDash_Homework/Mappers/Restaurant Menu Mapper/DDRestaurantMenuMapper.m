//
//  DDRestaurantMenuMapper.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDRestaurantMenuMapper.h"

#import "DDConstants.h"
#import "DDRestaurantMenu.h"
#import "DDRestaurantMenuCategory.h"
#import "DDRestaurantMenuCategoryMapper.h"

@interface DDRestaurantMenuMapper ()

@end

@implementation DDRestaurantMenuMapper

+ (DDRestaurantMenu * _Nonnull)restaurantMenuFromData:(NSDictionary * _Nonnull)data {
    if (data == nil) {
        NSLog(@"ERROR: Incoming data is nil, cannot create a DDRestaurant.");
        return nil;
    }
    
    NSInteger menuID = [self geMenuIDFromData:data];
    NSString *menuName = [self geMenuNameFromData:data];
    NSArray *menuCategories = [self getMenuCategoriesFromData:data];
    
    DDRestaurantMenu *menu = [[DDRestaurantMenu alloc] initWithMenuID:menuID
                                                             menuName:menuName
                                                       menuCategories:menuCategories];
    
    return menu;
}

+ (NSInteger)geMenuIDFromData:(NSDictionary * _Nonnull)data {
    NSNumber *menuID = [data objectForKey:kRestaurantMenuIDKey];
    
    if ([menuID integerValue] <= 0) {
        //Using NSLog here, but we'd use some sort of Logger class in prod
        NSLog(@"WARNING: Menu ID is invalid");
        return kInvalidRestaurantMenuID;
    }
    
    return [menuID integerValue];
}


+ (NSString *)geMenuNameFromData:(NSDictionary * _Nonnull)data {
    NSString *menuName = [data objectForKey:kRestaurantMenuNameKey];
    
    if (menuName.length <= 0) {
        //Using NSLog here, but we'd use some sort of Logger class in prod
        NSLog(@"WARNING: Menu Name is invalid");
    }
    
    return menuName;
}

+ (NSArray *)getMenuCategoriesFromData:(NSDictionary * _Nonnull)data {
    NSMutableArray *menuCategories = [NSMutableArray array];
    
    for (NSDictionary *category in [data objectForKey:kRestaurantMenuCategoriesKey]) {
        DDRestaurantMenuCategory *menuCategory = [DDRestaurantMenuCategoryMapper restaurantMenuCategoryFromData:category];
        
        [menuCategories addObject:menuCategory];
    }
    
    return menuCategories;
}

@end
