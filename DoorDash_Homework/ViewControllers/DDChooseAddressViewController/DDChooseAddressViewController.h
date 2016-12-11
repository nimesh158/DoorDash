//
//  DDChooseAddressViewController.h
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/11/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol DDChooseAddressViewControllerProtocol <NSObject>

- (void)didTapConfirmAddressButtonForAddress:(CLLocationCoordinate2D)address;

@end

@interface DDChooseAddressViewController : UIViewController

@property (nonatomic, weak) id<DDChooseAddressViewControllerProtocol> delegate;

@end
