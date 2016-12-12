//
//  DDRestaurantMenuViewController.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/11/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDRestaurantMenuViewController.h"

#import "DDConstants.h"
#import "DDStore.h"
#import "DDFavoriteStoresManager.h"
#import "DDRestaurantMenu.h"
#import "DDRestaurantMenuCategory.h"

@interface DDRestaurantMenuViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) DDStore *store;
@property (nonatomic, weak) IBOutlet UIImageView *restaurantImageView;
@property (nonatomic, weak) IBOutlet UILabel *deliveryTimeLabel;
@property (nonatomic, weak) IBOutlet UIButton *addToFavoritesButton;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *menuCategoryDataSource;

@end

@implementation DDRestaurantMenuViewController

- (instancetype)initWithStore:(DDStore *)store {
    self = [super initWithNibName:NSStringFromClass([self class])
                           bundle:nil];
    if (self) {
        _store = store;
        _menuCategoryDataSource = @[];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpButton];
    [self setUpImageView];
    [self updateMenuDataSource];
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setUpNavigationBar];
    [self updateUIForFavoritedStore];
}

- (void)updateMenuDataSource {
    __weak typeof(self)weakSelf = self;
    __strong typeof(weakSelf) strongWeakSelf = weakSelf;
    
    [self.store getStoreMenusWithCompletion:^(NSArray *menus, NSError *error) {
        if (error == nil && menus.count > 0) {
            DDRestaurantMenu *menu = menus[0]; //always taking the first one, for now
            strongWeakSelf.menuCategoryDataSource = menu.menuCategories;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongWeakSelf.tableView reloadData];
            });
        }
    }];
}

- (void)setUpImageView {
    self.restaurantImageView.layer.cornerRadius = 4;
    self.restaurantImageView.layer.masksToBounds = YES;
}

- (void)setUpButton {
    self.addToFavoritesButton.layer.cornerRadius = 4;
    self.addToFavoritesButton.layer.borderColor = [UIColor colorWithRed:255.0/255.0 green:26/255.0 blue:64/255.0 alpha:1.0].CGColor;
    self.addToFavoritesButton.layer.borderWidth = 1.0f;
}

- (void)setUpNavigationBar {
    self.navigationItem.title = self.store.storeName;
    
    NSDictionary *titleTextAttributes =  @{
                                           NSForegroundColorAttributeName : [UIColor blackColor]
                                           };
    [self.navigationController.navigationBar setTitleTextAttributes: titleTextAttributes];
}

#pragma mark - Update UI
- (void)updateUIForFavoritedStore {
    __weak typeof(self)weakSelf = self;
    __strong typeof(weakSelf) strongWeakSelf = weakSelf;
    
    [self.store getStoreImageWithCompletion:^(UIImage *image) {
        [strongWeakSelf.restaurantImageView setImage:image];
    }];
    
    NSString *deliveryCost;
    if (self.store.deliveryFee > kInvalidDeliveryFee) {
        deliveryCost = [NSString stringWithFormat:@"$%.2f delivery", self.store.deliveryFee];
    } else {
        deliveryCost = @"Free delivery";
    }
    
    [self.deliveryTimeLabel setText:deliveryCost];
    
    [[DDFavoriteStoresManager sharedInstance]
     isStoreCurrentlyFavorited:self.store
     withCompletion:^(BOOL currentlyFavorited) {
         dispatch_async(dispatch_get_main_queue(), ^{
             [self updateButtonStateForCurrentlyFavorited:currentlyFavorited];
         });
     }];
}

- (IBAction)addToFavoritesButtonTapped:(id)sender {
    DDStore *store = self.store;
    DDFavoriteStoresManager *manager = [DDFavoriteStoresManager sharedInstance];
    __weak typeof(manager) weakManager = manager;
    __weak typeof(self)weakSelf = self;
    
    [manager
    isStoreCurrentlyFavorited:store
     withCompletion:^(BOOL currentlyFavorited) {
         
         if (currentlyFavorited) {
             [weakManager
              removeStoreFromFavorites:store
              withCompletion:^(BOOL removedSuccessfully, NSError *error) {
                  if (removedSuccessfully) {
                      dispatch_async(dispatch_get_main_queue(), ^{
                          [weakSelf updateButtonStateForCurrentlyFavorited:NO];
                      });
                  }
              }];
         } else {
             [weakManager
              addStoreToFavorites:store
              withCompletion:^(BOOL addedSuccessfully, NSError *error) {
                  if (addedSuccessfully) {
                      dispatch_async(dispatch_get_main_queue(), ^{
                          [weakSelf updateButtonStateForCurrentlyFavorited:YES];
                      });
                  }
              }];
         }
     }];
}

- (void)updateButtonStateForCurrentlyFavorited:(BOOL)currentlyFavorited {
    CGFloat spacing = 0;
    
    if (currentlyFavorited) {
        [self.addToFavoritesButton setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:26/255.0 blue:64/255.0 alpha:1.0]];
        [self.addToFavoritesButton setImage:[UIImage imageNamed:@"star-white"]
                                   forState:UIControlStateNormal];
        [self.addToFavoritesButton setTitle:@"Favorited"
                                   forState:UIControlStateNormal];
        [self.addToFavoritesButton setTitleColor:[UIColor whiteColor]
                                        forState:UIControlStateNormal];
        spacing = 10;
    } else {
        [self.addToFavoritesButton setBackgroundColor:[UIColor whiteColor]];
        [self.addToFavoritesButton setImage:nil
                                   forState:UIControlStateNormal];
        [self.addToFavoritesButton setTitle:@"Add to Favorites"
                                   forState:UIControlStateNormal];
        [self.addToFavoritesButton setTitleColor:[UIColor colorWithRed:255.0/255.0 green:26/255.0 blue:64/255.0 alpha:1.0]
                                        forState:UIControlStateNormal];
    }
    self.addToFavoritesButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
    self.addToFavoritesButton.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuCategoryDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])
                                                            forIndexPath:indexPath];
    
    if (indexPath.row < self.menuCategoryDataSource.count) {
        DDRestaurantMenuCategory *menuCategory = self.menuCategoryDataSource[indexPath.row];
        
        [cell.textLabel setText:menuCategory.categoryTitle];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
}


@end
