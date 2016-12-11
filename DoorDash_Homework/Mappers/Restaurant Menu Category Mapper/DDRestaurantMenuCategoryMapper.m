//
//  DDRestaurantMenuCategoryMapper.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDRestaurantMenuCategoryMapper.h"

#import "DDConstants.h"
#import "DDRestaurantMenuCategory.h"

@implementation DDRestaurantMenuCategoryMapper

+ (DDRestaurantMenuCategory *)restaurantMenuCategoryFromData:(NSDictionary *)data {
    if (data == nil) {
        NSLog(@"ERROR: Incoming data is nil, cannot create a DDRestaurantMenuCategory.");
        return nil;
    }
    
    NSString *categoryTitle = [self getRestaurantCategoryTitleFromData:data];
    
    DDRestaurantMenuCategory *menuCategory = [[DDRestaurantMenuCategory alloc] initWithCategoryTitle:categoryTitle];
    
    return menuCategory;
}

+ (NSString *)getRestaurantCategoryTitleFromData:(NSDictionary *)data {
    NSString *title = [data objectForKey:kRestaurantMenuTitleKey];
    
    if (title.length <= 0) {
        NSLog(@"WARNING: Menu category title is invalid");
    }
    
    return title;
}

@end
