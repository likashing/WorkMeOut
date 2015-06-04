//
//  ProgramExerciseListViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "ProgramExerciseListViewController.h"

@interface ProgramExerciseListViewController ()

@end

@implementation ProgramExerciseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self dataRequest];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)on33minsClick:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Workout Summary" message:@"09/16/2014 \n Session Length: 00:35:08\n Actual Workout: 00:02:57\n Rest Time: 00:00:37\n Wasted Time: 00:28:34\n Exercises done: 3" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
    alert.tag = 1;
    [alert show];
    
}

- (IBAction)onEndWorkoutClick:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"End Session" message:@"Are you sure to end current workout session?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    alert.tag = 2;
    [alert show];
    
}



- (IBAction)onBackClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

///////////////////////==================////////////////////////
#pragma mark UIAlertView Delegate

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            
        }
    } else if (alertView.tag == 2) {
        if (buttonIndex == 0) {
            UIAlertView *sub_alert = [[UIAlertView alloc] initWithTitle:@"Workout Summary" message:@"\n\n Session Length: \n Actual Workout: \n Rest Time: \n Wasted Time: \n Exercises done: " delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
            [sub_alert show];
        }
    }
}


///////////////////=================///////////////////////

#pragma mark ServerCallDelegate
- (void) dataRequest {
    
    [SVProgressHUD show];
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    NSString *strID = APPDELEGATE.userInfo.user_id;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: strID, @"user_id", strID, @"id", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_registered_paid_programs"];
    
    
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    [SVProgressHUD dismiss];
    NSLog(@"%@", dictData);
    
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Operation failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}












@end
