//
//  DDTableViewCell.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/11/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDTableViewCell.h"

@interface DDTableViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *storeImageView;
@property (nonatomic, weak) IBOutlet UILabel *storeName;
@property (nonatomic, weak) IBOutlet UILabel *storeType;
@property (nonatomic, weak) IBOutlet UILabel *storeDeliveryCost;
@property (nonatomic, weak) IBOutlet UILabel *storeDeliveryTimeEstimate;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;


@end

@implementation DDTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self.activityIndicator startAnimating];
    [self.storeImageView setHidden:YES];
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

- (void)updateCellWithStoreImage:(UIImage *)image {
    [self.storeImageView setImage:image];
    [self.storeImageView setHidden:NO];
    [self.activityIndicator stopAnimating];
}

@end
