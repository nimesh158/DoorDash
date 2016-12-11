//
//  DDStoreSearch.h
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

typedef void(^DDStoreSearchSuccess)(NSArray * _Nullable);
typedef void(^DDStoreSearchFailure)(NSError * _Nullable);

@interface DDStoreSearch : NSObject

- (void)searchStoresInAreaWithLatitude:(CGFloat)latitude
                             longitude:(CGFloat)longitude
                               success:(DDStoreSearchSuccess _Nonnull)success
                               failure:(DDStoreSearchFailure _Nonnull)failure;
- (void)cancel;

@end
