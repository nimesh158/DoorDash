//
//  DDStore.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDStore.h"

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
        _minimumDeliveryTime = minimumDeliveryTime;
        _imageDownloadCompletionBlocks = [NSMutableArray arrayWithCapacity:0];
        _isDownloadingImage = NO;
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

@end
