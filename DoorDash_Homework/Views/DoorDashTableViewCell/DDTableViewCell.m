//
//  DDTableViewCell.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/11/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDTableViewCell.h"

@interface DDTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *storeImageView;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *storeType;
@property (weak, nonatomic) IBOutlet UILabel *storeDeliveryCost;
@property (weak, nonatomic) IBOutlet UILabel *storeDeliveryTimeEstimate;


@end

@implementation DDTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - Public Methods
- (void)updateCellWithStoreName:(NSString *)name {
    [self.storeName setText:name];
}

- (void)updateCellWithStoreType:(NSString *)storeType {
    [self.storeType setText:storeType];
}

- (void)updateCellWithStoreDeliveryCost:(NSString *)storeDeliveryCost {
    [self.storeDeliveryCost setText:storeDeliveryCost];
}

- (void)updateCellWithStoreDeliveryTimeEstimate:(NSString *)storeDeliveryTime {
    [self.storeDeliveryTimeEstimate setText:storeDeliveryTime];
}

@end
