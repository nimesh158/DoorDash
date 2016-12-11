//
//  DDRestaurantMenuCategoryMapperTests.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDRestaurantMenuCategoryMapperTests.h"

#import "DDConstants.h"
#import "DDRestaurantMenuCategory.h"
#import "DDRestaurantMenuCategoryMapper.h"

static NSString * const kRestaurantMenuCategoryTitle = @"Sunday Brunch";

@interface DDRestaurantMenuCategoryMapperTests ()


@end

@implementation DDRestaurantMenuCategoryMapperTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testParsingOfRestaurantMenuCategoryTitleWhenValid {
    NSDictionary *data = [DDRestaurantMenuCategoryMapperTests createTestRestaurantMenuCategoryWithTitle:kRestaurantMenuCategoryTitle];
    
    DDRestaurantMenuCategory *menuCategory = [DDRestaurantMenuCategoryMapper restaurantMenuCategoryFromData:data];
    
    XCTAssertEqual(menuCategory.categoryTitle, kRestaurantMenuCategoryTitle);
}

- (void)testParsingOfRestaurantMenuCategoryTitleWhenInvalid {
    NSDictionary *data = [DDRestaurantMenuCategoryMapperTests createTestRestaurantMenuCategoryWithTitle:nil];
    
    DDRestaurantMenuCategory *menuCategory = [DDRestaurantMenuCategoryMapper restaurantMenuCategoryFromData:data];
    
    XCTAssertNil(menuCategory.categoryTitle);
}

+ (NSDictionary *)createTestRestaurantMenuCategoryWithTitle:(NSString *)title {
    if (title.length <= 0) {
        NSLog(@"Cannot create cateogyr for empty title");
        return nil;
    }
    
    return @{
             kRestaurantMenuTitleKey : title
             };
}

+ (NSArray *)createTestDataWithMenuCategoryTitles:(NSArray *)menuCategoryTitles {
    if (menuCategoryTitles.count == 0) {
        return nil;
    }
    
    NSMutableArray *menuCategories = [NSMutableArray arrayWithCapacity:menuCategoryTitles.count];
    
    for (NSInteger i = 0; i < menuCategoryTitles.count; i++) {
        NSString *title = [menuCategoryTitles objectAtIndex:i];
        NSDictionary *menuCategory = [DDRestaurantMenuCategoryMapperTests createTestRestaurantMenuCategoryWithTitle:title];
        [menuCategories addObject:menuCategory];
    }
    
    return menuCategories;
}

@end
