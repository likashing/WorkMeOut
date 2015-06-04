//
//  BuyaProgramViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface BuyaProgramViewController : UIViewController <UIAlertViewDelegate, UIActionSheetDelegate, ServerCallDelegate>


@property (strong, nonatomic) IBOutlet UIView *viewSelectProgram;
@property (strong, nonatomic) IBOutlet UIView *viewPayment;


@property (strong, nonatomic) IBOutlet UITextField *txtProgram;
@property (strong, nonatomic) IBOutlet UITextField *txtPayment;


//Hidden components
@property (strong, nonatomic) IBOutlet UILabel *lblDescripte1;
@property (strong, nonatomic) IBOutlet UILabel *lblDescripte2;
@property (strong, nonatomic) IBOutlet UILabel *lblDescripte3;

@property (strong, nonatomic) IBOutlet UILabel *lblApple;

@property (strong, nonatomic) IBOutlet UILabel *lblKNET01;
@property (strong, nonatomic) IBOutlet UILabel *lblKNET02;

@property (strong, nonatomic) IBOutlet UILabel *lblCode;
@property (strong, nonatomic) IBOutlet UIView *viewCode;





- (IBAction)onSelectProgram:(id)sender;
- (IBAction)onPaymentMethod:(id)sender;



- (IBAction)onSubmitClick:(id)sender;

- (IBAction)onBackClick:(id)sender;

@end
