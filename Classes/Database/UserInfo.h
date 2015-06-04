//
//  UserInfo.h
//  WorkMeOut
//
//  Created by LiKaShing on 28/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (strong, nonatomic) NSString      *user_id;
@property (strong, nonatomic) NSString      *name;
@property (strong, nonatomic) NSString      *email;
@property (strong, nonatomic) NSString      *password;
@property (strong, nonatomic) NSString      *gender;
@property (strong, nonatomic) NSString      *birthday;
@property (strong, nonatomic) NSString      *user_age;
@property NSInteger     height;
@property NSInteger     weight;
@property (strong, nonatomic) NSString      *paid;

@property (strong, nonatomic) NSString      *device_token;






@end
