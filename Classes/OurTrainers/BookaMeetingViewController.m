//
//  BookaMeetingViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "BookaMeetingViewController.h"
#import "MainMenuPaidView.h"


@interface BookaMeetingViewController ()

@end

@implementation BookaMeetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initComponents];
    
    [self hidenComponents];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initComponents
{
    _viewTime.layer.cornerRadius = 5;
    _viewAmPm.layer.cornerRadius = 5;
    _viewPayment.layer.cornerRadius = 5;
    
    _viewCode.layer.cornerRadius = 5;
}

- (void) hidenComponents
{
    _lblApple.hidden = YES;
    _lblKNET01.hidden = YES;
    _lblKNET02.hidden = YES;
    _lblCode.hidden = YES;
    
    _viewCode.hidden = YES;
}



- (IBAction)onTimeClick:(id)sender {
    
    
}

- (IBAction)onAmPm:(id)sender {
    [_txtTime resignFirstResponder];
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"AM", @"PM", nil];
    action.tag = 2;
    [action showInView:self.view];
    
}

- (IBAction)onPayMethod:(id)sender {
    [_txtTime resignFirstResponder];

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"- Payment Method - " delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Apple Store", @"KNET", @"Code", nil];
    actionSheet.tag = 3;
    [actionSheet showInView:self.view];
    
}



- (IBAction)onSubmitClick:(id)sender {
    
    [self dataRequest];
}

- (void) showAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!!" message:[NSString stringWithFormat:@"Payment done successfully.\n Your meeting is booked with:\n\n Trainer: Jaber M\n Time: %@ %@ on mm/dd/yy", _txtTime.text, _txtAmPm.text] delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
    [alert show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        [self performSegueWithIdentifier:@"goPiadMenu" sender:nil];
    }
}

- (IBAction)onBackClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//////////////////////==================////////////////////////
#pragma mark UITextField Delegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [_txtTime resignFirstResponder];
    
    return YES;
}



#pragma mark UIActionSheet Delegate

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1) {
        
    } else if (actionSheet.tag == 2) {
        if (buttonIndex == 0) {
            _txtAmPm.text = @"AM";
        } else {
            _txtAmPm.text = @"PM";
        }
        
    } else if (actionSheet.tag == 3) {
        if (buttonIndex == 0) {
            _txtPayMethod.text = @"Apple Store";
            
            [self hidenComponents];
            _lblApple.hidden = NO;
            
        } else if (buttonIndex == 1) {
            _txtPayMethod.text = @"KNET";
            
            [self hidenComponents];
            _lblKNET01.hidden = NO;
            _lblKNET02.hidden = NO;
        } else {
            _txtPayMethod.text = @"Code";
            
            [self hidenComponents];
            _lblCode.hidden = NO;
            _viewCode.hidden = NO;
        }
        
    }
    
}




///////////////////=================///////////////////////

#pragma mark ServerCallDelegate
- (void) dataRequest {
    
    [SVProgressHUD show];
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    NSString *strID = APPDELEGATE.userInfo.user_id;
    NSString *strStatus = @"f";
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: strID, @"user_id", strID, @"id", strStatus, @"status", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"update_trainee_pay_status"];
    
    
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    [SVProgressHUD dismiss];
    NSLog(@"%@", dictData);
    
    [self showAlert];
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Operation failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}









@end
