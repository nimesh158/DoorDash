//
//  DDConstants.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDConstants.h"

NSString * const kDDBaseURL = @"https://api.doordash.com/";
NSString * const kDDStoreSearchURL = @"v1/store_search/?";
NSString * const kDDRestaurantMenuURL = @"v2/restaurant/%d/menu";
NSString * const kDDErrorDescriptionKey = @"errorDescription";
NSInteger  const kDDNoNetworkErrorCode = 3001;
NSString * const kDDNoNetworkErrorDescription = @"Cannot connect to network. Please check your internet connection.";
NSInteger  const kDDInvalidDataErrorCode = 4001;
NSString * const kDDInvalidDataErrorDescription = @"Data recieved from server is invalid.";
NSString * const kDDLatKey = @"lat";
NSString * const kDDLongKey = @"lng";
NSString * const kStoreIDKey = @"id";
NSString * const kStoreNameKey = @"name";
NSString * const kStoreDescriptionKey = @"description";
NSString * const kDeliveryFeeKey = @"delivery_fee";
NSString * const kStoreImageURLKey = @"cover_img_url";
NSString * const kMinimumDeliveryTimeKey = @"asap_time";
NSInteger  const kInvalidStoreID = -1;
NSInteger  const kInvalidDeliveryFee = -1;
NSInteger  const kInvalidMinimumDeliveryTime = -1;
NSString * const kRestaurantMenuIDKey = @"id";
NSString * const kRestaurantMenuNameKey = @"name";
NSString * const kRestaurantMenuCategoriesKey = @"menu_categories";
NSInteger  const kInvalidRestaurantMenuID = -1;
NSString * const kRestaurantMenuTitleKey = @"title";
NSInteger  const kFavoriteStoresInvalidStoreErrorCode = 5001;
NSString * const kFavoriteStoresKey = @"favoriteStores";
NSInteger  const kCannotUnFavoriteAStoreNotFavorited = 6001;
NSInteger  const kStoreAlreadyFavorited = 6001;
