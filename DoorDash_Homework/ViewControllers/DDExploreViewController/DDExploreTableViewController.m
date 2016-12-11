//
//  DDExploreTableViewController.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/11/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDExploreTableViewController.h"

#import "DDConstants.h"
#import "DDStore.h"
#import "DDStoreSearch.h"
#import "DDTableViewCell.h"

@interface DDExploreTableViewController ()

@property (nonatomic, strong) NSArray *stores;

@end

@implementation DDExploreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"DoorDash";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:255.0/255.0 green:26/255.0 blue:64/255.0 alpha:1.0]}];
    
    [self setUpNavigationBar];
    [self setUpTableView];
}

- (void)setUpNavigationBar {
    
}

- (void)setUpTableView {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([DDTableViewCell class])
                                bundle:nil];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:NSStringFromClass([DDTableViewCell class])];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stores.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DDTableViewCell class])
                                                            forIndexPath:indexPath];
    
    if (indexPath.row < self.stores.count) {
        DDStore *store = self.stores[indexPath.row];
        
        [self updateTableViewCell:cell withStore:store];
    }
    
    return cell;
}

- (void)updateTableViewCell:(DDTableViewCell *)cell
                  withStore:(DDStore *)store {
    [cell updateCellWithStoreName:store.storeName];
    [cell updateCellWithStoreType:store.storeDescription];
    
    NSString *deliveryCost;
    if (store.deliveryFee > kInvalidDeliveryFee) {
        deliveryCost = [NSString stringWithFormat:@"$%.2f delivery", store.deliveryFee];
    } else {
        deliveryCost = @"Free delivery";
    }
    [cell updateCellWithStoreDeliveryCost:deliveryCost];
    
    NSString *deliveryTime = [NSString stringWithFormat:@"%.0f min", store.minimumDeliveryTime];
    [cell updateCellWithStoreDeliveryTimeEstimate:deliveryTime];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - Public
- (void)updateControllerForLatitude:(CGFloat)latitude longitude:(CGFloat)longitude {
    DDStoreSearch *storeSearch = [[DDStoreSearch alloc] init];
    __weak typeof(self)weakSelf = self;
    __strong typeof(weakSelf) strongWeakSelf = weakSelf;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [storeSearch
         searchStoresInAreaWithLatitude:latitude
         longitude:longitude
         success:^(NSArray *stores) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 strongWeakSelf.stores = stores;
                 [strongWeakSelf.tableView reloadData];
             });
             
         }
         failure:^(NSError *error) {
             
         }];
    });
}

@end
