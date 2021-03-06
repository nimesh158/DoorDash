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
typedef void(^DDStoreMenusDownloadCompletionBlock) (NSArray * _Nullable, NSError * _Nullable);

@interface DDStore : NSObject

@property (nonatomic, assign, readonly) NSInteger storeID;
@property (nonatomic, copy, readonly, nullable) NSString *storeName;
@property (nonatomic, copy, readonly, nullable) NSString *storeDescription;
@property (nonatomic, assign, readonly) CGFloat deliveryFee;
@property (nonatomic, assign, readonly) CGFloat minimumDeliveryTime;

/**
 Creates and returns an instnace of this class with the storeID, name, description, deliveryFee, storeImageURL and minimumDeliveryTime passed in.
 @param storeID ID of the store being created.
 @param storeName name of the store being created.
 @param storeDescription provides a description of the store being created.
 @param deliveryFee deliveryFee of the store being created.
 @param storeImageURL url where the image of the store being created is hosted.
 @param minimumDeliveryTime minimum delivery time of the store being created.
 @returns An instance of this class.
 */
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

/*!
 * @discussion Loads the store menus from the server and returns it in the completion block.
 * @param completionBlock Called once the data is either successfully loaded, or something goes wrong.
 */
- (void)getStoreMenusWithCompletion:(DDStoreMenusDownloadCompletionBlock _Nonnull)completionBlock;

@end
