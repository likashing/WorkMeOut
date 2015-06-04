//
//  SignUpViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 20/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "SignUpViewController.h"
#import "PickerSubView.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "SVProgressHUD.h"



#define currentMonth [currentMonthString integerValue]

@interface SignUpViewController ()

@end

@implementation SignUpViewController

@synthesize txtName, txtPassword, txtEmail;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLanguageChangeNotification:) name:kNotificationLanguageChanged object:nil];
    [self configureViewFromLocalisation];

    
    [self componentsFormat];
    
    [self customPickerFormat];

}

- (void) configureViewFromLocalisation
{
    _navigationBar.title = LOCALIZATION(@"Sign Up");
    
    txtName.placeholder = LOCALIZATION(@"Username");
    _txtPhone.placeholder = LOCALIZATION(@"Phone");
    txtEmail.placeholder = LOCALIZATION(@"Email");
    _txtGender.placeholder = LOCALIZATION(@"Gender");
    _txtDate.placeholder = LOCALIZATION(@"Date of birth");
    
    [_lblOptional setText:LOCALIZATION(@"Optional")];
    [_lblAccept setText:LOCALIZATION(@"I accept the ")];
    [_lblSubmit setText:LOCALIZATION(@"Submit")];
    
    [_btnTerm setTitle:LOCALIZATION(@"Terms") forState:UIControlStateNormal];
    
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationLanguageChanged object:nil];
}

- (void) receiveLanguageChangeNotification: (NSNotification *) notification
{
    if ([notification.name isEqualToString:kNotificationLanguageChanged]) {
        [self configureViewFromLocalisation];
    }
}



- (void) componentsFormat
{
//    txtName.text = @"LiKaShing Kimura";
//    txtEmail.text = @"ok0118@test.com";
//    txtPassword.text = @"idea";
//    //_txtGender.text = @"Male";
//    //_txtDate.text = @"1989/1/1";
//    _txtHeight.text = @"172";
//    _txtWeight.text = @"68";
    
    [self.scrollview setScrollEnabled:NO];
    user_age = 0;
    
    _viewTxtName.layer.cornerRadius = 5;
    _viewTxtPass.layer.cornerRadius = 5;
    _viewConfirmPass.layer.cornerRadius = 5;
    _viewPhone.layer.cornerRadius = 5;
    _viewTxtEmail.layer.cornerRadius = 5;
    _viewGender.layer.cornerRadius = 5;
    _viewBirth.layer.cornerRadius = 5;
    _viewTxtHeight.layer.cornerRadius = 5;
    _viewTxtWeight.layer.cornerRadius = 5;
    
    txtName.layer.cornerRadius = 5;
    txtEmail.layer.cornerRadius = 5;
    txtPassword.layer.cornerRadius = 5;
    
    _btnSubmit.selected = true;
    
    _scrollview.frame = CGRectMake(0, -20, SCRN_WIDTH, _scrollview.frame.size.height);
    _scrollview.contentSize = CGSizeMake(SCRN_WIDTH, self.view.frame.size.height + 100);

    
}


- (IBAction)onLoginClick:(id)sender {
    
    
    if ([txtName.text isEqualToString:@""] || [txtEmail.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please enter a your email and password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        return;
        
    } else {
        [self dataRequest];
    }
    
    
}


- (void) alertPickerViewShow
{
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"Select Gender" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Male", @"Female", nil];
    
    [actionsheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        _txtGender.text = @"Male";
    } else {
        _txtGender.text = @"Female";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dismissKeyboard
{
    [txtName resignFirstResponder];
    [txtPassword resignFirstResponder];
    [txtEmail resignFirstResponder];
    [_txtHeight resignFirstResponder];
    [_txtWeight resignFirstResponder];
}


- (IBAction)onSubmitClick:(id)sender {
    
    if (!_btnSubmit.selected) {
        if ([txtName.text isEqualToString:@""] || [txtEmail.text isEqualToString:@""] || [txtPassword.text isEqualToString:@""] || [_txtGender.text isEqualToString:@""] || [_txtDate.text isEqual:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please enter a your email and password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            return;
            
        } else {
            [self dataRequest];
        }
        
        [self dismissKeyboard];
        [_scrollview setContentOffset:CGPointMake(0, -80) animated:NO];

    }
    
    
}

- (IBAction)onGenderDown:(id)sender {
    
    [self dismissKeyboard];
    [self alertPickerViewShow];
    
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
                         self.txtDate.text = @"";
                         
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    _custompickerView.hidden = NO;
    self.customPicker.hidden = NO;
    self.toolbarCancelDone.hidden = NO;
    self.txtDate.text = @"";
    
}


- (IBAction)onCheckBtnClick:(id)sender {
    
    UIButton *btn = (UIButton *) sender;
    btn.selected = !btn.selected;
    
    _btnSubmit.selected = !_btnSubmit.selected;
    
}

- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == txtEmail || textField == _txtHeight || textField == _txtWeight) {
        [_scrollview setScrollEnabled:YES];
        [_scrollview setContentOffset:CGPointMake(0, 100) animated:YES];

    }
    return YES;
}


- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == txtName) {
        [txtPassword becomeFirstResponder];
    } else if (textField == txtPassword) {
        [txtEmail becomeFirstResponder];
    } else if (textField == txtEmail) {
        [_txtHeight becomeFirstResponder];
    } else if (textField == _txtHeight) {
        [_txtWeight becomeFirstResponder];
    } else if (textField == _txtWeight) {
        [_txtWeight resignFirstResponder];
    }
    
//    [txtName resignFirstResponder];
//    [txtPassword resignFirstResponder];
    
    return YES;
}

#pragma mark Custom DatePicker View Process Part

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
    self.txtDate.text = [NSString stringWithFormat:@"%@/%@/%@",[yearArray objectAtIndex:[self.customPicker selectedRowInComponent:0]],[monthArray objectAtIndex:[self.customPicker selectedRowInComponent:1]],[DaysArray objectAtIndex:[self.customPicker selectedRowInComponent:2]]];
    
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


////////////////////=============////////////////////
#pragma mark ProgressHUD part

- (void) showProgress:(NSString *)message
{
    [MBProgressHUD showHUDAddedTo:self.view text:message animated:YES];
}

- (void) hideProgress
{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
}



///////////////////////////====================//////////////////
#pragma mark ServerCallDelegate

- (void) dataRequest {
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    NSString *strSex;
    [SVProgressHUD show];
    if ([_txtGender.text isEqual:@"Male"]) {
        strSex = @"m";
    } else {
        strSex = @"f";
    }
    //[self showProgress:@"Please Wait"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: txtName.text, @"name", txtEmail.text, @"email", txtPassword.text, @"password", strSex, @"gender", _txtDate.text, @"birthdate", _txtHeight.text, @"height", _txtWeight.text, @"weight", APPDELEGATE.device_token, @"device_token", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"register"];
    
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    
    APPDELEGATE.userInfo.user_id    = [dictData objectForKey:@"id"];
    APPDELEGATE.userInfo.name       = [dictData objectForKey:@"name"];
    APPDELEGATE.userInfo.gender     = [dictData objectForKey:@"gender"];
    APPDELEGATE.userInfo.birthday   = [dictData objectForKey:@"birthdate"];
    APPDELEGATE.userInfo.user_age   = [NSString stringWithFormat:@"%d", user_age];
    APPDELEGATE.userInfo.height     = [[dictData objectForKey:@"height"] integerValue];
    APPDELEGATE.userInfo.weight     = [[dictData objectForKey:@"weight"] integerValue];
    
    
    [APPDELEGATE saveUserInfo];
    
    //[self hideProgress];
    [SVProgressHUD dismiss];
    
    [self performSegueWithIdentifier:@"goWelcome" sender:nil];
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Sign Up procedure failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}









@end
