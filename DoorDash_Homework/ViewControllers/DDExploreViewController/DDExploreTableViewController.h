//
//  DDExploreTableViewController.h
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/11/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DDExploreTableViewControllerProtocol <NSObject>

- (void)didTapShowMaputton;

- (void)didTapSearchButton;

@end

@interface DDExploreTableViewController : UITableViewController

@property (nonatomic, assign, readwrite) id <DDExploreTableViewControllerProtocol> delegate;

- (void)updateControllerForLatitude:(CGFloat)latitude
                          longitude:(CGFloat)longitude;

- (NSArray *)getDataSource;

- (void)updateDataSource:(NSArray *)newDataSource;

@end
