//
//  DDFavoriteStoresManager.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDFavoriteStoresManager.h"

#import "DDConstants.h"
#import "DDStore.h"

static NSString * const kDDErrorDomain = @"com.doordash.homework.favorite.stores";

@interface DDFavoriteStoresManager ()

@property (nonatomic, strong) NSMutableArray *favoriteStores;
@property (nonatomic, copy) dispatch_queue_t workQueue;
@property (nonatomic, strong) NSUserDefaults *userDefaults;

@end

@implementation DDFavoriteStoresManager

static DDFavoriteStoresManager *_manager = nil;
static dispatch_once_t onceToken = 0;
+ (instancetype)sharedInstance {
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    
    return _manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _workQueue = dispatch_queue_create("com.doordash.homework.favorite.stores.queue", DISPATCH_QUEUE_SERIAL);
        _userDefaults = [NSUserDefaults standardUserDefaults];
        NSArray *favorites = [[_userDefaults objectForKey:kFavoriteStoresKey] mutableCopy];
        _favoriteStores = [NSMutableArray arrayWithCapacity:0];
        if (favorites != nil) {
            for (NSData *data in favorites) {
                DDStore *store = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                [_favoriteStores addObject:store];
            }
        }
    }
    
    return self;
}

- (NSError *)getStoreNilError {
    NSError *error = [[NSError alloc] initWithDomain:kDDErrorDomain
                                                code:kFavoriteStoresInvalidStoreErrorCode
                                            userInfo:nil];
    
    return error;
}

- (NSError *)getCannotUnFavoriteAStoreNotFavoritedError {
    NSDictionary *userInfo = @{
                               @"userInfo" : @"Cnanot unfavorite a store not favorited"
                               };
    NSError *error = [[NSError alloc] initWithDomain:kDDErrorDomain
                                                code:kCannotUnFavoriteAStoreNotFavorited
                                            userInfo:userInfo];
    
    return error;
}

- (NSError *)getStoreAlreadyInFavoritesError {
    NSDictionary *userInfo = @{
                               @"userInfo" : @"Cnanot save a store twice. It's already favorited."
                               };
    NSError *error = [[NSError alloc] initWithDomain:kDDErrorDomain
                                                code:kStoreAlreadyFavorited
                                            userInfo:userInfo];
    
    return error;
}

- (BOOL)isStoreInFavorites:(DDStore *)store favorites:(NSArray *)favorites {
    if (store == nil) {
        NSLog(@"ERROR: Cannot check for nil store");
        return NO;
    }

    if (favorites.count <= 0) {
        NSLog(@"Empty Store");
        return NO;
    }
    
    for (NSInteger index = 0; index < favorites.count; index++) {
        DDStore *localStore = favorites[index];
        if (localStore.storeID == store.storeID) {
            return YES;
        }
    }
    
    return NO;
}

- (void)favoriteStore:(DDStore *)store {
    [self.favoriteStores addObject:store];
    [self archiveFavoritesToDefaults];
}

- (void)unfavoriteStore:(DDStore *)store {
    [self.favoriteStores removeObject:store];
    [self archiveFavoritesToDefaults];
}

- (void)archiveFavoritesToDefaults {
    NSMutableArray *archiveArray = [NSMutableArray arrayWithCapacity:self.favoriteStores.count];
    for (DDStore *store in self.favoriteStores) {
        NSData *encodedStore = [NSKeyedArchiver archivedDataWithRootObject:store];
        [archiveArray addObject:encodedStore];
    }
    
    [self.userDefaults setObject:archiveArray
                          forKey:kFavoriteStoresKey];
    [self.userDefaults synchronize];
}

- (void)getAllFavoritesWithCompletion:(DDFavoriteStoresGetAllFavoritesCompletionBlock)completion {
    if (completion == nil) {
        NSLog(@"ERROR: Cannot return favorite stores without completion block");
        return;
    }
    
    dispatch_async(self.workQueue, ^{
        NSArray *favorites = [self.favoriteStores copy];
        completion(favorites);
    });
}

- (void)addStoreToFavorites:(DDStore *)store
             withCompletion:(DDFavoriteStoresCompletionBlock _Nonnull)completion {
    if (store == nil) {
        completion(NO, [self getStoreNilError]);
        return;
    }
    
    __weak typeof(self)weakSelf = self;
    __strong typeof(weakSelf) strongSelf = weakSelf;
    
    dispatch_async(self.workQueue, ^{
        if ([strongSelf isStoreInFavorites:store favorites:strongSelf.favoriteStores] == NO) {
            [strongSelf favoriteStore:store];
            completion(YES, nil);
        } else {
            completion(NO, [self getStoreAlreadyInFavoritesError]);
        }
    });
}

- (void)removeStoreFromFavorites:(DDStore * _Nonnull)store
                  withCompletion:(DDFavoriteStoresCompletionBlock _Nonnull)completion {
    if (store == nil) {
        completion(NO, [self getStoreNilError]);
        return;
    }
    
    __weak typeof(self)weakSelf = self;
    __strong typeof(weakSelf) strongSelf = weakSelf;
    
    dispatch_async(self.workQueue, ^{
        if ([strongSelf isStoreInFavorites:store favorites:strongSelf.favoriteStores] == NO) {
            completion(NO, [self getCannotUnFavoriteAStoreNotFavoritedError]);
        } else {
            [strongSelf unfavoriteStore:store];
            completion(YES, nil);
        }
    });
}

- (void)isStoreCurrentlyFavorited:(DDStore *)favoritedStore
                   withCompletion:(DDFavoriteStoresIsStoreCurrentlyFavorited _Nonnull)completion {
    if (completion == nil) {
        NSLog(@"ERROR: COmpletion block is nil. Cannot return result of check. Aborting");
        return;
    }
    
    if (favoritedStore == nil) {
        NSLog(@"ERROR: Favorite Store value is nil");
        completion(NO);
    }
    
    __weak typeof(self)weakSelf = self;
    __strong typeof(weakSelf) strongSelf = weakSelf;
    
    dispatch_async(self.workQueue, ^{
        BOOL inFavorites = [strongSelf isStoreInFavorites:favoritedStore
                                                favorites:strongSelf.favoriteStores];
        completion(inFavorites);
    });
}

+(void)resetSharedInstance_TestOnly {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kFavoriteStoresKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    onceToken = 0;
    _manager = nil;
}

@end
