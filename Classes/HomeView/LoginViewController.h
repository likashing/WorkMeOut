//
//  ViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 20/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerCall.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate, ServerCallDelegate>


@property (strong, nonatomic) IBOutlet UINavigationItem *navigationBar;

@property (strong, nonatomic) IBOutlet UIView *viewTxtEmail;
@property (strong, nonatomic) IBOutlet UIView *viewTxtPassword;

@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
 
@property (strong, nonatomic) NSString *strEmail;
@property (strong, nonatomic) NSString *strPassword;



@property (strong, nonatomic) IBOutlet UILabel *lblForgot;
@property (strong, nonatomic) IBOutlet UILabel *lblLogin;
@property (strong, nonatomic) IBOutlet UIButton *btnForgotPW;
@property (strong, nonatomic) IBOutlet UIButton *btnSignup;





- (IBAction)onLoginClick:(id)sender;

- (IBAction)onBack:(id)sender;


@end

