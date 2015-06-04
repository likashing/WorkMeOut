//
//  EditSpecialViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "EditSpecialViewController.h"

@interface EditSpecialViewController ()

@end

@implementation EditSpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    bRequestSet = false;
    [self dataRequest];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (IBAction)tapGesture:(id)sender {
    
    [_txtViewNotes resignFirstResponder];
    
}

- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

////////////////////==============///////////////////////
#pragma mark UITextView Delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    
    bRequestSet = true;
    APPDELEGATE.receivedInfo.special_note = textView.text;
    [self dataRequest];
    
    
    return YES;
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


/////////////////////===================/////////////////////
#pragma mark ServerCallDelegate

- (void) dataRequest {
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    APPDELEGATE.serverCall.delegate = self;
    
    NSDictionary *dict;
    
    NSString *user_id = APPDELEGATE.userInfo.user_id;
    
    
    if (bRequestSet) {
        [self showProgress:@"Saving.."];
        
        dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", user_id, @"trainee_id", APPDELEGATE.receivedInfo.special_note, @"note", nil];
        
        [APPDELEGATE.serverCall requestServer:dict url:@"set_special_note"];
        
    } else {
        
        dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", user_id, @"trainee_id", nil];
        
        [APPDELEGATE.serverCall requestServer:dict url:@"get_special_note"];
        
    }
    
    NSLog(@"%@", dict);
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    
    if (bRequestSet) {
        NSLog(@"Special note set Ok,");
    } else {
        
        APPDELEGATE.receivedInfo.special_note = [dictData objectForKey:@"note"];
        
        NSLog(@"Special note get Ok,");
        
        _txtViewNotes.text = APPDELEGATE.receivedInfo.special_note;
    }
    
    [self hideProgress];
    
}

- (void) OnConnectFail
{
    [self hideProgress];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Operation failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

















@end
