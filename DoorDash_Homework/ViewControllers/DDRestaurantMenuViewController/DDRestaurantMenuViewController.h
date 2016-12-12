//
//  DDRestaurantMenuViewController.h
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/11/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDStore;

@interface DDRestaurantMenuViewController : UIViewController

/**
 Use this initializer to set the store whose menu is to be viewed.
 @param store whose menu is to be viewed
 @returns An instance of this class.
 */
- (instancetype)initWithStore:(DDStore *)store;

@end
