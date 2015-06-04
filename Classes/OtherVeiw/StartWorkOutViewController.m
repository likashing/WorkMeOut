//
//  StartWorkOutViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 20/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "StartWorkOutViewController.h"

@interface StartWorkOutViewController ()

@end

@implementation StartWorkOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self labelFormat];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) labelFormat
{
    _lblCreatedDate.text = _strCreatedDate;
    _lblDifficulty.text = _strDifficulty;
    _lblFrequency.text = _strFrequency;
    _lblProgramName.text = _strProgramName;
    _lblProgress.text = _strProgress;
    _lblType.text = _strType;
    
}



- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
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


///////////////////===============///////////////////

#pragma mark ServerCallDelegate
- (void) dataRequest {
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    //[SVProgressHUD show];
    [self showProgress:@"Please Wait.."];
    
    
//    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: APPDELEGATE.receivedInfo.workout_day_id, @"trainee_program_workday_id", APPDELEGATE.receivedInfo.exercise_id, @"exercise_id", @"120", @"duration", @"3", @"sets", @"2", @"repetitions", nil];
//    
//    NSLog(@"%@", dict);
//    
//    APPDELEGATE.serverCall.delegate = self;
//    [APPDELEGATE.serverCall requestServer:dict url:@"get_free_workout_programs"];
    
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    
    [self hideProgress];
    //[SVProgressHUD dismiss];
    //[self performSegueWithIdentifier:@"" sender:nil];
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Operation failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}








/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
