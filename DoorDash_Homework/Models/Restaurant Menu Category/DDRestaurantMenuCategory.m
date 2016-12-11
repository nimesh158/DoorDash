//
//  DDRestaurantMenuCategory.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDRestaurantMenuCategory.h"

@interface DDRestaurantMenuCategory ()

@property (nonatomic, copy, readwrite, nullable) NSString *categoryTitle;

@end

@implementation DDRestaurantMenuCategory

- (instancetype _Nonnull)initWithCategoryTitle:(NSString * _Nullable)categoryName {
    self = [super init];
    if (self) {
        _categoryTitle = categoryName;
    }
    
    return self;
}

@end
