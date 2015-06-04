//
//  EditProfileViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "EditProfileViewController.h"
#import "AppDelegate.h"


#define currentMonth [currentMonthString integerValue]

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self componentsFormat];
    [self textFieldInit];
    
    [self customPickerFormat];
    
}

- (void) componentsFormat
{
    _viewTxtName.layer.cornerRadius = 5;
    _viewTxtGender.layer.cornerRadius = 5;
    
    _txtFullName.layer.cornerRadius = 5;
    _txtAge.layer.cornerRadius = 5;
    _txtHeight.layer.cornerRadius = 5;
    _txtWeight.layer.cornerRadius = 5;
    _txtGender.layer.cornerRadius = 5;
}

- (void) textFieldInit
{
    _txtFullName.text = APPDELEGATE.userInfo.name;
    //_txtAge.text = APPDELEGATE.userInfo.user_age;
    _txtHeight.text = [NSString stringWithFormat:@"%ld", (long)APPDELEGATE.userInfo.height];
    _txtWeight.text = [NSString stringWithFormat:@"%ld", (long)APPDELEGATE.userInfo.weight];
    
    if ([APPDELEGATE.userInfo.gender isEqual:@"m"]) {
        _txtGender.text = @"Male";
    } else {
        _txtGender.text = @"Female";
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


////////////////
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _txtAge) {
        [self showDateBirthDay];
    }
    
    return YES;
}
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _txtFullName) {
        [_txtAge becomeFirstResponder];
    } else if (textField == _txtAge) {
        [_txtHeight becomeFirstResponder];
    } else if (textField == _txtHeight) {
        [_txtWeight becomeFirstResponder];
    } else if (textField == _txtWeight) {
        [_txtWeight resignFirstResponder];
    }
    
    
    return YES;
}

- (void) showDateBirthDay
{
    [self dismissKeyboard];
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         _custompickerView.hidden = NO;
                         self.customPicker.hidden = NO;
                         self.toolbarCancelDone.hidden = NO;
                         self.txtAge.text = @"";
                         
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    _custompickerView.hidden = NO;
    self.customPicker.hidden = NO;
    self.toolbarCancelDone.hidden = NO;
    self.txtAge.text = @"";
}



- (void) dismissKeyboard
{
    [_txtFullName resignFirstResponder];
    [_txtHeight resignFirstResponder];
    [_txtWeight resignFirstResponder];
}

- (IBAction)onGenderBtn:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Gender" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Male", @"Female", nil];
    [actionSheet showInView:self.view];
    
}

- (IBAction)onDateDown:(id)sender {
    [self dismissKeyboard];
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         _custompickerView.hidden = NO;
                         self.customPicker.hidden = NO;
                         self.toolbarCancelDone.hidden = NO;
                         self.txtAge.text = @"";
                         
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    _custompickerView.hidden = NO;
    self.customPicker.hidden = NO;
    self.toolbarCancelDone.hidden = NO;
    self.txtAge.text = @"";

}

- (IBAction)onSaveBtnClick:(id)sender {
    
    [self dataRequest];
    
}

- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        _txtGender.text = @"Male";
        _strGender = @"m";
    } else if (buttonIndex == 1) {
        _txtGender.text = @"Female";
        _strGender = @"f";
    }
    
    
}

- (void) customPickerFormat
{
    firstTimeLoad = YES;
    _custompickerView.hidden = YES;
    self.customPicker.hidden = YES;
    self.toolbarCancelDone.hidden = YES;
    
    NSDate *date = [NSDate date];
    
    // Get Current Year
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    
    NSString *currentyearString = [NSString stringWithFormat:@"%@",
                                   [formatter stringFromDate:date]];
    
    
    // Get Current  Month
    
    [formatter setDateFormat:@"MM"];
    
    currentMonthString = [NSString stringWithFormat:@"%ld",(long)[[formatter stringFromDate:date]integerValue]];
    
    
    // Get Current  Date
    
    [formatter setDateFormat:@"d"];
    NSString *currentDateString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    
    
    // PickerView -  Years data
    
    yearArray = [[NSMutableArray alloc]init];
    
    
    for (int i = 1970; i <= 2050 ; i++)
    {
        [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
        
    }
    
    
    // PickerView -  Months data
    
    
    monthArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    
    // PickerView -  days data
    
    DaysArray = [[NSMutableArray alloc]init];
    
    for (int i = 1; i <= 31; i++)
    {
        [DaysArray addObject:[NSString stringWithFormat:@"%d",i]];
        
    }
    
    
    // PickerView - Default Selection as per current Date
    
    [self.customPicker selectRow:[yearArray indexOfObject:currentyearString] inComponent:0 animated:YES];
    
    [self.customPicker selectRow:[monthArray indexOfObject:currentMonthString] inComponent:1 animated:YES];
    
    [self.customPicker selectRow:[DaysArray indexOfObject:currentDateString] inComponent:2 animated:YES];
    
    
}

#pragma mark - UIPickerViewDelegate


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    if (component == 0)
    {
        selectedYearRow = row;
        [self.customPicker reloadAllComponents];
    }
    else if (component == 1)
    {
        selectedMonthRow = row;
        [self.customPicker reloadAllComponents];
    }
    else if (component == 2)
    {
        selectedDayRow = row;
        
        [self.customPicker reloadAllComponents];
        
    }
    
}


#pragma mark - UIPickerViewDatasource

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    
    // Custom View created for each component
    
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, 50, 60);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:15.0f]];
    }
    
    
    
    if (component == 0)
    {
        pickerLabel.text =  [yearArray objectAtIndex:row]; // Year
    }
    else if (component == 1)
    {
        pickerLabel.text =  [monthArray objectAtIndex:row];  // Month
    }
    else if (component == 2)
    {
        pickerLabel.text =  [DaysArray objectAtIndex:row]; // Date
        
    }
    
    return pickerLabel;
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 3;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0)
    {
        return [yearArray count];
        
    }
    else if (component == 1)
    {
        return [monthArray count];
    }
    else if (component == 2)
    { // day
        
        if (firstTimeLoad)
        {
            if (currentMonth == 1 || currentMonth == 3 || currentMonth == 5 || currentMonth == 7 || currentMonth == 8 || currentMonth == 10 || currentMonth == 12)
            {
                return 31;
            }
            else if (currentMonth == 2)
            {
                int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
                
                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                    
                    return 29;
                }
                else
                {
                    return 28; // or return 29
                }
                
            }
            else
            {
                return 30;
            }
            
        }
        else
        {
            
            if (selectedMonthRow == 0 || selectedMonthRow == 2 || selectedMonthRow == 4 || selectedMonthRow == 6 || selectedMonthRow == 7 || selectedMonthRow == 9 || selectedMonthRow == 11)
            {
                return 31;
            }
            else if (selectedMonthRow == 1)
            {
                int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
                
                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                    return 29;
                }
                else
                {
                    return 28; // or return 29
                }
                
                
                
            }
            else
            {
                return 30;
            }
            
        }
        
        
    }
    else if (component == 3)
    { // hour
        
        return 12;
        
    }
    else if (component == 4)
    { // min
        return 60;
    }
    else
    { // am/pm
        return 2;
        
    }
}



- (IBAction)actionCancel:(id)sender {
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         _custompickerView.hidden = YES;
                         self.customPicker.hidden = YES;
                         self.toolbarCancelDone.hidden = YES;
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                         
                     }];
    
    
}

- (IBAction)actionDone:(id)sender {
    self.txtAge.text = [NSString stringWithFormat:@"%@/%@/%@",[yearArray objectAtIndex:[self.customPicker selectedRowInComponent:0]],[monthArray objectAtIndex:[self.customPicker selectedRowInComponent:1]],[DaysArray objectAtIndex:[self.customPicker selectedRowInComponent:2]]];
    
    NSString *birthyear = [NSString stringWithFormat:@"%@", [yearArray objectAtIndex:[self.customPicker selectedRowInComponent:0]]];
    user_age = 2015 - [birthyear intValue];
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         _custompickerView.hidden = YES;
                         self.customPicker.hidden = YES;
                         self.toolbarCancelDone.hidden = YES;
                         
                     }
                     completion:^(BOOL finished){
                         
                         
                     }];
    
    
    
}



/////////////////////===================////////////////////////

#pragma mark ServerCallDelegate
- (void) dataRequest {
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    NSString *strid = APPDELEGATE.userInfo.user_id;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: strid, @"user_id", strid, @"id", _txtFullName.text, @"name", _txtGender.text, @"gender", _txtAge.text, @"birthdate", _txtHeight.text, @"height", _txtWeight.text, @"weight", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"update_basic_info"];
    
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    
    APPDELEGATE.userInfo.user_id    = [dictData objectForKey:@"id"];
    APPDELEGATE.userInfo.name       = [dictData objectForKey:@"name"];
    APPDELEGATE.userInfo.gender     = [dictData objectForKey:@"gender"];
    APPDELEGATE.userInfo.birthday   = [dictData objectForKey:@"birthdate"];
    APPDELEGATE.userInfo.height     = [[dictData objectForKey:@"height"] integerValue];
    APPDELEGATE.userInfo.weight     = [[dictData objectForKey:@"weight"] integerValue];
    APPDELEGATE.userInfo.paid       = [dictData objectForKey:@"paid"];
    
    [APPDELEGATE saveUserInfo];
       
}

- (void) OnConnectFail
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Operation failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}









@end
