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

- (instancetype _Nonnull)initWithCategoryTitle:(NSString * _Nullable)categoryName;

@end
