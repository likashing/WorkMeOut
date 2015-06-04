//
//  BookaMeetingViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"



@interface BookaMeetingViewController : UIViewController <UIAlertViewDelegate, UIActionSheetDelegate, UITextFieldDelegate, ServerCallDelegate>



@property (strong, nonatomic) IBOutlet UIView *viewTime;
@property (strong, nonatomic) IBOutlet UIView *viewAmPm;
@property (strong, nonatomic) IBOutlet UIView *viewPayment;

@property (strong, nonatomic) IBOutlet UITextField *txtTime;
@property (strong, nonatomic) IBOutlet UITextField *txtAmPm;
@property (strong, nonatomic) IBOutlet UITextField *txtPayMethod;


//hidden components
@property (strong, nonatomic) IBOutlet UILabel *lblApple;

@property (strong, nonatomic) IBOutlet UILabel *lblKNET01;
@property (strong, nonatomic) IBOutlet UILabel *lblKNET02;

@property (strong, nonatomic) IBOutlet UILabel *lblCode;
@property (strong, nonatomic) IBOutlet UIView *viewCode;


- (IBAction)onTimeClick:(id)sender;
- (IBAction)onAmPm:(id)sender;
- (IBAction)onPayMethod:(id)sender;

- (IBAction)onSubmitClick:(id)sender;

- (IBAction)onBackClick:(id)sender;

@end
