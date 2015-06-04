//
//  ForgotViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 20/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface ForgotViewController : UIViewController <UITextFieldDelegate, ServerCallDelegate>

@property (strong, nonatomic) IBOutlet UINavigationItem *navigationBar;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@property (strong, nonatomic) IBOutlet UIView *viewTxtEmail;
@property (strong, nonatomic) IBOutlet UIView *viewTxtPhone;

@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPhoneNo;


@property (strong, nonatomic) IBOutlet UILabel *lblNote01;
@property (strong, nonatomic) IBOutlet UILabel *lblNote02;
@property (strong, nonatomic) IBOutlet UILabel *lblSubmit;


- (IBAction)onSubmitClick:(id)sender;

- (IBAction)onBack:(id)sender;



@end
