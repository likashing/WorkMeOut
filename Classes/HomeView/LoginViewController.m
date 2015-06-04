//
//  ViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 20/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "SVProgressHUD.h"
#import "NSData+Base64.h"
#import "MainMenuFreeView.h"
#import "MainMenuPaidView.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize txtEmail;
@synthesize txtPassword;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLanguageChangeNotification:) name:kNotificationLanguageChanged object:nil];
    [self configureViewFromLocalisation];
    
    [self textFieldFormat];
    
}

- (void) configureViewFromLocalisation
{
    _navigationBar.title = LOCALIZATION(@"Login");
    
    txtEmail.placeholder = LOCALIZATION(@"Username");
    [_lblLogin setText:LOCALIZATION(@"Login")];
    [_lblForgot setText:LOCALIZATION(@"Forgot")];
    //[ setText:LOCALIZATION(@"Login")];
    [_btnForgotPW setTitle:LOCALIZATION(@"Forgot Password ?") forState:UIControlStateNormal];
    [_btnSignup setTitle:LOCALIZATION(@"Sign Up") forState:UIControlStateNormal];
    
}


- (void) textFieldFormat
{
//    txtEmail.text = @"ok0118@test.com";
//    txtPassword.text = @"idea";
    
    _viewTxtEmail.layer.cornerRadius = 5;
    _viewTxtEmail.layer.borderColor = [UIColor grayColor].CGColor;
    _viewTxtEmail.layer.borderWidth = .3;
    
    _viewTxtPassword.layer.cornerRadius = 5;
    _viewTxtPassword.layer.borderColor = [UIColor grayColor].CGColor;
    _viewTxtPassword.layer.borderWidth = .3;
    
    txtEmail.layer.cornerRadius = 5;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == txtEmail) {
        [txtPassword becomeFirstResponder];
    } else if (textField == txtPassword) {
        [txtPassword resignFirstResponder];
    }
    
    return YES;
}



- (IBAction)onLoginClick:(id)sender {
    
    _strEmail = txtEmail.text;
    _strPassword = txtPassword.text;
    
    if ([_strEmail isEqualToString:@""] || [_strPassword isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning!" message:LOCALIZATION(@"Invalid email / password, please try again.") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        return;
        
    } else {
        //[self performSegueWithIdentifier:@"goWelcomeView" sender:nil];
        [self dataRequest];
    }
    
    
}

- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void) navigationFunc
{
    [APPDELEGATE getUserInfo];
    
    if ([APPDELEGATE.userInfo.paid isEqual:@"0"]) {
        APPDELEGATE.member_kind = FREE_MEMBER;
        
        MainMenuFreeView *view = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMenuFreeView"];
        
        [self.navigationController pushViewController:view animated:YES];
        
        
    } else if ([APPDELEGATE.userInfo.paid isEqual:@"1"]) {
        APPDELEGATE.member_kind = PAID_MEMBER;
        
        MainMenuPaidView *view = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMenuPaidView"];
        [self.navigationController pushViewController:view animated:YES];
        
    }

}

#pragma mark - Memory Management
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationLanguageChanged object:nil];
}


#pragma mark - Notification Methods

- (void) receiveLanguageChangeNotification: (NSNotification *) notification
{
    if ([notification.name isEqualToString:kNotificationLanguageChanged]) {
        [self configureViewFromLocalisation];
    }
}




////////////////////=============////////////////////
#pragma mark ProgressHUD part

- (void) showProgress:(NSString *)message
{
    [MBProgressHUD showHUDAddedTo:self.view text:message animated:YES];
}

- (void) hideProgress
{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
}


///////////////////===============///////////////////
#pragma mark ServerCallDelegate

- (void) dataRequest {
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    [SVProgressHUD show];
    //[self showProgress:@"Please Wait.."];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: _strEmail, @"username", _strPassword, @"password", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"login"];

}


- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    
    NSString *str_birth = [dictData objectForKey:@"birthdate"];
    NSString *str_age = [str_birth substringToIndex:4];
    int age = 2015 - [str_age intValue];
    
    
    APPDELEGATE.userInfo.user_id    = [dictData objectForKey:@"id"];
    APPDELEGATE.userInfo.name       = [dictData objectForKey:@"name"];
    APPDELEGATE.userInfo.gender     = [dictData objectForKey:@"gender"];
    APPDELEGATE.userInfo.birthday   = [dictData objectForKey:@"birthdate"];
    APPDELEGATE.userInfo.user_age   = [NSString stringWithFormat:@"%d", age];
    APPDELEGATE.userInfo.height     = [[dictData objectForKey:@"height"] integerValue];
    APPDELEGATE.userInfo.weight     = [[dictData objectForKey:@"weight"] integerValue];
    APPDELEGATE.userInfo.paid       = [NSString stringWithFormat:@"%@", [dictData objectForKey:@"paid"]];
    
    [APPDELEGATE saveUserInfo];
    
    APPDELEGATE.isLoggedIn = YES;
    [APPDELEGATE saveLoginInfo];
    
    [SVProgressHUD dismiss];
    
    [self navigationFunc];
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Login procedure failed!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}














@end
