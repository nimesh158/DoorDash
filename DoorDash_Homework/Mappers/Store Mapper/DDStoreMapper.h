//
//  DDStoreMapper.h
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DDStore;

@interface DDStoreMapper : NSObject

/**
 This class takes in a NSDictionary of JSON data and creates an instance of DDStore class from that data.
 @param data from which an instance of DDStore is created.
 @returns An instance of DDStore.
 */
+ (DDStore * _Nonnull)storeFromData:(NSDictionary * _Nonnull)data;

@end
