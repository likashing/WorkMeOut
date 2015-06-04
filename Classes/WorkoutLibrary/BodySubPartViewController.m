//
//  BicepsViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "BodySubPartViewController.h"
#import "ReceivedInfo.h"
#import "ExerciseListViewController.h"


@interface BodySubPartViewController ()

@end

@implementation BodySubPartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self dataRequestSubPart];
    [self initComponents];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) initComponents
{
    _subBodyPartBar.title = _strBodyName;
    
    
    if (_bodypart_id == 1) { //Biceps
        _btnPrimaryMuscle.center = CGPointMake(60, 220);
    } else if (_bodypart_id == 2) { //Triceps
        _btnPrimaryMuscle.center = CGPointMake(70, 140);
    } else if (_bodypart_id == 3) { //Shoulder
        
        _btnPrimaryMuscle.center = CGPointMake(280, 190);
    } else if (_bodypart_id == 4) { //Chest
        _btnPrimaryMuscle.center = CGPointMake(75, 180);
    } else if (_bodypart_id == 5) { //Back
        _btnPrimaryMuscle.center = CGPointMake(40, 240);
    } else if (_bodypart_id == 6) { //Trapezius
        _btnPrimaryMuscle.center = CGPointMake(90, 140);
    } else if (_bodypart_id == 7) { //Glutes
        _btnPrimaryMuscle.center = CGPointMake(50, 400);
    } else if (_bodypart_id == 8) { //Abdominal
        _btnPrimaryMuscle.center = CGPointMake(40, 270);
    } else if (_bodypart_id == 9) { //Quadriceps
        _btnPrimaryMuscle.center = CGPointMake(60, 425);
    } else if (_bodypart_id == 10) { //Hamstring
        _btnPrimaryMuscle.center = CGPointMake(60, 450);
    } else if (_bodypart_id == 11) { //Calves
        _btnPrimaryMuscle.center = CGPointMake(70, 500);
    }
    
}


- (IBAction)onSubPart:(id)sender {
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}

- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    ExerciseListViewController *view = [segue destinationViewController];
    view.subpart_id = _subpart_id;
    view.bFemaleWorkouts = false;
    
}

///////////////////////////////////////////////
#pragma mark Sub Body Part Button Click Event

- (IBAction)onLongHead_1:(id)sender {
    _subpart_id = 25;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}

- (IBAction)onShortHead:(id)sender {
    _subpart_id = 24;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}


- (IBAction)onLongHead:(id)sender {
    _subpart_id = 1;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}
- (IBAction)onMedialHead:(id)sender {
    _subpart_id = 2;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}

- (IBAction)onLateralHead:(id)sender {
    _subpart_id = 3;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}

- (IBAction)onAnteriorDeltoid:(id)sender {
    _subpart_id = 4;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}
- (IBAction)onLateralDeltoid:(id)sender {
    _subpart_id = 5;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}

- (IBAction)onPosterior:(id)sender {
    _subpart_id = 6;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}


- (IBAction)onPectoralisUpper:(id)sender {
    _subpart_id = 7;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}

- (IBAction)onPectoralisMiddle:(id)sender {
    _subpart_id = 8;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}

- (IBAction)onPectoralisLower:(id)sender {
    _subpart_id = 9;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}

- (IBAction)onAtissimusDorsi:(id)sender {
    _subpart_id = 10;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}

- (IBAction)onLowerBack:(id)sender {
    _subpart_id = 11;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}

- (IBAction)onMiddleBack:(id)sender {
    _subpart_id = 12;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}

- (IBAction)onTrapezius:(id)sender {
    _subpart_id = 13;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}

- (IBAction)onGluteusMaximus:(id)sender {
    _subpart_id = 14;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}

- (IBAction)onRectusAbdominal:(id)sender {
    _subpart_id = 15;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}

- (IBAction)onExternalOblique:(id)sender {
    _subpart_id = 16;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}

- (IBAction)onVastusLateralis:(id)sender {
    _subpart_id = 17;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}

- (IBAction)onRectusFemoris:(id)sender {
    _subpart_id = 18;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}

- (IBAction)onVastusMediaus:(id)sender {
    _subpart_id = 19;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}

- (IBAction)onSartorius:(id)sender {
    _subpart_id = 20;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}

- (IBAction)onGracilis:(id)sender {
    _subpart_id = 21;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}

- (IBAction)onSemitendinosus:(id)sender {
    _subpart_id = 22;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}

- (IBAction)onBicepsFemoris:(id)sender {
    _subpart_id = 23;
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
}

- (IBAction)onCalves:(id)sender {
}



/////////////////////===================////////////////////////

#pragma mark ServerCallDelegate

- (void) dataRequestSubPart {
    
    [SVProgressHUD show];
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    NSString *user_id = APPDELEGATE.userInfo.user_id;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", [NSString stringWithFormat:@"%d", _bodypart_id], @"id", nil];

    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_sub_parts"];
    
}

- (void) dataRequestGetExercises {
    
    [SVProgressHUD show];
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    NSString *user_id = APPDELEGATE.userInfo.user_id;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", [NSString stringWithFormat:@"%d", _subpart_id], @"id", nil];
    
    
    NSLog(@"%@", dict);
    NSLog(@"%d", _subpart_id);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_exercises_by_subpart"];
    
}

- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    NSMutableArray *array = [[NSMutableArray alloc] init];
    array = [dictData objectForKey:@"result"];
    
    
    [SVProgressHUD dismiss];
    
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Get body subpart failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}








@end
