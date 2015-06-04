//
//  AppDelegate.m
//  WorkMeOut
//
//  Created by LiKaShing on 20/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize arr_recentlyExercises;

+ (AppDelegate*) sharedAppDelegate {
    
    return (AppDelegate *) [UIApplication sharedApplication].delegate;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //LiKaShing*
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iphone6"
                                                             bundle: nil];
    
    LeftMenuViewController *leftMenu = (LeftMenuViewController*)[mainStoryboard
                                                                 instantiateViewControllerWithIdentifier: @"LeftMenuViewController"];
    
    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
    [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .18;
    
    //    // Creating a custom bar button for right menu
    //    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    //    [button setImage:[UIImage imageNamed:@"gear"] forState:UIControlStateNormal];
    //    [button addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    //    [SlideNavigationController sharedInstance].rightBarButtonItem = rightBarButtonItem;
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidClose object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Closed %@", menu);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidOpen object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Opened %@", menu);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidReveal object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Revealed %@", menu);
    }];
    
    //LiKaShing

    [self checkDeviceKind];
    [self initVariables];

    [self getLoginInfo];
    [self getUserInfo];
    
    return YES;
}

- (void) checkDeviceKind
{
    UIStoryboard *storyboard;
    CGSize result = [[UIScreen mainScreen] bounds].size;
    CGFloat scale = [UIScreen mainScreen].scale;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        result = CGSizeMake(result.width * scale, result.height * scale);
        
        //if (result.height == 960) {
            storyboard = [UIStoryboard storyboardWithName:@"Main_iphone6" bundle:nil]; //maybe replace
            UIViewController *initViewController = [storyboard instantiateInitialViewController];
            [self.window setRootViewController:initViewController];
        //}
    }
}



- (void) initVariables
{
    
    [[UINavigationBar appearance] setAlpha:0.2f];
    
    _device_token = @"3c775c6f947d198b7a6b4201860ce00677d288ba4f181ad7849c2a1c7988d7cf";
    
    _n_select_index = 0;
    _nFrequency = 0;
    
    
    _arr_bodypart = [[NSMutableArray alloc] init];
    _arr_allergic = [[NSMutableArray alloc] init];
    _arr_unwanted = [[NSMutableArray alloc] init];
    _arr_workouts = [[NSMutableArray alloc] init];
    
//    arr_recentlyExercises = [[NSMutableArray alloc] init];
//    _arr_favoriteExercises = [[NSMutableArray alloc] init];
    
    
    _userInfo = [[UserInfo alloc] init];
    _receivedInfo = [[ReceivedInfo alloc] init];
    
    //_receivedInfo.trainee_program_id = 22;
    
    _receivedInfo.arrAllergic = [[NSMutableArray alloc] init];
    
    _strHealthyCondition = @"Very healthy";
    
}



- (void) saveLoginInfo
{
    NSUserDefaults *userDefauls = [NSUserDefaults standardUserDefaults];
    
    [userDefauls setObject:[NSNumber numberWithBool:_isLoggedIn] forKey:@"isLoggedIn"];
    
    [userDefauls synchronize];
    
}

- (void) getLoginInfo
{
    NSUserDefaults *userDefauls = [NSUserDefaults standardUserDefaults];
    
    _isLoggedIn = [[userDefauls objectForKey:@"isLoggedIn"] boolValue];
    
}


- (void) saveUserInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:_userInfo.user_id forKey:@"user_id"];
    [userDefaults setObject:_userInfo.name forKey:@"name"];
    [userDefaults setObject:_userInfo.email forKey:@"email"];
    [userDefaults setObject:_userInfo.password forKey:@"password"];
    [userDefaults setObject:_userInfo.gender forKey:@"gender"];
    [userDefaults setObject:_userInfo.birthday forKey:@"birthday"];
    [userDefaults setObject:_userInfo.user_age forKey:@"user_age"];
    [userDefaults setObject:[NSNumber numberWithInteger: _userInfo.height] forKey:@"height"];
    [userDefaults setObject:[NSNumber numberWithInteger: _userInfo.weight] forKey:@"weight"];
    [userDefaults setObject:_userInfo.paid forKey:@"paid"];
    [userDefaults setObject:_userInfo.device_token forKey:@"device_token"];
    
    [userDefaults synchronize];
}

- (void) getUserInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    _userInfo.user_id       = [userDefaults objectForKey:@"user_id"];
    _userInfo.name          = [userDefaults objectForKey:@"name"];
    _userInfo.email         = [userDefaults objectForKey:@"email"];
    _userInfo.password      = [userDefaults objectForKey:@"password"];
    _userInfo.gender        = [userDefaults objectForKey:@"gender"];
    _userInfo.birthday      = [userDefaults objectForKey:@"birthday"];
    _userInfo.user_age      = [userDefaults objectForKey:@"user_age"];
    _userInfo.height        = [[userDefaults objectForKey:@"height"] integerValue];
    _userInfo.weight        = [[userDefaults objectForKey:@"weight"] integerValue];
    _userInfo.paid          = [userDefaults objectForKey:@"paid"];
    _userInfo.device_token  = [userDefaults objectForKey:@"device_token"];
    
    
}


- (void) saveRecentlyExerciseList
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:arr_recentlyExercises forKey:@"RecentlyExercises"];
    
    [userDefaults synchronize];
    
}

- (void) getRecentlyExerciseList
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [arr_recentlyExercises removeAllObjects];
    NSArray *array = [userDefaults objectForKey:@"RecentlyExercises"];
    
    for (NSDictionary *dict in array)
        [arr_recentlyExercises addObject:dict];
    
}

- (void) saveFavoriteExerciseList
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:_arr_favoriteExercises forKey:@"FavoriteExercises"];
    
    [userDefaults synchronize];
}

- (void) getFavoriteExerciseList
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [_arr_favoriteExercises removeAllObjects];
    NSArray *array = [userDefaults objectForKey:@"FavoriteExercises"];
    
    for (NSDictionary *dict in array)
        [_arr_favoriteExercises addObject:dict];
    
}


//- (void) saveTraineeProgramID
//{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    
//    [userDefaults setObject:[NSNumber numberWithInteger:self.receivedInfo.trainee_program_id] forKey:@"TraineeProgramID"];
//    
//    [userDefaults synchronize];
//    
//}
//
//- (void) getTraineeProgramID
//{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    
//    self.receivedInfo.trainee_program_id = [[userDefaults objectForKey:@"TraineeProgramID"] integerValue];;
//    
//    
//}
//






- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"get token");
    _device_token = [[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@",_device_token);
    
    
    //    [[NSUserDefaults standardUserDefaults]setValue:tokenString forKey:@"DeviceToken"];
    //    [[NSUserDefaults standardUserDefaults] synchronize];
}








- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





@end
