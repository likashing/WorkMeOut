//
//  EditProgramViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "EditProgramViewController.h"

@interface EditProgramViewController ()

@end

@implementation EditProgramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) componentsFormat
{
    [_scrollview setScrollEnabled:NO];
    
    _viewTxtProgram.layer.cornerRadius = 5;
    _viewDifficulty.layer.cornerRadius = 5;
    _viewType.layer.cornerRadius = 5;
    _viewFrequency.layer.cornerRadius = 5;
    
    _txtProgram.layer.cornerRadius = 5;
    _txtViewProgram.layer.cornerRadius = 5;
    
    _scrollview.frame = CGRectMake(0, -20, SCRN_WIDTH, _scrollview.frame.size.height);
    _scrollview.contentSize = CGSizeMake(SCRN_WIDTH, self.view.frame.size.height + 100);
    
}
- (void) dismissKeyboard
{
    [_txtProgram resignFirstResponder];
    [_txtViewProgram resignFirstResponder];
    [_scrollview setContentOffset:CGPointMake(0, -80) animated:NO];
    
    //[_scrollview setScrollEnabled:NO];
    
    
}
- (IBAction)onDifficultyClick:(id)sender {
    [_txtProgram resignFirstResponder];
    [_txtViewProgram resignFirstResponder];
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Difficulty" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Beginner", @"Intermediate", @"Advanced", nil];
    sheet.tag = 111;
    [sheet showInView:self.view];
    
}

- (IBAction)onTypeClick:(id)sender {
    [_txtProgram resignFirstResponder];
    [_txtViewProgram resignFirstResponder];
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Type" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"General Fitness", @"Bulking", @"Cutting", @"Sport Specific", nil];
    sheet.tag = 222;
    [sheet showInView:self.view];
}

- (IBAction)onFrequencyClick:(id)sender {
    [_txtProgram resignFirstResponder];
    [_txtViewProgram resignFirstResponder];
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Frequency" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"1day(s) a week", @"2day(s) a week", @"3day(s) a week",@"4day(s) a week",@"5day(s) a week",@"6day(s) a week",@"7day(s) a week", nil];
    sheet.tag = 333;
    [sheet showInView:self.view];
}

- (IBAction)onCreateSchedule:(id)sender {
    
    [self dismissKeyboard];
    
    [self dataRequest];
    //[self performSegueWithIdentifier:@"goNext" sender:nil];
}

- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
////////////////////================/////////////////////
#pragma mark UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 111) {
        if (buttonIndex == 0) {
            _txtDifficulty.text = @"Beginner";
            
        } else if (buttonIndex == 1) {
            _txtDifficulty.text = @"Intermediate";
            
        } else if (buttonIndex == 2) {
            _txtDifficulty.text = @"Advanced";
            
        }
    } else if (actionSheet.tag == 222) {
        if (buttonIndex == 0) {
            _txtType.text = @"General Fitness";
            
        } else if (buttonIndex == 1) {
            _txtType.text = @"Bulking";
            
        } else if (buttonIndex == 2) {
            _txtType.text = @"Cutting";
            
        } else if (buttonIndex == 3) {
            _txtType.text = @"Sport Specific";
        }
        
    } else if (actionSheet.tag == 333) {
        if (buttonIndex == 0) {
            _txtFrequency.text = @"1day(s) a week";
            
        } else if (buttonIndex == 1) {
            _txtFrequency.text = @"2day(s) a week";
        } else if (buttonIndex == 2) {
            _txtFrequency.text = @"3day(s) a week";
        } else if (buttonIndex == 3) {
            _txtFrequency.text = @"4day(s) a week";
        } else if (buttonIndex == 4) {
            _txtFrequency.text = @"5day(s) a week";
        } else if (buttonIndex == 5) {
            _txtFrequency.text = @"6day(s) a week";
        } else if (buttonIndex == 6) {
            _txtFrequency.text = @"7day(s) a week";
        }
        
    }
}

////////////////////////////================//////////////////
#pragma mark UITextField and UITextView Delegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _txtProgram) {
        [_txtProgram resignFirstResponder];
    } else {
        //[self dismissKeyboard];
    }
    
    return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    [_scrollview setScrollEnabled:YES];
    [_scrollview setContentOffset:CGPointMake(0, 100) animated:YES];
    
    return YES;
}

- (BOOL) textViewShouldEndEditing:(UITextView *)textView
{
    [self dismissKeyboard];
    
    return YES;
}



////////////////////////=====================////////////////
#pragma mark ServerCallDelegate
- (void) dataRequest {
    NSString *str_id = APPDELEGATE.userInfo.user_id;
    [SVProgressHUD show];
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: str_id, @"user_id", str_id, @"trainee_id", _txtProgram.text, @"name", _txtDifficulty.text, @"difficulty", _txtType.text, @"type", _txtFrequency.text, @"frequency", _txtViewProgram.text, @"description", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"add_workout_program"];
    
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    [SVProgressHUD dismiss];
    
    NSLog(@"%@", dictData);
    
    APPDELEGATE.receivedInfo.trainee_program_id   = [dictData objectForKey:@"id"];
    APPDELEGATE.receivedInfo.frequency       = [dictData objectForKey:@"frequency"];
    
    [self performSegueWithIdentifier:@"goNext" sender:nil];
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Operation failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}



@end
