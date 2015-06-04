//
//  AppDelegate.h
//  WorkMeOut
//
//  Created by LiKaShing on 20/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Global.h"
#import "Localisator.h"
#import "ServerCall.h"
#import "UserInfo.h"
#import "ReceivedInfo.h"
#import "MBProgressHUD.h"
#import "SVProgressHUD.h"
//LiKaShing*
#import "SlideNavigationController.h"
#import "LeftMenuViewController.h"
//LiKaShing


@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;


@property (strong, nonatomic) ServerCall *serverCall;
@property (strong, nonatomic) UserInfo *userInfo;
@property (strong, nonatomic) ReceivedInfo *receivedInfo;

@property (strong, nonatomic) NSString *device_token;

@property (nonatomic, readwrite) BOOL isLoggedIn;

@property (strong, nonatomic) UIActivityIndicatorView *spinner;

@property MEMBER_KIND member_kind;
@property EXERCISE_ROUT exercise_rout;


@property (strong, nonatomic) NSMutableArray *arr_bodypart;
@property (strong, nonatomic) NSMutableArray *arr_activities;
@property (strong, nonatomic) NSMutableArray *arr_workouts;




@property (strong, nonatomic) NSMutableArray *arr_allergic;
@property (strong, nonatomic) NSMutableArray *arr_unwanted;


@property (strong, nonatomic) NSString *strHealthyCondition;


@property (strong, nonatomic) UIImage *imageBefore;
@property (strong, nonatomic) UIImage *imageAfter;

@property NSInteger     n_select_index;
@property NSInteger     nFrequency;

@property BOOL      bFavourite;


@property (strong, nonatomic) NSMutableArray *arr_recentlyExercises;
@property (strong, nonatomic) NSMutableArray *arr_favoriteExercises;



+ (AppDelegate*) sharedAppDelegate;

- (void) checkDeviceKind;
- (void) initVariables;

- (void) saveLoginInfo;
- (void) getLoginInfo;
- (void) saveUserInfo;
- (void) getUserInfo;
- (void) saveRecentlyExerciseList;
- (void) getRecentlyExerciseList;
- (void) saveFavoriteExerciseList;
- (void) getFavoriteExerciseList;

//- (void) saveTraineeProgramID;
//- (void) getTraineeProgramID;




@end

