//
//  MainMenuFreeView.m
//  WorkMeOut
//
//  Created by LiKaShing on 20/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "MainMenuFreeView.h"
#import "ActivityTableViewCell.h"
#import "ExerciseListViewController.h"
#import "StartWorkOutViewController.h"



@interface MainMenuFreeView ()

@end

@implementation MainMenuFreeView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

}

- (void) viewWillAppear:(BOOL)animated
{
    _array = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLanguageChangeNotification:) name:kNotificationLanguageChanged object:nil];
    [self configureViewFromLocalisation];
    
    [self dataRequest];

}

- (void) configureViewFromLocalisation
{
    [_lblMyProfile setText: LOCALIZATION(@"My Profile")];
    [_lblViewProfile setText: LOCALIZATION(@"View Profile")];
    [_lblStartWorkouts setText: LOCALIZATION(@"Start Building Workouts")];
    [_lblGetTrainer setText: LOCALIZATION(@"Get assisted by a trainer")];
    [_lblAchievements setText: LOCALIZATION(@"Achievements")];
    [_lblBeforeAfter setText: LOCALIZATION(@"Before / After")];
    [_lblRestaurants setText: @"Female Workouts"];//LOCALIZATION(@"Restaurants")];
    [_lblWorkoutLibrary setText: LOCALIZATION(@"Workout Library")];
    [_lblDirectory setText: LOCALIZATION(@"Directory")];
    [_lblArticles setText: LOCALIZATION(@"Articles")];
    [_lblAskUs setText: LOCALIZATION(@"Ask Us")];
    
    [_btnViewAll setTitle: LOCALIZATION(@"View all") forState:UIControlStateNormal];
    
}





- (IBAction)onArticleBtnClick:(id)sender {
    
    [self performSegueWithIdentifier:@"goArticleCategory" sender:nil];
    
}

- (IBAction)onFemaleWorkouts:(id)sender {
    
    [self performSegueWithIdentifier:@"goExerciseList" sender:nil];
    
}

- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void) onGoToStart: (id)sender
{
    
    //[self performSegueWithIdentifier:@"gotoStartWorkOut" sender:sender];
    
    [self performSegueWithIdentifier:@"goMyActivities" sender:sender];
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    if ([segue.identifier isEqual:@"goExerciseList"]) {
        ExerciseListViewController *view = [segue destinationViewController];
        view.bFemaleWorkouts = true;

    } else if ([segue.identifier isEqual:@"gotoStartWorkOut"])
    {
        StartWorkOutViewController *view = [segue destinationViewController];
        NSDictionary *dictTemp = [_array objectAtIndex:button.tag];
        
        view.strProgramName = [NSString stringWithFormat:@"%@", [dictTemp objectForKey:@"name"]];
        view.strDifficulty = [NSString stringWithFormat:@"%@",[dictTemp objectForKey:@"difficulty"]];
        view.strFrequency = [NSString stringWithFormat:@"%@",[dictTemp objectForKey:@"frequency"]];
        view.strProgress = [NSString stringWithFormat:@"%@", [dictTemp objectForKey:@"progress"]];
        view.strType = [NSString stringWithFormat:@"%@", [dictTemp objectForKey:@"type"]];
        view.strCreatedDate = [NSString stringWithFormat:@"%@", [dictTemp objectForKey:@"created_at"]];
        NSLog(@"%@", view.strProgramName);
    }
//    else if ([segue.identifier isEqual:@"goMyActivities"])
//    {
//        NSDictionary *temp = [_array objectAtIndex:button.tag];
//        
//        
//    }
    

    
}

///////////////////////////////////////////
#pragma mark - Memory Management

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationLanguageChanged object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Notification
- (void) receiveLanguageChangeNotification: (NSNotification *) notification
{
    if ([notification.name isEqualToString:kNotificationLanguageChanged]) {
        [self configureViewFromLocalisation];
    }
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
    ActivityTableViewCell *cell = [[ActivityTableViewCell alloc] init];
    cell = [_tblActivity dequeueReusableCellWithIdentifier:@"ActivityCell"];
    NSDictionary *temp = [[NSDictionary alloc] init];
    
    if (_array.count == 0) {
        cell.lblTitle.text = @"No activities";
        cell.lblCreated.text = @"";
        cell.btnGotoWorkout.hidden = YES;
    } else {
        temp = [_array objectAtIndex:indexPath.row];
        cell.lblTitle.text = [temp objectForKey:@"name"];
        cell.lblCreated.text = [temp objectForKey:@"created_at"];
        cell.btnGotoWorkout.hidden = NO;
        
        [cell.btnGotoWorkout addTarget:self action:@selector(onGoToStart:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnGotoWorkout.tag = indexPath.row;
       
        
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
    [APPDELEGATE.serverCall requestServer:dict url:@"get_free_activities/incomplete"];
    //@"get_free_activities/incomplete"
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    //[self hideProgress];
    
    _array = [dictData objectForKey:@"result"];
    APPDELEGATE.arr_activities = _array;
    
    for (int i = 0; i < _array.count; i ++) {
        //NSDictionary *temp = [_array objectAtIndex:i];
        
        
    }
    
    [SVProgressHUD dismiss];
    [_tblActivity reloadData];
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Get activities failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}







@end
