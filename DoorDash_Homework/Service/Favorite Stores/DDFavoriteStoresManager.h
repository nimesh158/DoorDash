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

+ (instancetype _Nonnull)sharedInstance;

- (void)getAllFavoritesWithCompletion:(DDFavoriteStoresGetAllFavoritesCompletionBlock _Nonnull)completion;

- (void)addStoreToFavorites:(DDStore * _Nonnull)store
             withCompletion:(DDFavoriteStoresCompletionBlock _Nonnull)completion;

- (void)removeStoreFromFavorites:(DDStore * _Nonnull)store
                  withCompletion:(DDFavoriteStoresCompletionBlock _Nonnull)completion;

- (void)isStoreCurrentlyFavorited:(DDStore * _Nonnull)favoritedStore
                   withCompletion:(DDFavoriteStoresIsStoreCurrentlyFavorited _Nonnull)completion;

@end
