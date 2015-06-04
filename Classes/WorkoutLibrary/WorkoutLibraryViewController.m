//
//  WorkoutLibraryViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "WorkoutLibraryViewController.h"
#import "BodySubPartViewController.h"


@interface WorkoutLibraryViewController ()

@end

@implementation WorkoutLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLanguageChangeNotification:) name:kNotificationLanguageChanged object:nil];
    [self configureViewFromLocalisation];

    
    [self initVariable];
    
}

- (void) configureViewFromLocalisation
{
    _navigationBar.title = LOCALIZATION(@"Exercises Library");
    
    [_lblAbdominal setText: LOCALIZATION(@"Abdominal")];
    [_lblAll setText: LOCALIZATION(@"All")];
    [_lblBack setText: LOCALIZATION(@"Back")];
    [_lblBiceps setText: LOCALIZATION(@"Biceps")];
    [_lblCalves setText: LOCALIZATION(@"Calves")];
    [_lblChest setText: LOCALIZATION(@"Chest")];
    [_lblGlutes setText: LOCALIZATION(@"Gluts")];
    [_lblHamstring setText: LOCALIZATION(@"Hamstring")];
    [_lblQuadriceps setText: LOCALIZATION(@"Quadriceps")];
    [_lblShoulder setText: LOCALIZATION(@"Shoulders")];
    [_lblTrapezius setText: LOCALIZATION(@"Trapezius")];
    [_lblTriceps setText: LOCALIZATION(@"Triceps")];
    
}

- (void) initVariable
{
    _dbhandler = [[DBHandler alloc] init];
    [self dataRequestBodyPart];
    
}


- (IBAction)onBiceps:(id)sender {
    APPDELEGATE.receivedInfo.body_id = @"1";
    [self performSegueWithIdentifier:@"goSubPart1" sender:nil];
}
- (IBAction)onTriceps:(id)sender {
    APPDELEGATE.receivedInfo.body_id = @"2";
    [self performSegueWithIdentifier:@"goSubPart2" sender:nil];
}

- (IBAction)onShoulder:(id)sender {
    APPDELEGATE.receivedInfo.body_id = @"3";
    [self performSegueWithIdentifier:@"goSubPart3" sender:nil];
}

- (IBAction)onChest:(id)sender {
    APPDELEGATE.receivedInfo.body_id = @"4";
    [self performSegueWithIdentifier:@"goSubPart4" sender:nil];
}

- (IBAction)onBackSubPart:(id)sender {
    APPDELEGATE.receivedInfo.body_id = @"5";
    [self performSegueWithIdentifier:@"goSubPart5" sender:nil];
}

- (IBAction)onTrapezius:(id)sender {
    APPDELEGATE.receivedInfo.body_id = @"6";
    [self performSegueWithIdentifier:@"goSubPart6" sender:nil];
}

- (IBAction)onGlutes:(id)sender {
    APPDELEGATE.receivedInfo.body_id = @"7";
    [self performSegueWithIdentifier:@"goSubPart7" sender:nil];
}

- (IBAction)onAbdominal:(id)sender {
    APPDELEGATE.receivedInfo.body_id = @"8";
    [self performSegueWithIdentifier:@"goSubPart8" sender:nil];
}

- (IBAction)onQuadriceps:(id)sender {
    APPDELEGATE.receivedInfo.body_id = @"9";
    [self performSegueWithIdentifier:@"goSubPart9" sender:nil];
}

- (IBAction)onHamstring:(id)sender {
    APPDELEGATE.receivedInfo.body_id = @"10";
    [self performSegueWithIdentifier:@"goSubPart10" sender:nil];
}

- (IBAction)onCalves:(id)sender {
    APPDELEGATE.receivedInfo.body_id = @"11";
    [self performSegueWithIdentifier:@"goSubPart11" sender:nil];
}





- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    BodySubPartViewController *view = [segue destinationViewController];
    NSDictionary *dict = [APPDELEGATE.arr_bodypart objectAtIndex:[APPDELEGATE.receivedInfo.body_id intValue]-1];
    
    NSLog(@"%@",APPDELEGATE.receivedInfo.body_id);
    view.bodypart_id = [[dict objectForKey:@"id"] intValue];
    view.strBodyName = [dict objectForKey:@"name"];
}

#pragma mark - Notification ..
- (void) receiveLanguageChangeNotification: (NSNotification *) notification
{
    if ([notification.name isEqualToString:kNotificationLanguageChanged]) {
        [self configureViewFromLocalisation];
    }
}

#pragma mark - Memory ...
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationLanguageChanged object:nil];
    
}


/////////////////////===================////////////////////////

#pragma mark ServerCallDelegate
- (void) dataRequestGetExercise {
    
    bRequestOrder = false;
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    NSString *user_id = APPDELEGATE.userInfo.user_id;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", user_id, @"id", nil];

    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_exercise"];
    
}

- (void) dataRequestBodyPart {
    
    [SVProgressHUD show];
    bRequestOrder = true;
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    NSString *user_id = APPDELEGATE.userInfo.user_id;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", user_id, @"id", nil];
    
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_body_parts"];
    
}

- (void) OnReceived: (NSDictionary*) dictData {

    
    NSLog(@"%@", dictData);
    NSMutableArray *info = [[NSMutableArray alloc] init];
    info = [dictData objectForKey:@"result"];

    if (bRequestOrder) {
        
        APPDELEGATE.arr_bodypart = info;
        //[self dataRequestGetExercise];
        //return;
        
    } else {
        
        APPDELEGATE.receivedInfo.arr_get_exercises = [[NSMutableArray alloc] init];
        APPDELEGATE.receivedInfo.arr_get_exercises = info;
        
    }
    
    //[_dbhandler insertDBInfoList:info];
    [SVProgressHUD dismiss];

    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Get body part failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
//LiKaShing*
#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}
//LiKaShing

@end
