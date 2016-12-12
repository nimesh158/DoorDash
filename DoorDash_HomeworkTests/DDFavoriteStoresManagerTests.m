//
//  DDFavoriteStoresManagerTests.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/11/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

/**
 * NOTE: Remember to clear Simulator after each run,
 * to make sure NSUserDefaults starts on a clean slate.
 * The abstraction of the persistance layer I talked about earlier
 * should aid in this.
 */

#import <XCTest/XCTest.h>

#import "DDConstants.h"
#import "DDStore.h"
#import "DDFavoriteStoresManager.h"

static NSInteger  const kStoreID1 = 123;
static NSString * const kStoreName1 = @"testName1";
static NSString * const kStoreDescription1 = @"testDescription1";
static NSInteger  const kStoreID2 = 1234;
static NSString * const kStoreName2 = @"testName2";
static NSString * const kStoreDescription2 = @"testDescription2";
static NSInteger  const kStoreID3 = 12345;
static NSString * const kStoreName3 = @"testName3";
static NSString * const kStoreDescription3 = @"testDescription3";

@interface DDFavoriteStoresManager ()

- (BOOL)isStoreInFavorites:(DDStore *)store favorites:(NSArray *)favorites;
+ (void)resetSharedInstance_TestOnly;

@end

@interface DDFavoriteStoresManagerTests : XCTestCase

@property (nonatomic, strong) DDFavoriteStoresManager *manager;

@end

@implementation DDFavoriteStoresManagerTests

- (void)setUp {
    [super setUp];
    
    self.manager = [DDFavoriteStoresManager sharedInstance];
}

- (void)tearDown {
    self.manager = nil;
    [DDFavoriteStoresManager resetSharedInstance_TestOnly];
    t
    [super tearDown];
}

- (void)testIsStoreFavoritedWhenTrue {
    
    DDStore *store1 = [[DDStore alloc] initWithStoreID:kStoreID1
                                             storeName:kStoreName1
                                      storeDescription:kStoreDescription1
                                           deliveryFee:0
                                         storeImageURL:nil
                                   minimumDeliveryTime:0];
    
    DDStore *store2 = [[DDStore alloc] initWithStoreID:kStoreID2
                                             storeName:kStoreName2
                                      storeDescription:kStoreDescription2
                                           deliveryFee:0
                                         storeImageURL:nil
                                   minimumDeliveryTime:0];
    
    NSArray *favorites = @[store1, store2];
    
    BOOL isInFavorites = [self.manager isStoreInFavorites:store1
                                                favorites:favorites];
    XCTAssertTrue(isInFavorites);
}

- (void)testIsStoreFavoritedWhenFalse {
    
    DDStore *store1 = [[DDStore alloc] initWithStoreID:kStoreID1
                                             storeName:kStoreName1
                                      storeDescription:kStoreDescription1
                                           deliveryFee:0
                                         storeImageURL:nil
                                   minimumDeliveryTime:0];
    
    DDStore *store2 = [[DDStore alloc] initWithStoreID:kStoreID2
                                             storeName:kStoreName2
                                      storeDescription:kStoreDescription2
                                           deliveryFee:0
                                         storeImageURL:nil
                                   minimumDeliveryTime:0];
    
    
    DDStore *store3 = [[DDStore alloc] initWithStoreID:kStoreID3
                                             storeName:kStoreName3
                                      storeDescription:kStoreDescription3
                                           deliveryFee:0
                                         storeImageURL:nil
                                   minimumDeliveryTime:0];
    
    NSArray *favorites = @[store1, store2];
    
    BOOL isInFavorites = [self.manager isStoreInFavorites:store3
                                                favorites:favorites];
    XCTAssertFalse(isInFavorites);
}

- (void)testAddToStoreNotDuplicate {
    DDStore *store1 = [[DDStore alloc] initWithStoreID:kStoreID1
                                             storeName:kStoreName1
                                      storeDescription:kStoreDescription1
                                           deliveryFee:0
                                         storeImageURL:nil
                                   minimumDeliveryTime:0];
    
    DDStore *store2 = [[DDStore alloc] initWithStoreID:kStoreID2
                                             storeName:kStoreName2
                                      storeDescription:kStoreDescription2
                                           deliveryFee:0
                                         storeImageURL:nil
                                   minimumDeliveryTime:0];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"addToStoreNotDuplicate"];
    
    [self.manager addStoreToFavorites:store1
                       withCompletion:^(BOOL success, NSError *error) {
                       }];
    
    [self.manager addStoreToFavorites:store2
                       withCompletion:^(BOOL success, NSError *error) {
                           XCTAssertTrue(success);
                           XCTAssertNil(error);
                           [expectation fulfill];
                       }];
    
    [self waitForExpectationsWithTimeout:2 handler:nil];
}

- (void)testAddToStoreDpulicate {
    DDStore *store1 = [[DDStore alloc] initWithStoreID:kStoreID1
                                             storeName:kStoreName1
                                      storeDescription:kStoreDescription1
                                           deliveryFee:0
                                         storeImageURL:nil
                                   minimumDeliveryTime:0];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"dddToStoreDpulicate"];
    
    [self.manager addStoreToFavorites:store1
                       withCompletion:^(BOOL success, NSError *error) {
                       }];
    
    [self.manager addStoreToFavorites:store1
                       withCompletion:^(BOOL success, NSError *error) {
                           XCTAssertFalse(success);
                           XCTAssertNotNil(error);
                           [expectation fulfill];
                       }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testRemoveFromStoreWhenInStore {
    DDStore *store1 = [[DDStore alloc] initWithStoreID:kStoreID1
                                             storeName:kStoreName1
                                      storeDescription:kStoreDescription1
                                           deliveryFee:0
                                         storeImageURL:nil
                                   minimumDeliveryTime:0];
    
    DDStore *store2 = [[DDStore alloc] initWithStoreID:kStoreID2
                                             storeName:kStoreName2
                                      storeDescription:kStoreDescription2
                                           deliveryFee:0
                                         storeImageURL:nil
                                   minimumDeliveryTime:0];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"removeFromStoreWhenInStore"];
    
    [self.manager addStoreToFavorites:store1
                       withCompletion:^(BOOL success, NSError *error) {
                       }];
    
    [self.manager addStoreToFavorites:store2
                       withCompletion:^(BOOL success, NSError *error) {
                       }];
    
    [self.manager removeStoreFromFavorites:store1
                            withCompletion:^(BOOL success, NSError *error) {
                                XCTAssertTrue(success);
                                XCTAssertNil(error);
                                [expectation fulfill];
                            }];
    
    [self waitForExpectationsWithTimeout:2 handler:nil];
}

- (void)testRemoveFromStoreWhenNotInStore {
    DDStore *store1 = [[DDStore alloc] initWithStoreID:kStoreID1
                                             storeName:kStoreName1
                                      storeDescription:kStoreDescription1
                                           deliveryFee:0
                                         storeImageURL:nil
                                   minimumDeliveryTime:0];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"removeFromStoreWhenNotInStore"];
    
    [self.manager addStoreToFavorites:store1
                       withCompletion:^(BOOL success, NSError *error) {
                       }];
    
    [self.manager addStoreToFavorites:store1
                       withCompletion:^(BOOL success, NSError *error) {
                           XCTAssertFalse(success);
                           XCTAssertNotNil(error);
                           [expectation fulfill];
                       }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testGetAllWhenStoreNotEmpty {
    DDStore *store1 = [[DDStore alloc] initWithStoreID:kStoreID1
                                             storeName:kStoreName1
                                      storeDescription:kStoreDescription1
                                           deliveryFee:0
                                         storeImageURL:nil
                                   minimumDeliveryTime:0];
    
    DDStore *store2 = [[DDStore alloc] initWithStoreID:kStoreID2
                                             storeName:kStoreName2
                                      storeDescription:kStoreDescription2
                                           deliveryFee:0
                                         storeImageURL:nil
                                   minimumDeliveryTime:0];
    
    
    DDStore *store3 = [[DDStore alloc] initWithStoreID:kStoreID3
                                             storeName:kStoreName3
                                      storeDescription:kStoreDescription3
                                           deliveryFee:0
                                         storeImageURL:nil
                                   minimumDeliveryTime:0];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"getAllWhenStoreNotEmpty"];
    
    [self.manager addStoreToFavorites:store1
                       withCompletion:^(BOOL success, NSError *error) {
                       }];
    
    [self.manager addStoreToFavorites:store2
                       withCompletion:^(BOOL success, NSError *error) {
                       }];
    
    [self.manager addStoreToFavorites:store3
                       withCompletion:^(BOOL success, NSError *error) {
                       }];
    
    [self.manager removeStoreFromFavorites:store1
                            withCompletion:^(BOOL success, NSError *error) {
                            }];
    
    [self.manager removeStoreFromFavorites:store2
                            withCompletion:^(BOOL success, NSError *error) {
                            }];
    
    [self.manager getAllFavoritesWithCompletion:^(NSArray *stores) {
        XCTAssertEqual(1, stores.count);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testGetAllWhenStoreEmpty {
    XCTestExpectation *expectation = [self expectationWithDescription:@"getAllWhenStoreEmpty"];
    
    [self.manager getAllFavoritesWithCompletion:^(NSArray *stores) {
        XCTAssertEqual(0, stores.count);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (DDStore *)getStoreWithID:(NSInteger)storeID
                       name:(NSString *)name
                description:(NSString *)description {
    
    DDStore *store = [[DDStore alloc] initWithStoreID:storeID
                                            storeName:name
                                     storeDescription:description
                                          deliveryFee:0
                                        storeImageURL:nil
                                  minimumDeliveryTime:0];
    
    return store;
}

@end
