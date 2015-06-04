//
//  ExerciseListViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "ExerciseListViewController.h"
#import "ExerciseTableViewCell.h"
#import "ExerciseDetailViewController.h"



@interface ExerciseListViewController ()

@end

@implementation ExerciseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLanguageChangeNotification:) name:kNotificationLanguageChanged object:nil];
    [self configureViewFromLocalisation];
    
    [self componentsFormat];
    
    if (_bFemaleWorkouts) {
        [self dataRequestFemale];
    } else {
        [self dataRequestBySubPart];
    }
    //[self dataRequestBySubPart];
    
    
}

- (void) configureViewFromLocalisation
{
    _navigationBar.title = LOCALIZATION(@"Exercise List");
    
    [_btnExercise setTitle:LOCALIZATION(@"Exercise List") forState:UIControlStateNormal];
    [_btnFavourites setTitle:LOCALIZATION(@"Favourites") forState:UIControlStateNormal];
    [_btnRecent setTitle:LOCALIZATION(@"Recent") forState:UIControlStateNormal];
    
}


- (void) receiveLanguageChangeNotification: (NSNotification *) notification
{
    if ([notification.name isEqualToString:kNotificationLanguageChanged]) {
        [self configureViewFromLocalisation];
    }
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationLanguageChanged object:nil];
}


- (void) componentsFormat
{
    [_scrollview setContentSize:CGSizeMake(1134, 550)];
    _scrollview.scrollEnabled = NO;
    
    
    _array = [[NSMutableArray alloc] init];
    
    _tblFavorite.tag = 1;
    _tblExercise.tag = 2;
    _tblRecent.tag = 3;
    
    APPDELEGATE.arr_recentlyExercises = [NSMutableArray array];
    APPDELEGATE.arr_favoriteExercises = [NSMutableArray array];
    
    [self showPage:2];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onFavouritesClick:(id)sender {
    
    _btnFavourites.selected = !_btnFavourites.selected;
    
    [APPDELEGATE getFavoriteExerciseList];
    [_tblFavorite reloadData];
    
    [self showPage:1];
}

- (IBAction)onExerciseClick:(id)sender {
    _btnExercise.selected = !_btnExercise.selected;
    [_tblExercise reloadData];
    [self showPage:2];
}

- (IBAction)onRecentClick:(id)sender {
    _btnRecent.selected = !_btnRecent.selected;
    
    [APPDELEGATE getRecentlyExerciseList];
    [_tblRecent reloadData];
    [self showPage:3];
}

- (void) showPage: (int)index
{
    if (index == 1) {
        [_scrollview scrollRectToVisible:_favouritesView.frame animated:YES];
        _btnExercise.selected = NO;
        _btnRecent.selected = NO;
        
    } else if (index == 2){
        [_scrollview scrollRectToVisible:_exerciseView.frame animated:YES];
        _btnFavourites.selected = NO;
        _btnRecent.selected = NO;
        
        
    } else if (index == 3) {
        [_scrollview scrollRectToVisible:_recentView.frame animated:YES];
        _btnFavourites.selected = NO;
        _btnExercise.selected = NO;
       
    }
}

- (IBAction)onBackClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

///////////////////////===================////////////////////////
#pragma mark UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView.tag == 1) {
        return [APPDELEGATE.arr_favoriteExercises count];
    } else if (tableView.tag == 2) {
        return [_array count];
    } else if (tableView.tag == 3) {
         NSLog(@"Recently Count:%lu", (unsigned long)APPDELEGATE.arr_recentlyExercises.count);
        return [APPDELEGATE.arr_recentlyExercises count];
    }
   
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExerciseTableViewCell *cell = [[ExerciseTableViewCell alloc] init];
    if (tableView.tag == 1) {
        cell = [_tblFavorite dequeueReusableCellWithIdentifier:@"ExerciseCell"];
        if (APPDELEGATE.arr_favoriteExercises.count != 0) {
            NSMutableDictionary *temp = [APPDELEGATE.arr_favoriteExercises objectAtIndex:indexPath.row];
            cell.lblExerciseName.text = [temp objectForKey:@"name"];
        }

    } else if (tableView.tag == 2) {
        cell = [_tblExercise dequeueReusableCellWithIdentifier:@"ExerciseCell"];
        if (_array.count != 0) {
            NSMutableDictionary *temp = [_array objectAtIndex:indexPath.row];
            cell.lblExerciseName.text = [temp objectForKey:@"name"];
        }


    } else if (tableView.tag == 3) {
        
        cell = [_tblRecent dequeueReusableCellWithIdentifier:@"ExerciseCell"];
        if (APPDELEGATE.arr_recentlyExercises.count != 0) {
            NSMutableDictionary *temp = [APPDELEGATE.arr_recentlyExercises objectAtIndex:indexPath.row];
            cell.lblExerciseName.text = [temp objectForKey:@"name"];
        }
        
    }
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        NSMutableDictionary *temp = [APPDELEGATE.arr_favoriteExercises objectAtIndex:indexPath.row];
        APPDELEGATE.receivedInfo.exercise_id = [temp objectForKey:@"id"];
        APPDELEGATE.bFavourite = true;
        
    }
    else if (tableView.tag == 2) {
        NSMutableDictionary *dict = [_array objectAtIndex:indexPath.row];
        APPDELEGATE.receivedInfo.exercise_id = [dict objectForKey:@"id"];

        for (NSMutableDictionary *temp in APPDELEGATE.arr_recentlyExercises) {
            if ([temp.description isEqual:dict.description]) {
                bDuplicateRecently = true;
            }
        }
        if (!bDuplicateRecently)
        {
            NSMutableArray *array1 = APPDELEGATE.arr_recentlyExercises;
            [array1 addObject:dict];
            [APPDELEGATE saveRecentlyExerciseList];
        } else {
            bDuplicateRecently = false;
        }
        
        APPDELEGATE.n_select_index = indexPath.row;
    }
    else if (tableView.tag == 3) {
        NSMutableDictionary *temp = [APPDELEGATE.arr_recentlyExercises objectAtIndex:indexPath.row];
        APPDELEGATE.receivedInfo.exercise_id = [temp objectForKey:@"id"];
    }
    
    [self performSegueWithIdentifier:@"goDetails" sender:nil];
    
    
}





///////////////////===============///////////////////

#pragma mark ServerCallDelegate
- (void) dataRequestBySubPart {
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    [SVProgressHUD show];
    //[self showProgress:@"Please Wait.."];
    
    NSString *user_id = APPDELEGATE.userInfo.user_id;
    NSString *sub_id = [NSString stringWithFormat:@"%d", _subpart_id];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", sub_id, @"id", nil];
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_exercises_by_subpart"];
    
}

- (void) dataRequestFemale {
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    [SVProgressHUD show];
    
    NSString *user_id = APPDELEGATE.userInfo.user_id;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", user_id, @"id", nil];
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_exercises/female"];
    
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    //[self hideProgress];
    
    _array = [dictData objectForKey:@"result"];
    
    if (_array.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Note!" message:@"No Exercise Lists yet." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    
    APPDELEGATE.receivedInfo.arr_get_exercises = _array;
    
    for (int i = 0; i < _array.count; i ++) {
        NSDictionary *temp = [_array objectAtIndex:i];
        APPDELEGATE.receivedInfo.exercise_id = [temp objectForKey:@"id"];
    }
    
    [SVProgressHUD dismiss];
    
    [_tblExercise reloadData];
    [_tblFavorite reloadData];
    [_tblRecent reloadData];
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Getting exercises failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}








@end
