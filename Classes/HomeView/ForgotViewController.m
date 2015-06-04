//
//  ForgotViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 20/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "ForgotViewController.h"

@interface ForgotViewController ()

@end

@implementation ForgotViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLanguageChangeNotification:) name:kNotificationLanguageChanged object:nil];
    [self configureViewFromLocalisation];
    
    [self textFieldFormat];
    
}

- (void) configureViewFromLocalisation
{
    _navigationBar.title = LOCALIZATION(@"Sign Up");
    [_lblNote01 setText: LOCALIZATION(@"forgot_alert01")];
    [_lblNote02 setText: LOCALIZATION(@"forgot_alert02")];
    _txtPhoneNo.placeholder = LOCALIZATION(@"Phone");
    _txtEmail.placeholder = LOCALIZATION(@"Email");
    
    [_lblSubmit setText:LOCALIZATION(@"Submit")];
    
}


- (void) textFieldFormat
{
    [self.scrollview setScrollEnabled:NO];
    _scrollview.frame = CGRectMake(0, -20, SCRN_WIDTH, _scrollview.frame.size.height);
    _scrollview.contentSize = CGSizeMake(SCRN_WIDTH, self.view.frame.size.height + 100);
    
    _viewTxtEmail.layer.cornerRadius = 5;
    _viewTxtPhone.layer.cornerRadius = 5;
    
    _txtEmail.layer.cornerRadius = 5;
    _txtPhoneNo.layer.cornerRadius = 5;
    
    
}



- (IBAction)onSubmitClick:(id)sender {
    [self dataRequest];
    [_txtEmail resignFirstResponder];
    [_txtPhoneNo resignFirstResponder];
    
    [_scrollview setContentOffset:CGPointMake(0, -60) animated:NO];
}

- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Notification methods

- (void) receiveLanguageChangeNotification: (NSNotification *)notification
{
    if ([notification.name isEqualToString:kNotificationLanguageChanged]) {
        [self configureViewFromLocalisation];
    }
}


#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationLanguageChanged object:nil];
}

/////////////////////==================/////////////////////////
#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _txtEmail) {
        [_txtPhoneNo becomeFirstResponder];
    } else {
        [_txtPhoneNo resignFirstResponder];
    }
    
    return YES;
}



- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _txtPhoneNo) {
        [_scrollview setScrollEnabled:YES];
        [_scrollview setContentOffset:CGPointMake(0, 60) animated:YES];
        
    }
    
    return YES;
}




///////////////////===============///////////////////
#pragma mark ServerCallDelegate

- (void) dataRequest {
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    [SVProgressHUD show];
    //[self showProgress:@"Please Wait.."];
    
    NSString *user_id = APPDELEGATE.userInfo.user_id;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", _txtEmail, @"email", _txtPhoneNo, @"phone", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"reset_password"];
    
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    
    NSString *str = [dictData objectForKey:@"id"];
    
    APPDELEGATE.userInfo.user_id = str;
    //[APPDELEGATE saveUserInfo];
    
    //[self hideProgress];
    [SVProgressHUD dismiss];
    
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Forgot password procedure failed!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}





@end
