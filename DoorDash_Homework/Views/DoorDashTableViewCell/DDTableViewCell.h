//
//  DDTableViewCell.h
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/11/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDTableViewCell : UITableViewCell

/**
 Updates the store name.
 @param name that the cell is to be updated with.
 */
- (void)updateCellWithStoreName:(NSString *)name;

/**
 Updates the store type.
 @param storeType that the cell is to be updated with.
 */
- (void)updateCellWithStoreType:(NSString *)storeType;

/**
 Updates the store delivery cost.
 @param storeDeliveryCost that the cell is to be updated with.
 */
- (void)updateCellWithStoreDeliveryCost:(NSString *)storeDeliveryCost;

/**
 Updates the store delivery time.
 @param storeDeliveryTime that the cell is to be updated with.
 */
- (void)updateCellWithStoreDeliveryTimeEstimate:(NSString *)storeDeliveryTime;

/**
 Updates the store delivery image.
 @param image that the cell is to be updated with.
 */
- (void)updateCellWithStoreImage:(UIImage *)image;

@end
