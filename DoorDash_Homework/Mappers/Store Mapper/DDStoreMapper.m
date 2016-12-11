//
//  DDStoreMapper.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDStoreMapper.h"

#import "DDConstants.h"
#import "DDStore.h"

/**
 * To optimize performance, we could parse this in it's own queue, and then pass the result back to the
 * caller via a block. This way, all the stores can be parsed in their own queue in parallel.
 */

@implementation DDStoreMapper

+ (DDStore * _Nonnull)storeFromData:(NSDictionary * _Nonnull)data {
    if (data == nil) {
        NSLog(@"ERROR: Incoming data is nil, cannot create a DDStore.");
        return nil;
    }
    
    NSInteger storeID = [self getStoreIDFromData:data];
    NSString *storeName = [self getStoreNameFromData:data];
    NSString *storeDescription = [self getStoreDescriptionFromData:data];
    CGFloat deliveryFee = [self getDeliveryFeeFromData:data];
    NSString *storeImageURL = [self getStoreImageURLFromData:data];
    NSInteger minimumDeliveryTime = [self getMinimumDeliveryTimeFromData:data];
    
    DDStore *store = [[DDStore alloc] initWithStoreID:storeID
                                            storeName:storeName
                                     storeDescription:storeDescription
                                          deliveryFee:deliveryFee
                                        storeImageURL:storeImageURL
                                  minimumDeliveryTime:minimumDeliveryTime];
    
    return store;
}

+ (NSInteger)getStoreIDFromData:(NSDictionary * _Nonnull)data {
    NSNumber *storeID = [data objectForKey:kStoreIDKey];
    
    if ([storeID integerValue] <= 0) {
        //Using NSLog here, but we'd use some sort of Logger class in prod
        NSLog(@"WARNING: Store ID is invalid");
        return kInvalidStoreID;
    }
    
    return [storeID integerValue];
}

+ (NSString *)getStoreNameFromData:(NSDictionary * _Nonnull)data {
    NSString *storeName = [data objectForKey:kStoreNameKey];
    
    if (storeName.length <= 0) {
        NSLog(@"WARING: Store Name is invalid");
    }
    
    return storeName;
}

+ (NSString *)getStoreDescriptionFromData:(NSDictionary * _Nonnull)data {
    NSString *storeDescription = [data objectForKey:kStoreDescriptionKey];
    
    if (storeDescription.length <= 0) {
        NSLog(@"WARING: Store Description is invalid");
    }
    
    return storeDescription;
}

+ (CGFloat)getDeliveryFeeFromData:(NSDictionary * _Nonnull)data {
    NSNumber *deliveryFee = [data objectForKey:kDeliveryFeeKey];
    
    if ([deliveryFee floatValue] <= 0) {
        NSLog(@"WARING: Delivery Fee is invalid");
        return kInvalidDeliveryFee;
    }
    
    CGFloat roundedDeliveryFee = roundf([deliveryFee floatValue] * 100) / 100;
    
    return roundedDeliveryFee / 100;
}

+ (NSString *)getStoreImageURLFromData:(NSDictionary * _Nonnull)data {
    NSString *storeImageURL = [data objectForKey:kStoreImageURLKey];
    
    if (storeImageURL.length <= 0) {
        NSLog(@"WARING: Store Image URL is invalid");
    }
    
    return storeImageURL;
}

+ (NSInteger)getMinimumDeliveryTimeFromData:(NSDictionary * _Nonnull)data {
    NSNumber *minimumDeliveryTime = [data objectForKey:kMinimumDeliveryTimeKey];
    
    if ([minimumDeliveryTime integerValue] <= 0) {
        NSLog(@"WARING: Minimum Delivery Time is invalid");
        return kInvalidMinimumDeliveryTime;
    }
    
    return [minimumDeliveryTime integerValue];
}

@end
