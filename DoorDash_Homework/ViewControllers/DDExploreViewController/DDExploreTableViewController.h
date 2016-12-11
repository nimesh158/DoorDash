//
//  DDExploreTableViewController.h
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/11/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDExploreTableViewController : UITableViewController

- (void)updateControllerForLatitude:(CGFloat)latitude
                          longitude:(CGFloat)longitude;

@end
