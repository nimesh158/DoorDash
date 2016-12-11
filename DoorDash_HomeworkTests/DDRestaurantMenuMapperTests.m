//
//  DDRestaurantMenuMapperTests.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DDRestaurantMenuCategoryMapperTests.h"

#import "DDConstants.h"
#import "DDRestaurantMenu.h"
#import "DDRestaurantMenuMapper.h"

static NSInteger    const kRestaurantMenuID = 102677;
static NSString *   const kRestaurantMenuName = @"The Cheesecake Factory (California: Fall) (Brunch)*";

@interface DDRestaurantMenuMapper ()

+ (NSInteger)geMenuIDFromData:(NSDictionary * _Nonnull)data;
+ (NSString *)geMenuNameFromData:(NSDictionary * _Nonnull)data;
+ (NSArray *)getMenuCategoriesFromData:(NSDictionary * _Nonnull)data;

@end

@interface DDRestaurantMenuMapperTests : XCTestCase

@property (nonatomic, retain) NSArray *restaurantMenuCategoryTitles;

@end

@implementation DDRestaurantMenuMapperTests

- (void)setUp {
    [super setUp];
    
    self.restaurantMenuCategoryTitles = @[@"Sunday Brunch", @"Fresh Baked Flatbreads", @"Appetizers", @"Pizzas"];
}

- (void)tearDown {
    self.restaurantMenuCategoryTitles = nil;
    [super tearDown];
}

- (void)testParsingORestaurantMenuIdWhenValid {
    NSArray *menuCategories = [DDRestaurantMenuCategoryMapperTests createTestDataWithMenuCategoryTitles:self.restaurantMenuCategoryTitles];
    
    NSDictionary *data = [self createTestDataWithId:kRestaurantMenuID
                                 restaurantMenuName:kRestaurantMenuName
                                     menuCategories:menuCategories];
    
    DDRestaurantMenu *menu = [DDRestaurantMenuMapper restaurantMenuFromData:data];
    
    XCTAssertEqual(menu.menuID, kRestaurantMenuID);
}

- (void)testParsingORestaurantMenuIdWhenInvalid {
    NSArray *menuCategories = [DDRestaurantMenuCategoryMapperTests createTestDataWithMenuCategoryTitles:self.restaurantMenuCategoryTitles];
    
    NSDictionary *data = [self createTestDataWithId:0
                                 restaurantMenuName:kRestaurantMenuName
                                     menuCategories:menuCategories];
    
    DDRestaurantMenu *menu = [DDRestaurantMenuMapper restaurantMenuFromData:data];
    
    XCTAssertEqual(menu.menuID, kInvalidRestaurantMenuID);
}

- (void)testParsingORestaurantMenuNameWhenValid {
    NSArray *menuCategories = [DDRestaurantMenuCategoryMapperTests createTestDataWithMenuCategoryTitles:self.restaurantMenuCategoryTitles];
    
    NSDictionary *data = [self createTestDataWithId:kRestaurantMenuID
                                 restaurantMenuName:kRestaurantMenuName
                                     menuCategories:menuCategories];
    
    DDRestaurantMenu *menu = [DDRestaurantMenuMapper restaurantMenuFromData:data];
    
    XCTAssertEqual(menu.menuName, kRestaurantMenuName);
}

- (void)testParsingORestaurantMenuNameWhenInvalid {
    NSArray *menuCategories = [DDRestaurantMenuCategoryMapperTests createTestDataWithMenuCategoryTitles:self.restaurantMenuCategoryTitles];
    
    NSDictionary *data = [self createTestDataWithId:kRestaurantMenuID
                                 restaurantMenuName:nil
                                     menuCategories:menuCategories];
    
    DDRestaurantMenu *menu = [DDRestaurantMenuMapper restaurantMenuFromData:data];
    
    XCTAssertNil(menu.menuName);
}

- (void)testParsingORestaurantMenuCategoriesWhenValid {
    NSArray *menuCategories = [DDRestaurantMenuCategoryMapperTests createTestDataWithMenuCategoryTitles:self.restaurantMenuCategoryTitles];
    
    NSDictionary *data = [self createTestDataWithId:kRestaurantMenuID
                                 restaurantMenuName:kRestaurantMenuName
                                     menuCategories:menuCategories];
    
    DDRestaurantMenu *menu = [DDRestaurantMenuMapper restaurantMenuFromData:data];
    
    XCTAssertEqual(menu.menuCategories.count, self.restaurantMenuCategoryTitles.count);
}

- (void)testParsingORestaurantMenuCategoriesWhenInvalid {
    NSDictionary *data = [self createTestDataWithId:kRestaurantMenuID
                                 restaurantMenuName:nil
                                     menuCategories:nil];
    
    DDRestaurantMenu *menu = [DDRestaurantMenuMapper restaurantMenuFromData:data];
    
    XCTAssertEqual(menu.menuCategories.count, 0);
}

- (NSDictionary *)createTestDataWithId:(NSInteger)restaurantMenuID
                    restaurantMenuName:(NSString *)restaurantMenuName
                        menuCategories:(NSArray *)menuCategories {
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    
    if (restaurantMenuID > 0) {
        [data setObject:@(restaurantMenuID)
                 forKey:kRestaurantMenuIDKey];
    }
    
    if (restaurantMenuName.length > 0) {
        [data setObject:restaurantMenuName
                 forKey:kRestaurantMenuNameKey];
    }
    
    if (menuCategories.count > 0) {
        [data setObject:menuCategories
                 forKey:kRestaurantMenuCategoriesKey];
    }
    
    return data;
}

@end
