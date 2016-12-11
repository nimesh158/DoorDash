//
//  DDRestaurantMenu.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDRestaurantMenu.h"

@interface DDRestaurantMenu ()

@property (nonatomic, assign, readwrite) NSInteger menuID;
@property (nonatomic, copy, readwrite, nullable) NSString *menuName;
@property (nonatomic, strong, readwrite, nullable) NSArray *menuCategories;

@end

@implementation DDRestaurantMenu

- (instancetype _Nonnull)initWithMenuID:(NSInteger)menuID
                               menuName:(NSString *)menuName
                         menuCategories:(NSArray *)menuCategories {
    self = [super init];
    if (self) {
        _menuID = menuID;
        _menuName = menuName;
        _menuCategories = menuCategories;
    }
    
    return self;
}

@end
