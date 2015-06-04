//
//  LegPushEditViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 03/02/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "AddExerciseViewController.h"
#import "ExerciseListViewController.h"
#import "CreateScheduleViewController.h"
#import "WorkoutLibraryViewController.h"



@interface AddExerciseViewController ()

@end

@implementation AddExerciseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initComponents];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initComponents
{
    _viewSet1.layer.cornerRadius = 5;
    _viewSet2.layer.cornerRadius = 5;
    _viewSet3.layer.cornerRadius = 5;
    
    
    
}



- (IBAction)onSaveClick:(id)sender {
    if ([_txtSet1.text isEqual:@""] && [_txtSet2.text isEqual:@""] && [_txtSet3.text isEqual:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Please enter numbers" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    
    [self addDataRequest];
    
}

- (IBAction)onBackClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

///////////////////==================///////////////////////

#pragma mark UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIViewController *view;
    NSArray *array = self.navigationController.viewControllers;
    NSInteger count = array.count;

    if (alertView.tag == 111) {
        if (buttonIndex == 0) {
            
            for (NSInteger i = count - 1; i > 0 ; i--)
            {
                view = [array objectAtIndex:i];
                if ([view isKindOfClass:[WorkoutLibraryViewController class]])
                {
                    [self.navigationController popToViewController:view animated:YES];
                    return;
                }
            }
        } else if (buttonIndex == 1) {
            for (NSInteger i = count - 1; i > 0 ; i--)
            {
                view = [array objectAtIndex:i];
                if ([view isKindOfClass:[ExerciseListViewController class]])
                {
                    [self.navigationController popToViewController:view animated:YES];
                    return;
                }
            }
        
        }
    }
}


///////////////////==================///////////////////////

#pragma mark UITextField Delegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _txtSet1) {
        [_txtSet2 becomeFirstResponder];
    } else if (textField == _txtSet2) {
        [_txtSet3 becomeFirstResponder];
    } else {
        [_txtSet3 resignFirstResponder];
    }
    
    return YES;
}



///////////////////===============///////////////////

#pragma mark ServerCallDelegate

- (void) addDataRequest {
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    [SVProgressHUD show];
    //[self showProgress:@"Please Wait.."];
    
    NSString *user_id = APPDELEGATE.userInfo.user_id;
    
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", APPDELEGATE.receivedInfo.exercise_id, @"exercise_id", APPDELEGATE.receivedInfo.workout_day_id, @"trainee_program_workday_id", _txtSet1.text, @"duration", _txtSet2.text, @"sets", _txtSet3.text, @"repetitions", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"add_workout_exercise"];
    
}

- (void) OnReceived: (NSDictionary*) dictData {
 
    NSLog(@"%@", dictData);
    [SVProgressHUD dismiss];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Do you want to add more exercises to this day?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes", @"No", nil];
    alert.tag = 111;
    [alert show];
    
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Add Exercise failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}





@end
