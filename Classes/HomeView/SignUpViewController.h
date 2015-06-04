//
//  SignUpViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 20/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerCall.h"


@interface SignUpViewController : UIViewController <UIAlertViewDelegate,UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, ServerCallDelegate>
{
    
    NSMutableArray *yearArray;
    NSArray *monthArray;
    NSMutableArray *DaysArray;
        
    NSString *currentMonthString;
    
    int selectedYearRow;
    int selectedMonthRow;
    int selectedDayRow;
    
    int user_age;
    
    BOOL firstTimeLoad;
    
}


@property (strong, nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;


@property (strong, nonatomic) IBOutlet UIView *viewTxtName;
@property (strong, nonatomic) IBOutlet UIView *viewTxtPass;
@property (strong, nonatomic) IBOutlet UIView *viewConfirmPass;
@property (strong, nonatomic) IBOutlet UIView *viewPhone;
@property (strong, nonatomic) IBOutlet UIView *viewTxtEmail;
@property (strong, nonatomic) IBOutlet UIView *viewGender;
@property (strong, nonatomic) IBOutlet UIView *viewBirth;
@property (strong, nonatomic) IBOutlet UIView *viewTxtHeight;
@property (strong, nonatomic) IBOutlet UIView *viewTxtWeight;

@property (strong, nonatomic) IBOutlet UIPickerView *customPicker;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbarCancelDone;
@property (strong, nonatomic) IBOutlet UIView *custompickerView;


@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPhone;

@property (strong, nonatomic) IBOutlet UILabel *lblOptional;
@property (strong, nonatomic) IBOutlet UILabel *lblAccept;
@property (strong, nonatomic) IBOutlet UIButton *btnTerm;
@property (strong, nonatomic) IBOutlet UILabel *lblSubmit;

@property (strong, nonatomic) IBOutlet UITextField *txtGender;
@property (strong, nonatomic) IBOutlet UITextField *txtDate;
@property (strong, nonatomic) IBOutlet UITextField *txtHeight;
@property (strong, nonatomic) IBOutlet UITextField *txtWeight;

@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;



- (IBAction)onSubmitClick:(id)sender;

- (IBAction)onGenderDown:(id)sender;
- (IBAction)onDateDown:(id)sender;

- (IBAction)onCheckBtnClick:(id)sender;


- (IBAction)onBack:(id)sender;


- (IBAction)actionCancel:(id)sender;
- (IBAction)actionDone:(id)sender;



@end
