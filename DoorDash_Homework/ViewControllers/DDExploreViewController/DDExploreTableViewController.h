//
//  DDExploreTableViewController.h
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/11/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DDExploreTableViewControllerProtocol <NSObject>

/**
 Called whenever the left navigation button is tapped.
 */
- (void)didTapShowMaputton;

/**
 Called whenever the right navitation button is tapped.
 */
- (void)didTapSearchButton;

@end

@interface DDExploreTableViewController : UITableViewController

@property (nonatomic, assign, readwrite) id <DDExploreTableViewControllerProtocol> delegate;

/**
 Let's the controller know that the location has changed, so it needs to refresh itself.
 @param latitude the new latitude
 @param longitude the new longitude
 */
- (void)updateControllerForLatitude:(CGFloat)latitude
                          longitude:(CGFloat)longitude;

/**
 Asks it's children the data source to be used for it's internal tableview
 @returns The data source array.
 */
- (NSArray *)getDataSource;

@end
