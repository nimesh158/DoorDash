//
//  DDTabBar.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/11/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDTabBar.h"

@interface DDTabBar ()

@property (nonatomic, strong) IBOutlet UIButton *leftTab;
@property (nonatomic, strong) IBOutlet UIButton *rightTab;
@property (nonatomic, copy) DDTabBarItemTappedBlock leftTabListener;
@property (nonatomic, copy) DDTabBarItemTappedBlock rightTabListener;

@end

@implementation DDTabBar

- (instancetype)init {
    self = [super init];
    if(self) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *nib = [[[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        [self addSubview:nib];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    
    return self;
}

- (IBAction)leftTabTapped:(UIButton *)sender {
    if(sender == self.leftTab &&
       self.leftTabListener != nil) {
        self.leftTabListener();
    }
}

- (IBAction)rightTabTapped:(UIButton *)sender {
    if(sender == self.rightTab &&
       self.rightTabListener != nil) {
        self.rightTabListener();
    }
}

#pragma mark - Public
- (void)setLeftTabItemImage:(UIImage *)image {
    [self.leftTab setImage:image forState:UIControlStateNormal | UIControlStateSelected];
}

- (void)setRightTabItemImage:(UIImage *)image {
    [self.rightTab setImage:image forState:UIControlStateNormal | UIControlStateSelected];
}

- (void)setLeftItemTappedListener:(DDTabBarItemTappedBlock _Nonnull)leftItemListener
                rightItemListener:(DDTabBarItemTappedBlock _Nonnull)rightItemListener {
    if (self.leftTabListener != nil) {
        NSLog(@"WARNING: Left tab listener not nil, will be overwritten");
    }
    self.leftTabListener = leftItemListener;
    
    if (self.rightTabListener != nil) {
        NSLog(@"WARNING: RIght tab listener not nil, will be overwritten");
    }
    self.rightTabListener = rightItemListener;
}

@end
