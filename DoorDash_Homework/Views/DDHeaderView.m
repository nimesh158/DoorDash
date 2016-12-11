//
//  DDHeaderView.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/11/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDHeaderView.h"


@interface DDHeaderView ()

@property (nonatomic, weak) IBOutlet UIButton *leftButton;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIButton *rightButton;
@property (nonatomic, copy) DDHeaderViewButtonTapListener leftButtonTapListener;
@property (nonatomic, copy) DDHeaderViewButtonTapListener rightButtonTapListener;

@end

@implementation DDHeaderView

- (void)setTitle:(NSString * _Nonnull)title {
    self.titleLabel.text = title;
}


- (void)setTitleColor:(UIColor *)color {
    [self.titleLabel setTextColor:color];
}

- (void)setLeftButtonTapListener:(DDHeaderViewButtonTapListener _Nonnull)listener {
    if (listener == nil) {
        NSLog(@"ERROR: Cannot set a nil listener");
    }
    
    if (self.leftButtonTapListener != nil) {
        NSLog(@"WARNING: Listener NOT nil, about to be overwritten");
    }
    self.leftButtonTapListener = listener;
}

- (void)setRightButtonTapListener:(DDHeaderViewButtonTapListener _Nonnull)listener {
    if (listener == nil) {
        NSLog(@"ERROR: Cannot set a nil listener");
    }
    
    if (self.rightButtonTapListener != nil) {
        NSLog(@"WARNING: Listener NOT nil, about to be overwritten");
    }
    self.rightButtonTapListener = listener;
}

#pragma mark - User Interaction
- (IBAction)leftButtonTapped:(UIButton *)sender {
    if (self.leftButtonTapListener != nil) {
        self.leftButtonTapListener();
    }
}

- (IBAction)rightButtonTapped:(UIButton *)sender {
    if (self.rightButtonTapListener != nil) {
        self.rightButtonTapListener();
    }
}

@end
