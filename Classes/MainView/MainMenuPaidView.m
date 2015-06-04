//
//  MainMenuPaidView.m
//  WorkMeOut
//
//  Created by LiKaShing on 20/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "MainMenuPaidView.h"
#import "ActivityPaidViewCell.h"
#import "ExerciseListViewController.h"



@interface MainMenuPaidView ()

@end

@implementation MainMenuPaidView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLanguageChangeNotification:) name:kNotificationLanguageChanged object:nil];
    [self configureViewFromLocalisation];
    
    [self dataRequest];
    
}



- (void) initVariables
{
    _array = [[NSMutableArray alloc] init];
    
    
}

- (void) configureViewFromLocalisation
{
    [_lblMyProfile setText: LOCALIZATION(@"My Profile")];
    [_lblViewProfile setText: LOCALIZATION(@"View Profile")];
    [_lblAchievements setText: LOCALIZATION(@"Achievements")];
    [_lblBeforeAfter setText: LOCALIZATION(@"Before / After")];
    [_lblRestaurants setText: LOCALIZATION(@"Restaurants")];
    [_lblWorkoutLibrary setText: LOCALIZATION(@"Workout Library")];
    [_lblDirectory setText: LOCALIZATION(@"Directory")];
    [_lblArticles setText: LOCALIZATION(@"Articles")];
    [_lblAskUs setText: LOCALIZATION(@"Ask Us")];
    
    [_lblFemaleWorkouts setText:@"Female Workouts"];
    
    [_btnViewAll setTitle: LOCALIZATION(@"View all") forState:UIControlStateNormal];
    
}




- (IBAction)onFemaleWorkouts:(id)sender {
    
    [self performSegueWithIdentifier:@"gotoExerciseList" sender:nil];
    
}

- (IBAction)onArticleBtnClick:(id)sender {
    
    [self performSegueWithIdentifier:@"goArticleCategory" sender:nil];
    
}

- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"goExerciseList"]) {
        ExerciseListViewController *view = [segue destinationViewController];
        view.bFemaleWorkouts = true;
        
    }
    
}

#pragma marke - Notification
- (void) receiveLanguageChangeNotification: (NSNotification *)notification
{
    if ([notification.name isEqualToString:kNotificationLanguageChanged]) {
        [self configureViewFromLocalisation];
    }
}



#pragma mark - Memory Management
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationLanguageChanged object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


///////////////////===============/////////////////////
#pragma mark UITableView DataSource and Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_array.count == 0) {
        return 1;
    }
    return [_array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityPaidViewCell *cell = [[ActivityPaidViewCell alloc] init];
    cell = [_tblActivities dequeueReusableCellWithIdentifier:@"ActivityCell"];
    
    NSDictionary *temp = [[NSDictionary alloc] init];

    if (_array.count == 0) {
        cell.lblName.text = @"No activities";
        cell.lblCreated.text = @"";
        cell.btnGoWorkout.hidden = YES;
        cell.btnViewDiet.hidden = YES;
    } else {
        temp = [_array objectAtIndex:indexPath.row];
        cell.lblName.text = [temp objectForKey:@"name"];
        cell.lblCreated.text = [temp objectForKey:@"created_at"];
    }
    
    int percent = [[temp objectForKey:@"progress"] intValue];
    [_viewRoundProgress setPercent:60 animated:YES];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    APPDELEGATE.n_select_index = indexPath.row;
    
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


///////////////////===============///////////////////

#pragma mark ServerCallDelegate
- (void) dataRequest {
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    [SVProgressHUD show];
    //[self showProgress:@"Please Wait.."];
    
    NSString *user_id = APPDELEGATE.userInfo.user_id;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", user_id, @"id", nil];
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_paid_activities/incomplete"];
    
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    //[self hideProgress];
    
    _array = [dictData objectForKey:@"result"];
    APPDELEGATE.arr_workouts = _array;
    
    for (int i = 0; i < _array.count; i ++) {
        //NSDictionary *temp = [info objectAtIndex:i];
        
        
    }
    
    [SVProgressHUD dismiss];
    [_tblActivities reloadData];
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Get paid activities failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}




@end
