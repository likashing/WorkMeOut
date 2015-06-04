//
//  WorkRoutinesViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "WorkRoutinesViewController.h"
#import "WorkRoutineTableViewCell.h"


@interface WorkRoutinesViewController ()

@end

@implementation WorkRoutinesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initComponents];
    
    [self initEditPopover];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initComponents
{
    [self dataRequest];
    
    _tblWorkouts.tag = 1;
    _aryWorkouts = [[NSMutableArray alloc] init];
    //_aryWorkouts = @;
    
}



////////////////////===============////////////////////////

#pragma mark Button Events

- (IBAction)onMenuBtnClick:(id)sender {
    
//    if ([self isMenuBoxVisible]) {
//        [self hideMenuView];
//    } else {
//        [self showMenuView];
//    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)onEditBtnClick:(id)sender {
    
    //[self showEditPopoverView];
    if ([self isEditMenuVisible]) {
        [self hideEditMenu];
    } else {
        [self showEditMenu];
    }
    
}

///////////////////========/////////////////////

- (IBAction)onAddWorkoutClick:(id)sender {
    [self hideEditMenu];
    editmenu_state = state_add;
    [_tblWorkouts setEditing:YES animated:YES];
}

- (IBAction)onDelWorkoutClick:(id)sender {
    [self hideEditMenu];
    editmenu_state = state_del;
    [_tblWorkouts setEditing:YES animated:YES];
}

- (IBAction)onEditWorkoutClick:(id)sender {
    [self hideEditMenu];
    editmenu_state = state_edit;
}

- (IBAction)onCopyWorkoutClick:(id)sender {
    [self hideEditMenu];
    editmenu_state = state_copy;
}

/////////////////////=====//////////////////////

- (IBAction)onMyActivitiesClick:(id)sender {
    [self hideMenuView];
    [self performSegueWithIdentifier:@"goMyActivities" sender:nil];
}

- (IBAction)onAchievementsClick:(id)sender {
    [self hideMenuView];
    [self performSegueWithIdentifier:@"goAchievements" sender:nil];
}

- (IBAction)onWorkoutLibrary:(id)sender {
    [self hideMenuView];
    [self performSegueWithIdentifier:@"goWorkoutLibrary" sender:nil];
}

- (IBAction)onGetTrainerClick:(id)sender {
    [self hideMenuView];
    [self performSegueWithIdentifier:@"goGetTrainer" sender:nil];
}

- (IBAction)onFavouriteExercisesClick:(id)sender {
    [self hideMenuView];
}

- (IBAction)onMainMenuClick:(id)sender {
    
    [self hideMenuView];
    [self.navigationController popViewControllerAnimated:YES];
    
}

///////////////////////=============///////////////////////
#pragma mark MenuBox

- (BOOL) isMenuBoxVisible
{
    return (_viewMenuBox.superview != nil);
}


- (void)showMenuView
{
    
    CGSize sizeOfToolBox = _viewMenuBox.frame.size;
    CGRect frame;
    frame.origin.x = 0;
    frame.origin.y = -sizeOfToolBox.height;
    frame.size = sizeOfToolBox;
    
    _viewMenuBox.frame = frame;
    [self.view addSubview:_viewMenuBox];
    
    [UIView animateWithDuration:0.5f animations:^
     {
         CGSize sizeOfToolBox = _viewMenuBox.frame.size;
         CGRect frame;
         frame.origin.x = 0;
         frame.origin.y = 64;
         frame.size = sizeOfToolBox;
         
         _viewMenuBox.frame = frame;
     }];
    
}

- (void)hideMenuView
{
    [UIView animateWithDuration:0.5f animations:^
     {
         CGSize sizeOfToolBox = _viewMenuBox.frame.size;
         CGRect frame;
         frame.origin.x = 0;
         frame.origin.y = -sizeOfToolBox.height;
         frame.size = sizeOfToolBox;
         
         _viewMenuBox.frame = frame;
         
     }
                     completion:^(BOOL finished)
     {
         [_viewMenuBox removeFromSuperview];
     }];
}






///////////////////////=============///////////////////////
#pragma mark EditMenu

- (BOOL) isEditMenuVisible
{
    return (_viewEditMenu.superview != nil);
}


- (void)showEditMenu
{
    
    CGSize sizeOfToolBox = _viewEditMenu.frame.size;
    CGRect frame;
    frame.origin.x = self.view.frame.size.width - sizeOfToolBox.width;
    frame.origin.y = -sizeOfToolBox.height;
    frame.size = sizeOfToolBox;
    
    _viewEditMenu.frame = frame;
    [self.view addSubview:_viewEditMenu];
    
    [UIView animateWithDuration:0.5f animations:^
     {
         CGSize sizeOfToolBox = _viewEditMenu.frame.size;
         CGRect frame;
         frame.origin.x = self.view.frame.size.width - sizeOfToolBox.width;
         frame.origin.y = 64;
         frame.size = sizeOfToolBox;
         
         _viewEditMenu.frame = frame;
     }];
    
}

- (void)hideEditMenu
{
    [UIView animateWithDuration:0.5f animations:^
     {
         CGSize sizeOfToolBox = _viewEditMenu.frame.size;
         CGRect frame;
         frame.origin.x = self.view.frame.size.width - sizeOfToolBox.width;
         frame.origin.y = -sizeOfToolBox.height;
         frame.size = sizeOfToolBox;
         
         _viewEditMenu.frame = frame;
         
     }
                     completion:^(BOOL finished)
     {
         [_viewEditMenu removeFromSuperview];
     }];
}


////////////////////////============////////////////////////
#pragma mark EditPopover By using TableView

- (void) initEditPopover
{
    _tblPopover = [[UITableView alloc] init];
    _tblPopover.frame = CGRectMake(0, 0, 180, 160);
    _tblPopover.delegate = self;
    _tblPopover.dataSource = self;
    _tblPopover.tag = 0;
    
    nEditBtnIndex = 0;
    _aryTitle = @[@"Add a Workout", @"Delete Workout", @"Edit Workout", @"Copy Workout"];
}



- (void) showEditPopoverView
{
    CGPoint point = CGPointMake(300, 50);
    [self.popover showAtPoint:point popoverPostion:DXPopoverPositionDown withContentView:_tblPopover inView:self.view];
    
}

- (void) onSubEditBtnClick
{
    switch (nEditBtnIndex) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
            
        default:
            break;
    }
}

///////////////////////===================////////////////////////
#pragma mark UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 0) {
        return 1;
    } else if (tableView.tag == 1) {
        return 1;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 0) {
        return _aryTitle.count;
    } else if (tableView.tag == 1) {
        if (_aryWorkouts != nil) {
            return _aryWorkouts.count;
        } else {
            return 1;
        }
        
    }
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 51;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = self.aryTitle[indexPath.row];
        
        return cell;
        
    } else if (tableView.tag == 1) {
        WorkRoutineTableViewCell *cell = [_tblWorkouts dequeueReusableCellWithIdentifier:@"WorkoutCell"];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        if (_aryWorkouts != nil) {
            NSDictionary *temp = [_aryWorkouts objectAtIndex:indexPath.row];
            cell.lblWorkoutName = [temp objectForKey:@"name"];
        }

        return cell;
    }
    return 0;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 0) {
        
        nEditBtnIndex = (int)indexPath.row;
        
        [self onSubEditBtnClick];
        [_popover dismiss];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellEditingStyle editStyle = UITableViewCellEditingStyleNone;
    
    if (editmenu_state == state_add) {
        editStyle = UITableViewCellEditingStyleInsert;
    } else if (editmenu_state == state_del) {
        editStyle = UITableViewCellEditingStyleDelete;
    }
    
    return editStyle;
}



- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        [self performSegueWithIdentifier:@"goCreateProgram" sender:nil];
    } else if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_tblWorkouts deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
}



///////////////////===============///////////////////

#pragma mark ServerCallDelegate
- (void) dataRequest {
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    [SVProgressHUD show];
    
    NSString *user_id = APPDELEGATE.userInfo.user_id;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", user_id, @"id", nil];
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    
    if (APPDELEGATE.member_kind == FREE_MEMBER) {
        [APPDELEGATE.serverCall requestServer:dict url:@"get_free_activities/incomplete"];
    }
    else if (APPDELEGATE.member_kind == PAID_MEMBER) {
        [APPDELEGATE.serverCall requestServer:dict url:@"get_paid_activities/incomplete"];
        
    }
    
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    //[self hideProgress];
    
    NSMutableArray *info = [[NSMutableArray alloc] init];
    info = [dictData objectForKey:@"result"];
    _aryWorkouts = info;
    
    if (info.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Note!" message:@"You don't have any ongoing workouts." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
    APPDELEGATE.arr_workouts = _aryWorkouts;
    [_tblWorkouts reloadData];
    
    [SVProgressHUD dismiss];
    
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Getting Workouts failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}




















@end
