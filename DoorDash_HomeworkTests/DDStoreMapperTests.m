//
//  DDStoreMapperTests.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DDConstants.h"
#import "DDStoreMapper.h"
#import "DDStore.h"

static NSInteger    const kStoreID = 416;
static NSString *   const kStoreName = @"P.F. Chang's (Stanford Shopping Center - 9911)";
static NSString *   const kStoreDescription = @"Asian Fusion and Chinese";
static NSInteger    const kStoreDeliveryFee = 399;
static NSString *   const kStoreImageURL = @"https://doordash-static.s3.amazonaws.com/media/restaurant/cover/PFC.png";
static NSInteger    const kMinimumDeliveryTime = 49;

@interface DDStore ()

@property (nonatomic, copy, readwrite) NSString *storeImageURL;

@end

@interface DDStoreMapper ()

+ (NSInteger)getStoreIDFromData:(NSDictionary * _Nonnull)data;
+ (NSString *)getStoreNameFromData:(NSDictionary * _Nonnull)data;
+ (NSString *)getStoreDescriptionFromData:(NSDictionary * _Nonnull)data;
+ (CGFloat)getDeliveryFeeFromData:(NSDictionary * _Nonnull)data;
+ (NSString *)getStoreImageURLFromData:(NSDictionary * _Nonnull)data;
+ (NSInteger)getMinimumDeliveryTimeFromData:(NSDictionary * _Nonnull)data;

@end

@interface DDStoreMapperTests : XCTestCase

@end

@implementation DDStoreMapperTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testParsingOfStoreIdWhenValid {
    NSDictionary *data = [self createTestDataWithId:kStoreID
                                          storeName:kStoreNameKey
                                   storeDescription:kStoreDescriptionKey
                                    deliveryFee:kStoreDeliveryFee
                                           imageURL:kStoreImageURL
                                minimumDeliveryTime:kMinimumDeliveryTime];
    
    DDStore *store = [DDStoreMapper storeFromData:data];
    
    XCTAssertEqual(store.storeID, kStoreID);
}

- (void)testParsingOfStoreIdWhenInValid {
    NSDictionary *data = [self createTestDataWithId:0
                                          storeName:kStoreNameKey
                                   storeDescription:kStoreDescriptionKey
                                        deliveryFee:kStoreDeliveryFee
                                           imageURL:kStoreImageURL
                                minimumDeliveryTime:kMinimumDeliveryTime];
    
    DDStore *store = [DDStoreMapper storeFromData:data];
    
    XCTAssertEqual(store.storeID, kInvalidStoreID);
}

- (void)testParsingOfStoreNameWhenValid {
    NSDictionary *data = [self createTestDataWithId:kStoreID
                                          storeName:kStoreNameKey
                                   storeDescription:kStoreDescriptionKey
                                        deliveryFee:kStoreDeliveryFee
                                           imageURL:kStoreImageURL
                                minimumDeliveryTime:kMinimumDeliveryTime];
    
    DDStore *store = [DDStoreMapper storeFromData:data];
    
    XCTAssertEqual(store.storeName, kStoreNameKey);
}

- (void)testParsingOfStoreNameWhenInValid {
    NSDictionary *data = [self createTestDataWithId:kStoreID
                                          storeName:nil
                                   storeDescription:kStoreDescriptionKey
                                        deliveryFee:kStoreDeliveryFee
                                           imageURL:kStoreImageURL
                                minimumDeliveryTime:kMinimumDeliveryTime];
    
    DDStore *store = [DDStoreMapper storeFromData:data];
    
    XCTAssertNil(store.storeName);
}

- (void)testParsingOfStoreDescriptionWhenValid {
    NSDictionary *data = [self createTestDataWithId:kStoreID
                                          storeName:kStoreNameKey
                                   storeDescription:kStoreDescriptionKey
                                        deliveryFee:kStoreDeliveryFee
                                           imageURL:kStoreImageURL
                                minimumDeliveryTime:kMinimumDeliveryTime];
    
    DDStore *store = [DDStoreMapper storeFromData:data];
    
    XCTAssertEqual(store.storeDescription, kStoreDescriptionKey);
}

- (void)testParsingOfStoreDescriptionWhenInValid {
    NSDictionary *data = [self createTestDataWithId:kStoreID
                                          storeName:kStoreNameKey
                                   storeDescription:nil
                                        deliveryFee:kStoreDeliveryFee
                                           imageURL:kStoreImageURL
                                minimumDeliveryTime:kMinimumDeliveryTime];
    
    DDStore *store = [DDStoreMapper storeFromData:data];
    
    XCTAssertNil(store.storeDescription);
}

- (void)testParsingOfDeliveryFeeWhenValid {
    NSDictionary *data = [self createTestDataWithId:kStoreID
                                          storeName:kStoreNameKey
                                   storeDescription:kStoreDescriptionKey
                                        deliveryFee:kStoreDeliveryFee
                                           imageURL:kStoreImageURL
                                minimumDeliveryTime:kMinimumDeliveryTime];
    
    DDStore *store = [DDStoreMapper storeFromData:data];
    
    XCTAssertEqual(store.deliveryFee, kStoreDeliveryFee/100.0);
}

- (void)testParsingOfDeliveryFeeWhenInValid {
    NSDictionary *data = [self createTestDataWithId:kStoreID
                                          storeName:kStoreNameKey
                                   storeDescription:kStoreDescriptionKey
                                        deliveryFee:0
                                           imageURL:kStoreImageURL
                                minimumDeliveryTime:kMinimumDeliveryTime];
    
    DDStore *store = [DDStoreMapper storeFromData:data];
    
    XCTAssertEqual(store.deliveryFee, kInvalidDeliveryFee);
}

- (void)testParsingOfImageURLWhenValid {
    NSDictionary *data = [self createTestDataWithId:kStoreID
                                          storeName:kStoreNameKey
                                   storeDescription:kStoreDescriptionKey
                                        deliveryFee:kStoreDeliveryFee
                                           imageURL:kStoreImageURL
                                minimumDeliveryTime:kMinimumDeliveryTime];
    
    DDStore *store = [DDStoreMapper storeFromData:data];
    
    XCTAssertEqual(store.storeImageURL, kStoreImageURL);
}

- (void)testParsingOfImageURLWhenInValid {
    NSDictionary *data = [self createTestDataWithId:kStoreID
                                          storeName:kStoreNameKey
                                   storeDescription:kStoreDescriptionKey
                                        deliveryFee:kStoreDeliveryFee
                                           imageURL:nil
                                minimumDeliveryTime:kMinimumDeliveryTime];
    
    DDStore *store = [DDStoreMapper storeFromData:data];
    
    XCTAssertNil(store.storeImageURL);
}

- (void)testParsingOfMinimumDeliveryTimeWhenValid {
    NSDictionary *data = [self createTestDataWithId:kStoreID
                                          storeName:kStoreNameKey
                                   storeDescription:kStoreDescriptionKey
                                        deliveryFee:kStoreDeliveryFee
                                           imageURL:kStoreImageURL
                                minimumDeliveryTime:kMinimumDeliveryTime];
    
    DDStore *store = [DDStoreMapper storeFromData:data];
    
    XCTAssertEqual(store.minimumDeliveryTime, kMinimumDeliveryTime);
}

- (void)testParsingOfMinimumDeliveryTimeWhenInValid {
    NSDictionary *data = [self createTestDataWithId:kStoreID
                                          storeName:kStoreNameKey
                                   storeDescription:kStoreDescriptionKey
                                        deliveryFee:kStoreDeliveryFee
                                           imageURL:kStoreImageURL
                                minimumDeliveryTime:0];
    
    DDStore *store = [DDStoreMapper storeFromData:data];
    
    XCTAssertEqual(store.minimumDeliveryTime, kInvalidMinimumDeliveryTime);
}

- (void)testParsingWhenInvalidData {
    NSDictionary *data = nil;
    DDStore *store = [DDStoreMapper storeFromData:data];
    
    XCTAssertNil(store);
}

- (NSDictionary *)createTestDataWithId:(NSInteger)storeID
                             storeName:(NSString *)storeName
                      storeDescription:(NSString *)storeDescription
                           deliveryFee:(NSInteger)deliveryFee
                              imageURL:(NSString *)imageURL
                   minimumDeliveryTime:(NSInteger)minimumDeliveryTime {
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    
    if (storeID > 0) {
        [data setObject:@(storeID)
                 forKey:kStoreIDKey];
    }
    
    if (storeName.length > 0) {
        [data setObject:storeName
                 forKey:kStoreNameKey];
    }
    
    if (storeDescription.length > 0) {
        [data setObject:storeDescription
                 forKey:kStoreDescriptionKey];
    }
    
    if (deliveryFee > 0) {
        [data setObject:@(deliveryFee)
                 forKey:kDeliveryFeeKey];
    }
    
    if (imageURL.length > 0) {
        [data setObject:imageURL
                 forKey:kStoreImageURLKey];
    }
    
    if (minimumDeliveryTime > 0) {
        [data setObject:@(minimumDeliveryTime)
                 forKey:kMinimumDeliveryTimeKey];
    }
    
    return data;
}

@end
