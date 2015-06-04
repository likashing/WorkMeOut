//
//  BuyaProgramViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "BuyaProgramViewController.h"

@interface BuyaProgramViewController ()

@end

@implementation BuyaProgramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initComponents];
    
    [self hiddenProgaramDescripte];
    [self hiddenPaymethodComponents];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initComponents
{
    _viewSelectProgram.layer.cornerRadius = 5;
    _viewPayment.layer.cornerRadius = 5;
    
    _viewCode.layer.cornerRadius = 5;
    
}

- (void) hiddenProgaramDescripte
{
    _lblDescripte1.hidden = YES;
    _lblDescripte2.hidden = YES;
    _lblDescripte3.hidden = YES;
    
}

- (void) hiddenPaymethodComponents
{
    _lblApple.hidden = YES;
    _lblKNET01.hidden = YES;
    _lblKNET02.hidden = YES;
    _lblCode.hidden = YES;
    
    _viewCode.hidden = YES;
}

- (IBAction)onSelectProgram:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"- Select Program -" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Bulk/Mass(Cost-$1)", @"Weight Loss(Cost-$1)", @"Cut/Fit(Cost-$1)",  nil];
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
}

- (IBAction)onPaymentMethod:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"- Payment Method - " delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Apple Store", @"KNET", @"Code", nil];
    actionSheet.tag = 2;
    [actionSheet showInView:self.view];
}


- (IBAction)onSubmitClick:(id)sender {
    
    [self dataRequest];
}

- (void) showAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!!" message:@"Payment done successfully.\n Your program is booked with:\n\n Trainer: Jaber M\n\n It will take up to four days for your schedule to be ready and appear in your profile." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
    [alert show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        [self performSegueWithIdentifier:@"goPaidMenu" sender:nil];
    }
}



- (IBAction)onBackClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark UIActionSheet Delegate

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1) {
        if (buttonIndex == 0) {
            _txtProgram.text = @"Bulk/Mass(Cost-$1)";
            
            [self hiddenProgaramDescripte];
            _lblDescripte1.hidden = NO;
            
        } else if (buttonIndex == 1) {
            _txtProgram.text = @"Weight Loss(Cost-$1)";
            
            [self hiddenProgaramDescripte];
            _lblDescripte2.hidden = NO;
        } else {
            _txtProgram.text = @"Cut/Fit(Cost-$1)";
            
            [self hiddenProgaramDescripte];
            _lblDescripte3.hidden = NO;
        }

    }  else if (actionSheet.tag == 2) {
        if (buttonIndex == 0) {
            _txtPayment.text = @"Apple Store";
            
            [self hiddenPaymethodComponents];
            _lblApple.hidden = NO;
            
        } else if (buttonIndex == 1) {
            _txtPayment.text = @"KNET";
            
            [self hiddenPaymethodComponents];
            _lblKNET01.hidden = NO;
            _lblKNET02.hidden = NO;

        } else {
            _txtPayment.text = @"Code";
            
            [self hiddenPaymethodComponents];
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
    NSString *strStatus = @"p";
    
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
