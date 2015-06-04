//
//  CreateProgramViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"



@interface CreateProgramViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, ServerCallDelegate, UIActionSheetDelegate, UIAlertViewDelegate>


@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@property (strong, nonatomic) IBOutlet UIView *viewTxtProgram;
@property (strong, nonatomic) IBOutlet UIView *viewDifficulty;
@property (strong, nonatomic) IBOutlet UIView *viewType;
@property (strong, nonatomic) IBOutlet UIView *viewFrequency;


@property (strong, nonatomic) IBOutlet UITextField *txtProgram;
@property (strong, nonatomic) IBOutlet UITextField *txtDifficulty;
@property (strong, nonatomic) IBOutlet UITextField *txtType;
@property (strong, nonatomic) IBOutlet UITextField *txtFrequency;

@property (strong, nonatomic) IBOutlet UITextView *txtViewProgram;





- (IBAction)onDifficultyClick:(id)sender;
- (IBAction)onTypeClick:(id)sender;
- (IBAction)onFrequencyClick:(id)sender;



- (IBAction)onCreateSchedule:(id)sender;

- (IBAction)onBack:(id)sender;

@end
