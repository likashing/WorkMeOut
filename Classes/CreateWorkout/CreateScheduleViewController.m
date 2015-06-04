//
//  CreateScheduleViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "CreateScheduleViewController.h"

@interface CreateScheduleViewController ()

@end

@implementation CreateScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self componentsFormat];
    
}

- (void) componentsFormat
{
    _viewTxtDayName.layer.cornerRadius = 5;
    _viewSpecific.layer.cornerRadius = 5;
    
    _txtDayName.layer.cornerRadius = 5;
       
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    [_txtDayName resignFirstResponder];
    
    return YES;
}



- (IBAction)onSpecificClick:(id)sender {
    
    [_txtDayName resignFirstResponder];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Select a Workout day" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"No specific day", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday", nil];
    [sheet showInView:self.view];
}

- (IBAction)onAddExercisesClick:(id)sender {
    
    [self dataRequest];
    
}


- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

////////////////////////===============////////////////////////
#pragma mark UIActionSheet Delegate

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        _txtSpecific.text = @"No specific day";
        
    } else if (buttonIndex == 1) {
        _txtSpecific.text = @"Monday";
        
    } else if (buttonIndex == 2) {
        _txtSpecific.text = @"Tuesday";
        
    } else if (buttonIndex == 3) {
        _txtSpecific.text = @"Wednesday";
        
    } else if (buttonIndex == 4) {
        _txtSpecific.text = @"Thursday";
        
    } else if (buttonIndex == 5) {
        _txtSpecific.text = @"Friday";
    } else if (buttonIndex == 6) {
        _txtSpecific.text = @"Saturday";
    } else if (buttonIndex == 7) {
        _txtSpecific.text = @"Sunday";
    }
}


/////////////////////////==============////////////////////
#pragma mark ServerCallDelegate
- (void) dataRequest {
    [SVProgressHUD show];
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: APPDELEGATE.userInfo.user_id, @"user_id", APPDELEGATE.receivedInfo.trainee_program_id, @"trainee_program_id", _txtDayName.text, @"title", _txtSpecific.text, @"weekday", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"add_workout_day"];
    
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    
    APPDELEGATE.receivedInfo.workout_day_id   = [dictData objectForKey:@"id"];
    APPDELEGATE.receivedInfo.weekday       = [dictData objectForKey:@"weekday"];
    APPDELEGATE.receivedInfo.workday_title = [dictData objectForKey:@"title"];
    
    [SVProgressHUD dismiss];
    
    [self performSegueWithIdentifier:@"goBodyPart" sender:nil];
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Add Workout day failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}







@end
