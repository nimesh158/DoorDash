//
//  DDStore.h
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>


typedef void(^DDStoreImageDownloadedCompletionBlock)(UIImage * _Nullable);

@interface DDStore : NSObject

@property (nonatomic, assign, readonly) NSInteger storeID;
@property (nonatomic, copy, readonly, nullable) NSString *storeName;
@property (nonatomic, copy, readonly, nullable) NSString *storeDescription;
@property (nonatomic, assign, readonly) CGFloat deliveryFee;
@property (nonatomic, assign, readonly) CGFloat minimumDeliveryTime;

- (instancetype _Nonnull)initWithStoreID:(NSInteger)storeID
                               storeName:(NSString * _Nullable)storeName
                        storeDescription:(NSString * _Nullable)storeDescription
                             deliveryFee:(CGFloat)deliveryFee
                           storeImageURL:(NSString * _Nullable)storeImageURL
                     minimumDeliveryTime:(CGFloat)minimumDeliveryTime;

/*!
 * @discussion Loads the image from the url and returns it in the completion block.
 * @param completion Called once the data is successfully loaded.
 */
- (void)getStoreImageWithCompletion:(DDStoreImageDownloadedCompletionBlock _Nonnull)completion;

@end
