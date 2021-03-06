//
//  DDAPIClient.m
//  DoorDash_Homework
//
//  Created by Nimesh Desai on 12/10/16.
//  Copyright © 2016 Nimesh Desai. All rights reserved.
//

#import "DDAPIClient.h"

@implementation DDAPIClient

- (instancetype)initWithBaseURL:(NSURL *)baseURL {
    self = [super initWithBaseURL:baseURL];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", nil];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        [self.securityPolicy setAllowInvalidCertificates:NO];
        [self.securityPolicy setValidatesDomainName:NO];
        
    }
    
    return self;
}

@end
