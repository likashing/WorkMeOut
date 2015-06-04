//
//  EditProfileViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerCall.h"


@interface EditProfileViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource, ServerCallDelegate>
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



@property (strong, nonatomic) IBOutlet UIView *viewTxtName;
@property (strong, nonatomic) IBOutlet UIView *viewTxtGender;




@property (strong, nonatomic) IBOutlet UITextField *txtFullName;
@property (strong, nonatomic) IBOutlet UITextField *txtAge;
@property (strong, nonatomic) IBOutlet UITextField *txtHeight;
@property (strong, nonatomic) IBOutlet UITextField *txtWeight;
@property (strong, nonatomic) IBOutlet UITextField *txtGender;


@property (strong, nonatomic) NSString *strGender;


@property (strong, nonatomic) IBOutlet UIPickerView *customPicker;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbarCancelDone;
@property (strong, nonatomic) IBOutlet UIView *custompickerView;



- (IBAction)onGenderBtn:(id)sender;
- (IBAction)onDateDown:(id)sender;

- (IBAction)onSaveBtnClick:(id)sender;

- (IBAction)onBack:(id)sender;

@end
