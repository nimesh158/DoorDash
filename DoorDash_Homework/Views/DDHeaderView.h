//
//  DDHeaderView.h
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/11/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DDHeaderViewButtonTapListener)();

@interface DDHeaderView : UIView

- (void)setTitle:(NSString * _Nonnull)title;

- (void)setTitleColor:(UIColor * _Nonnull)color;

- (void)setLeftButtonTapListener:(DDHeaderViewButtonTapListener _Nonnull)listener;

- (void)setRightButtonTapListener:(DDHeaderViewButtonTapListener _Nonnull)listener;

@end
