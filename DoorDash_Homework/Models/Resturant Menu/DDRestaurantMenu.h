//
//  DDRestaurantMenu.h
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDRestaurantMenu : NSObject

@property (nonatomic, assign, readonly) NSInteger menuID;
@property (nonatomic, copy, readonly, nullable) NSString *menuName;
@property (nonatomic, strong, readonly, nullable) NSArray *menuCategories;

- (instancetype _Nonnull)initWithMenuID:(NSInteger)menuID
                               menuName:(NSString * _Nullable)menuName
                         menuCategories:(NSArray * _Nullable)menuCategories;

@end
