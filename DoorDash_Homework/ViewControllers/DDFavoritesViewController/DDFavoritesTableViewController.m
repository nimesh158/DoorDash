//
//  DDFavoritesTableViewController.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/11/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDFavoritesTableViewController.h"

#import "DDFavoriteStoresManager.h"

@interface DDFavoritesTableViewController ()

@property (nonatomic, strong, readwrite) NSArray *favoriteStores;

@end

@implementation DDFavoritesTableViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self updateFavoriteStoresAndReloadData:NO];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateFavoriteStoresAndReloadData:YES];
}

- (void)updateFavoriteStoresAndReloadData:(BOOL)shouldReload {
    [[DDFavoriteStoresManager sharedInstance] getAllFavoritesWithCompletion:^(NSArray *stores) {
        self.favoriteStores = stores;
        
        if (shouldReload) {
            [self.tableView reloadData];
        }
    }];
}

- (NSArray *)getDataSource {
    return self.favoriteStores;
}

- (void)updateDataSource:(NSArray *)newDataSource {
    //should do nothing here, since we don't want super class's implementation
}

@end
