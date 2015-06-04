//
//  MyDietPlanViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "MyDietPlanViewController.h"
#import "ProgramDetailsViewController.h"
#import "RestaurantsViewController.h"



@interface MyDietPlanViewController ()

@end

@implementation MyDietPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self componentsFormat];
}

- (void) componentsFormat
{
    
    [_scrollview1 setContentSize:CGSizeMake(210, 384)];
    _scrollview1.scrollEnabled = YES;
    [_scrollview2 setContentSize:CGSizeMake(210, 384)];
    _scrollview2.scrollEnabled = YES;
    [_scrollview3 setContentSize:CGSizeMake(210, 384)];
    _scrollview3.scrollEnabled = YES;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (void) showFoodMenuDay1: (int)index
{
    if (index == 1) {
        [_scrollview1 scrollRectToVisible:_viewBreakfast1.frame animated:YES];
        _btnLunch1.selected = NO;
        _btnDinner1.selected = NO;
    } else if (index == 2) {
        [_scrollview1 scrollRectToVisible:_viewLunch1.frame animated:YES];
        _btnBreakfast1.selected = YES;
        _btnDinner1.selected = NO;
    } else if (index == 3) {
        [_scrollview1 scrollRectToVisible:_viewDinner1.frame animated:YES];
        _btnBreakfast1.selected = YES;
        _btnLunch1.selected = NO;
    }
    
}
- (void) showFoodMenuDay2: (int)index
{
    if (index == 1) {
        [_scrollview2 scrollRectToVisible:_viewBreakfast2.frame animated:YES];
        _btnLunch2.selected = NO;
        _btnDinner2.selected = NO;
    } else if (index == 2) {
        [_scrollview2 scrollRectToVisible:_viewLunch2.frame animated:YES];
        _btnBreakfast2.selected = YES;
        _btnDinner2.selected = NO;
    } else if (index == 3) {
        [_scrollview2 scrollRectToVisible:_viewDinner2.frame animated:YES];
        _btnBreakfast2.selected = YES;
        _btnLunch2.selected = NO;
    }
    
}
- (void) showFoodMenuDay3: (int)index
{
    if (index == 1) {
        [_scrollview3 scrollRectToVisible:_viewBreakfast3.frame animated:YES];
        _btnLunch3.selected = NO;
        _btnDinner3.selected = NO;
    } else if (index == 2) {
        [_scrollview3 scrollRectToVisible:_viewLunch3.frame animated:YES];
        _btnBreakfast3.selected = YES;
        _btnDinner3.selected = NO;
    } else if (index == 3) {
        [_scrollview3 scrollRectToVisible:_viewDinner3.frame animated:YES];
        _btnBreakfast3.selected = YES;
        _btnLunch3.selected = NO;
    }
    
}


- (IBAction)onDay1Breakfast:(id)sender {
    
    _btnBreakfast1.selected = !_btnBreakfast1.selected;
    [self showFoodMenuDay1:1];

}

- (IBAction)onDay1Lunch:(id)sender {
    
    _btnLunch1.selected = !_btnLunch1.selected;
    [self showFoodMenuDay1:2];
    
}

- (IBAction)onDay1Dinner:(id)sender {
    
    _btnDinner1.selected = !_btnDinner1.selected;
    [self showFoodMenuDay1:3];
    
}

- (IBAction)onDay2Breakfast:(id)sender {
    _btnBreakfast2.selected = !_btnBreakfast2.selected;
    [self showFoodMenuDay2:1];
}

- (IBAction)onDay2Lunch:(id)sender {
    _btnLunch2.selected = !_btnLunch2.selected;
    [self showFoodMenuDay2:2];
}

- (IBAction)onDay2Dinner:(id)sender {
    _btnDinner2.selected = !_btnDinner2.selected;
    [self showFoodMenuDay2:3];
}

- (IBAction)onDay3Breakfast:(id)sender {
    _btnBreakfast3.selected = !_btnBreakfast3.selected;
    [self showFoodMenuDay3:1];
}

- (IBAction)onDay3Lunch:(id)sender {
    _btnLunch3.selected = !_btnLunch3.selected;
    [self showFoodMenuDay3:2];
}

- (IBAction)onDay3Dinner:(id)sender {
    _btnDinner3.selected = !_btnDinner3.selected;
    [self showFoodMenuDay3:3];
}

- (IBAction)onFoodIconClick:(id)sender {
    
//    RestaurantsViewController *view = [[RestaurantsViewController alloc] init];
//    [self.navigationController pushViewController:view animated:YES];
    
}

- (IBAction)onViewWorkoutsClick:(id)sender {
    
//    ProgramDetailsViewController *view = [[ProgramDetailsViewController alloc] init];
//    [self.navigationController pushViewController:view animated:YES];
//    
    
}

- (IBAction)onMenuClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



///////////////////===============///////////////////

#pragma mark ServerCallDelegate
- (void) dataRequest {
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    [SVProgressHUD show];
    //[self showProgress:@"Please Wait.."];
    
    NSString *user_id = APPDELEGATE.userInfo.user_id;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", user_id, @"trainee_id", @"", @"program_id", @"", @"week_index", nil];
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_diet_plan"];
    
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    
    NSMutableArray *info = [[NSMutableArray alloc] init];
    info = [dictData objectForKey:@"result"];
   
    //result = id, dietary_plan_id, type, description, time,
    for (int i = 0; i < info.count; i ++) {
        NSDictionary *temp = [info objectAtIndex:i];
        
        
    }
    
    [SVProgressHUD dismiss];
    
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Operation failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}










@end
