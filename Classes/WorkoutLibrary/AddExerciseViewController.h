//
//  LegPushEditViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 03/02/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface AddExerciseViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate, ServerCallDelegate>



@property (strong, nonatomic) IBOutlet UIView *viewSet1;
@property (strong, nonatomic) IBOutlet UIView *viewSet2;
@property (strong, nonatomic) IBOutlet UIView *viewSet3;

@property (strong, nonatomic) IBOutlet UITextField *txtSet1;
@property (strong, nonatomic) IBOutlet UITextField *txtSet2;
@property (strong, nonatomic) IBOutlet UITextField *txtSet3;





- (IBAction)onSaveClick:(id)sender;

- (IBAction)onBackClick:(id)sender;



@end
