//
//  StartViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 18/3/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "StartViewController.h"
#import "MainMenuFreeView.h"
#import "MainMenuPaidView.h"




@interface StartViewController ()

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self checkedLogin];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) checkedLogin
{
    if (!APPDELEGATE.isLoggedIn) {
        [self performSegueWithIdentifier:@"gotoLogin" sender:nil];
    } else if (APPDELEGATE.isLoggedIn) {
        [self navigationFunc];
    }
    
    //NSLog(@"Login Bool: %hhd", APPDELEGATE.isLoggedIn);
}


- (void) navigationFunc
{
    [APPDELEGATE getUserInfo];
    
    if ([APPDELEGATE.userInfo.paid isEqual:@"0"]) {
        APPDELEGATE.member_kind = FREE_MEMBER;
        
        MainMenuFreeView *view = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMenuFreeView"];
        
        [self.navigationController pushViewController:view animated:YES];
        
        
    } else if ([APPDELEGATE.userInfo.paid isEqual:@"1"]) {
        APPDELEGATE.member_kind = PAID_MEMBER;
        
        MainMenuPaidView *view = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMenuPaidView"];
        [self.navigationController pushViewController:view animated:YES];
        
    }
    
}




//LiKaShing*
#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}
//LiKaShing



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
