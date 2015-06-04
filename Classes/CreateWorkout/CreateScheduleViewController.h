//
//  CreateScheduleViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface CreateScheduleViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate, UIAlertViewDelegate, ServerCallDelegate>



@property (strong, nonatomic) IBOutlet UIView *viewTxtDayName;
@property (strong, nonatomic) IBOutlet UIView *viewSpecific;



@property (strong, nonatomic) IBOutlet UITextField *txtDayName;
@property (strong, nonatomic) IBOutlet UITextField *txtSpecific;


@property (strong, nonatomic) IBOutlet UIButton *btnWorkDay;


- (IBAction)onSpecificClick:(id)sender;
- (IBAction)onAddExercisesClick:(id)sender;


- (IBAction)onBack:(id)sender;









@end
