//
//  TreadmillEditViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 03/02/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TreadmillEditViewController : UIViewController <UITextFieldDelegate>



@property (strong, nonatomic) IBOutlet UIView *viewCalorie;
@property (strong, nonatomic) IBOutlet UIView *viewDistance;
@property (strong, nonatomic) IBOutlet UIView *viewSpeed;
@property (strong, nonatomic) IBOutlet UIView *viewLapRep;


@property (strong, nonatomic) IBOutlet UITextField *txtCalorie;
@property (strong, nonatomic) IBOutlet UITextField *txtDistance;
@property (strong, nonatomic) IBOutlet UITextField *txtSpeed;
@property (strong, nonatomic) IBOutlet UITextField *txtLapRep;
@property (strong, nonatomic) IBOutlet UITextField *txtHrs;
@property (strong, nonatomic) IBOutlet UITextField *txtMins;
@property (strong, nonatomic) IBOutlet UITextField *txtSec;





- (IBAction)onSaveClick:(id)sender;
- (IBAction)onBackClick:(id)sender;


@end
