//
//  DDTableViewCell.h
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/11/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDTableViewCell : UITableViewCell

- (void)updateCellWithStoreName:(NSString *)name;

- (void)updateCellWithStoreType:(NSString *)storeType;

- (void)updateCellWithStoreDeliveryCost:(NSString *)storeDeliveryCost;

- (void)updateCellWithStoreDeliveryTimeEstimate:(NSString *)storeDeliveryTime;

@end
