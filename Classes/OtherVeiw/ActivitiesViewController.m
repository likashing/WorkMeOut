//
//  ActivitiesViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "ActivitiesViewController.h"
#import "ActivitiesTableCell.h"
#import "InProgressActivityCell.h"



@interface ActivitiesViewController ()

@end

@implementation ActivitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    _arr_progress = [APPDELEGATE.arr_activities mutableCopy];
    
    
    [self componentsFormat];
    
    
}

- (void) componentsFormat
{
    
    [_scrollview setContentSize:CGSizeMake(756, 553)];
    _scrollview.scrollEnabled = NO;
    
    _tblComplete.tag = 1;
    _tblProgress.tag = 2;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (IBAction)onCompletedClick:(id)sender {
    
    _btnCompleted.selected = !_btnCompleted.selected;
    [self showPage:YES];
    
    
}

- (IBAction)onInProgressClick:(id)sender {
    
    _btnInProgress.selected = !_btnInProgress.selected;
    [self showPage:NO];
    
}

- (void) showPage: (BOOL)bShow
{
    if (bShow) {
        [_scrollview scrollRectToVisible:_completedView.frame animated:YES];
        _btnInProgress.selected = NO;
        
    } else {
        [_scrollview scrollRectToVisible:_inprogressView.frame animated:YES];
        _btnCompleted.selected = NO;
    }
}

- (IBAction)onGotoWorkout:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)onMenuClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


//////////////////////////

#pragma mark UITableViewDataSource Proc
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tblComplete) {
        return [_arr_completed count];
    } else if (tableView == _tblProgress) {
        return [_arr_progress count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if (tableView == _tblComplete) {
        ActivitiesTableCell *tempCell = [_tblComplete dequeueReusableCellWithIdentifier:@"ActivitiesCell"];
        
        NSDictionary *temp = [_arr_completed objectAtIndex:indexPath.row];
        tempCell.lblActivityName.text = [temp objectForKey:@"name"];
        tempCell.lblCreated.text = [temp objectForKey:@"created_at"];
        
        cell = tempCell;
    } else if (tableView == _tblProgress) {
        InProgressActivityCell *tempCell = [_tblProgress dequeueReusableCellWithIdentifier:@"ProgressCell"];
        
        NSDictionary *dict = [_arr_progress objectAtIndex:indexPath.row];
        tempCell.lblName.text = [dict objectForKey:@"name"];
        tempCell.lblWeekDay.text = [NSString stringWithFormat:@"Week-%@ | Day %@", [dict objectForKey:@"week"], [dict objectForKey:@"day"]];
        //cell.lblCompleteTime = [dict objectForKey:@"day"];
        
        cell = tempCell;
    }

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
    
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

















@end
