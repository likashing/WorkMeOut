//
//  TreadmillEditViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 03/02/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "TreadmillEditViewController.h"

@interface TreadmillEditViewController ()

@end

@implementation TreadmillEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initComponents
{
    
}

- (IBAction)onSaveClick:(id)sender {
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onBackClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

/////////////////////=================////////////////////

#pragma mark UITextField Delegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _txtCalorie) {
        [_txtDistance becomeFirstResponder];
    } else if (textField == _txtDistance) {
        [_txtSpeed becomeFirstResponder];
    } else if (textField == _txtSpeed) {
        [_txtLapRep becomeFirstResponder];
    } else if (textField == _txtLapRep) {
        [_txtHrs becomeFirstResponder];
    } else if (textField == _txtHrs) {
        [_txtMins becomeFirstResponder];
    } else if (textField == _txtMins) {
        [_txtSec becomeFirstResponder];
    } else {
        [_txtSec resignFirstResponder];
    }
    
    
    return YES;
}






@end
