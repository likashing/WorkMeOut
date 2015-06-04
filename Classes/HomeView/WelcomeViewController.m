//
//  WelcomeViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 20/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "WelcomeViewController.h"
#import "AppDelegate.h"
#import "MainMenuFreeView.h"
#import "MainMenuPaidView.h"




@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLanguageChangeNotification:) name:kNotificationLanguageChanged object:nil];
    [self configureViewFromLocalisation];
    
    [self initComponents];
    
    [self dataRequest];
    
}

- (void) configureViewFromLocalisation
{
    _navigationBar.title = LOCALIZATION(@"Welcome");
    [_lblManagedBy setText:LOCALIZATION(@"Managed By")];
    [_lblContinue setText:LOCALIZATION(@"Continue")];
}


- (void) initComponents
{
    
    self.navigationItem.hidesBackButton = YES;
    
    _viewCover.layer.cornerRadius = 5;
    
}


#pragma mark - Notification Methods

- (void) receiveLanguageChangeNotification: (NSNotification *) notification
{
    if ([notification.name isEqualToString:kNotificationLanguageChanged]) {
        [self configureViewFromLocalisation];
    }
}




- (IBAction)onContinueClick:(id)sender {
    
    [self navigationFunc];
    
}


#pragma mark - Memory Management
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationLanguageChanged object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


///////////////////////===================/////////////////////////
#pragma mark ActionSheet Delegate Process

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"Button at index: %ld clicked\nIt's title is '%@'", (long)buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
    if (buttonIndex == 0) {
        
        
        
    } else if (buttonIndex == 1) {
        
        
    } else {
        
        
    }
    
}

- (void) navigationFunc
{
    APPDELEGATE.member_kind = FREE_MEMBER;
    
    MainMenuFreeView *view = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMenuFreeView"];
    
    [self.navigationController pushViewController:view animated:YES];
}


///////////////////===============///////////////////
#pragma mark ServerCallDelegate

- (void) dataRequest {
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    [SVProgressHUD show];
    
    NSString *user_id = APPDELEGATE.userInfo.user_id;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", user_id, @"id", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_trainee"];
    
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    [SVProgressHUD dismiss];
    NSLog(@"%@", dictData);
    
    APPDELEGATE.userInfo.user_id    = [dictData objectForKey:@"id"];
    APPDELEGATE.userInfo.name       = [dictData objectForKey:@"name"];
    APPDELEGATE.userInfo.gender     = [dictData objectForKey:@"gender"];
    APPDELEGATE.userInfo.birthday   = [dictData objectForKey:@"birthdate"];
    
    APPDELEGATE.userInfo.height     = [[dictData objectForKey:@"height"] integerValue];
    APPDELEGATE.userInfo.weight     = [[dictData objectForKey:@"weight"] integerValue];
    APPDELEGATE.userInfo.paid       = [dictData objectForKey:@"paid"];
    
    [APPDELEGATE saveUserInfo];
   
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Get trainee failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}





@end
