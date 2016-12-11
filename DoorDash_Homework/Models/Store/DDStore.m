//
//  DDStore.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDStore.h"

#import "DDRestaurantMenuSearch.h"

@interface DDStore ()

@property (nonatomic, assign, readwrite) NSInteger storeID;
@property (nonatomic, copy, readwrite) NSString *storeName;
@property (nonatomic, copy, readwrite) NSString *storeDescription;
@property (nonatomic, assign, readwrite) CGFloat deliveryFee;
@property (nonatomic, copy, readwrite) NSString *storeImageURL;
@property (nonatomic, strong, readwrite) UIImage *storeImage;
@property (nonatomic, assign, readwrite) CGFloat minimumDeliveryTime;
@property (nonatomic, strong) NSMutableArray *imageDownloadCompletionBlocks;
@property (nonatomic, assign) BOOL isDownloadingImage;
@property (nonatomic, strong) NSArray *storeMenus;
@property (nonatomic, strong) NSMutableArray *storeMenusDownloadCompletionBlocks;
@property (nonatomic, assign) BOOL isDownloadingStoreMenus;

@end

@implementation DDStore

- (instancetype _Nonnull)initWithStoreID:(NSInteger)storeID
                               storeName:(NSString *)storeName
                        storeDescription:(NSString *)storeDescription
                             deliveryFee:(CGFloat)deliveryFee
                           storeImageURL:(NSString *)storeImageURL
                     minimumDeliveryTime:(CGFloat)minimumDeliveryTime {
    self = [super init];
    if (self) {
        _storeID = storeID;
        _storeName = storeName;
        _storeDescription = storeDescription;
        _deliveryFee = deliveryFee;
        _storeImageURL = storeImageURL;
        _storeImage = nil;
        _minimumDeliveryTime = minimumDeliveryTime;
        _imageDownloadCompletionBlocks = [NSMutableArray arrayWithCapacity:0];
        _isDownloadingImage = NO;
        _storeMenus = nil;
        _storeMenusDownloadCompletionBlocks = [NSMutableArray arrayWithCapacity:0];
        _isDownloadingStoreMenus = NO;
    }
    
    return self;
}

- (void)getStoreImageWithCompletion:(DDStoreImageDownloadedCompletionBlock)completion {
    if (self.isDownloadingImage == YES) {
        [self.imageDownloadCompletionBlocks addObject:completion];
    } else {
        if (self.storeImage == nil) {
            [self.imageDownloadCompletionBlocks addObject:completion];
            self.isDownloadingImage = YES;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.storeImageURL]];
                self.storeImage = [UIImage imageWithData:data];
                self.isDownloadingImage = NO;
                
                [self updateCompletionBlocksForDownloadedImage];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(self.storeImage);
                }
            });
        }
    }
}

- (void)updateCompletionBlocksForDownloadedImage {
    for (DDStoreImageDownloadedCompletionBlock block in self.imageDownloadCompletionBlocks) {
        dispatch_async(dispatch_get_main_queue(), ^{
            block(self.storeImage);
        });
    }
    [self.imageDownloadCompletionBlocks removeAllObjects];
}

- (void)getStoreMenusWithCompletion:(DDStoreMenusDownloadCompletionBlock)completionBlock {
    if (self.isDownloadingStoreMenus == YES) {
        [self.storeMenusDownloadCompletionBlocks addObject:completionBlock];
    } else {
        if (self.storeMenus == nil) {
            [self.imageDownloadCompletionBlocks addObject:completionBlock];
            self.isDownloadingStoreMenus = YES;
            NSInteger restaurantID = self.storeID;
            __weak typeof(self)weakSelf = self;
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                __strong typeof(weakSelf) strongWeakSelf = weakSelf;
                DDRestaurantMenuSearch *restaurantMenuSearch = [[DDRestaurantMenuSearch alloc] init];
                [restaurantMenuSearch
                 findRestaurantMenuForRestaurantWithID:restaurantID
                 success:^(NSArray *restaurantMenus) {
                     strongWeakSelf.storeMenus = restaurantMenus;
                     
                     [strongWeakSelf updateCompletionBlocksForDownloadedStoreMenusWithError:nil];
                 }
                 failure:^(NSError * error) {
                     [strongWeakSelf updateCompletionBlocksForDownloadedStoreMenusWithError:error];
                 }];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completionBlock) {
                    completionBlock(self.storeMenus, nil);
                }
            });
        }
    }
}

- (void)updateCompletionBlocksForDownloadedStoreMenusWithError:(NSError *)error {
    __weak typeof(self)this = self;
    for (DDStoreMenusDownloadCompletionBlock block in self.storeMenusDownloadCompletionBlocks) {
        dispatch_async(dispatch_get_main_queue(), ^{
            block(this.storeMenus, error);
        });
    }
    
    [self.storeMenusDownloadCompletionBlocks removeAllObjects];
}

@end
