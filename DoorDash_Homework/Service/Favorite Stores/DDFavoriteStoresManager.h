//
//  DDFavoriteStoresManager.h
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DDFavoriteStoresGetAllFavoritesCompletionBlock)(NSArray * _Nullable);
typedef void(^DDFavoriteStoresCompletionBlock)(BOOL, NSError * _Nullable);
typedef void(^DDFavoriteStoresIsStoreCurrentlyFavorited)(BOOL);

@class DDStore;

/**
 * A better design for this class is to Inject the backing data store. Right now the dependency is on NSUserDefaults, but
 * we could implement a protocol that the backing store would conform to, thus adding a layer of abstraction.
 * This would also assist in Unit Testing.
 */

@interface DDFavoriteStoresManager : NSObject

/**
 Returns the singleton instance of this class.
 @returns The instance of DDRestaurantMenuCategory.
 */
+ (instancetype _Nonnull)sharedInstance;

/**
 Returns an array of the stores the user has previously favorited.
 @param completion block on which the caller is notified of the favorites array.
 */
- (void)getAllFavoritesWithCompletion:(DDFavoriteStoresGetAllFavoritesCompletionBlock _Nonnull)completion;

/**
 Adds a store to favorites.
 @param store that is to be added as a favorite.
 @param completion block on which the caller is notified of the success or failure of the saving procedure.
 */
- (void)addStoreToFavorites:(DDStore * _Nonnull)store
             withCompletion:(DDFavoriteStoresCompletionBlock _Nonnull)completion;

/**
 Removes a store from favorites.
 @param store that is to be remvoed as a favorite.
 @param completion block on which the caller is notified of the success or failure of the removal procedure.
 */
- (void)removeStoreFromFavorites:(DDStore * _Nonnull)store
                  withCompletion:(DDFavoriteStoresCompletionBlock _Nonnull)completion;

/**
 Checks to see if a store is already favorited.
 @param favoritedStore that is to be checked to see if it's in favorites.
 @param completion block on which the caller is notified is the store is previously favorited or not..
 */
- (void)isStoreCurrentlyFavorited:(DDStore * _Nonnull)favoritedStore
                   withCompletion:(DDFavoriteStoresIsStoreCurrentlyFavorited _Nonnull)completion;

@end
