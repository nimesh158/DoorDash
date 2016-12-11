//
//  DDTabBar.h
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/11/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DDTabBarItemTappedBlock)();
typedef void (^DDTabBarItemTappedBlock)();

@interface DDTabBar : UIView

- (void)setLeftTabItemImage:(UIImage * _Nonnull)image;

- (void)setRightTabItemImage:(UIImage * _Nonnull)image;

- (void)setLeftItemTappedListener:(DDTabBarItemTappedBlock _Nonnull)leftItemListener
                rightItemListener:(DDTabBarItemTappedBlock _Nonnull)rightItemListener;

@end
