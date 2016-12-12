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
#import "DDRestaurantMenuViewController.h"

@interface DDExploreTableViewController ()

@property (nonatomic, strong, readwrite) NSArray *stores;

@end

@implementation DDExploreTableViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigationBar];
    [self setUpTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setUpNavigationBarTitle];
}

- (void)setUpNavigationBar {
    [self setUpNavigationBarTitle];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav-address"]
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(leftBarButtonItemTapped)];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav-search"]
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(rightBarButtonItemTapped)];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)setUpNavigationBarTitle {
    self.navigationItem.title = @"DoorDash";
    
    NSDictionary *titleTextAttributes =  @{
                                           NSForegroundColorAttributeName : [UIColor colorWithRed:255.0/255.0 green:26/255.0 blue:64/255.0 alpha:1.0]
                                           };
    [self.navigationController.navigationBar setTitleTextAttributes: titleTextAttributes];
}

- (void)leftBarButtonItemTapped {
    if ([self.delegate respondsToSelector:@selector(didTapShowMaputton)]) {
        [self.delegate didTapShowMaputton];
    }
}

- (void)rightBarButtonItemTapped {
    if ([self.delegate respondsToSelector:@selector(didTapSearchButton)]) {
        [self.delegate didTapSearchButton];
    }
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
    return [self getDataSource].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DDTableViewCell class])
                                                            forIndexPath:indexPath];
    
    NSArray *dataSource = [self getDataSource];
    if (indexPath.row < dataSource.count) {
        DDStore *store = dataSource[indexPath.row];
        
        [self updateTableViewCell:cell
                      atIndexPath:indexPath
                        withStore:store];
    }
    
    return cell;
}

- (void)updateTableViewCell:(DDTableViewCell *)cell
                atIndexPath:(NSIndexPath *)indexPath
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
    
    __weak typeof(self)weakSelf = self;
    __strong typeof(weakSelf) strongWeakSelf = weakSelf;
    [store getStoreImageWithCompletion:^(UIImage *image) {
        [strongWeakSelf updateCellAtIndePath:indexPath
                                   withImage:image];
    }];
}

- (void)updateCellAtIndePath:(NSIndexPath *)indexPath withImage:(UIImage *)image {
    DDTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell updateCellWithStoreImage:image];
        });
    }
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    
    NSArray *dataSource = [self getDataSource];
    if (indexPath.row < dataSource.count) {
        DDStore *store = dataSource[indexPath.row];
        
        DDRestaurantMenuViewController *restaurantMenuViewController = [[DDRestaurantMenuViewController alloc] initWithStore:store];
        
        [self updateNavigationBarBackButton];
        
        [self.navigationController pushViewController:restaurantMenuViewController
                                             animated:YES];
    }
}

- (void)updateNavigationBarBackButton {
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
}

#pragma mark - Show Alert
- (void)showNoStoresAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No stores in your area"
                                                                             message:@"Please select another location"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [self dismissViewControllerAnimated:YES completion:nil];
                               }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}

#pragma mark - Public
- (NSArray *)getDataSource {
    return self.stores;
}

- (void)updateDataSource:(NSArray *)newDataSource {
    self.stores = newDataSource;
}

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
                 if (stores.count <= 0) {
                     [strongWeakSelf showNoStoresAlert];
                 }
                 [strongWeakSelf updateDataSource:stores];
                 [strongWeakSelf.tableView reloadData];
             });
             
         }
         failure:^(NSError *error) {
             [self showNoStoresAlert];
         }];
    });
}

@end
