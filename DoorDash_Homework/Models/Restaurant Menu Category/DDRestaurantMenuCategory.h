//
//  DDRestaurantMenuCategory.h
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDRestaurantMenuCategory : NSObject

@property (nonatomic, copy, readonly, nullable) NSString *categoryTitle;

/**
 Creates and returns an instnace of this class with the title passed in.
 @param categoryTitle title of this category.
 @returns An istance of this class.
 */
- (instancetype _Nonnull)initWithCategoryTitle:(NSString * _Nullable)categoryTitle;

@end
