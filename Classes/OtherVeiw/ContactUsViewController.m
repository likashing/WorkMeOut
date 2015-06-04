//
//  ContactUsViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "ContactUsViewController.h"

@interface ContactUsViewController ()

@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self componentsFormat];
    
}

- (void) componentsFormat
{
    _txtViewQuestion.layer.cornerRadius = 5;
    
    [_scrollview setScrollEnabled:NO];
    
    _scrollview.frame = CGRectMake(0, -20, SCRN_WIDTH, _scrollview.frame.size.height);
    _scrollview.contentSize = CGSizeMake(SCRN_WIDTH, self.view.frame.size.height + 80);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    [_scrollview setScrollEnabled:YES];
    [_scrollview setContentOffset:CGPointMake(0, 80) animated:YES];
    
    return YES;
}

- (void) dismissKeyboard
{
    [_txtViewQuestion resignFirstResponder];
    
    [_scrollview setContentOffset:CGPointMake(0, -80) animated:NO];
    [_scrollview setScrollEnabled:NO];
}


- (IBAction)tapGesture:(id)sender {
    [_txtViewQuestion resignFirstResponder];
}

- (IBAction)onBackBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)onSubmit:(id)sender {
    
    //[self dataRequest];
    
    [self dismissKeyboard];
    
    [self dataRequest];
    
}


- (void) showAlertView
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!!" message:@"Your query has been submitted successfully. One of our team member will be in touch with you shortly." delegate:self cancelButtonTitle:@"Close" otherButtonTitles: nil];
    alert.tag = 345;
    [alert show];
}


////////////////////////////===============/////////////////
#pragma mark ServerCallDelegate

- (void) dataRequest {
    
    [SVProgressHUD show];
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    NSString *str_id = APPDELEGATE.userInfo.user_id;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: str_id, @"user_id", str_id, @"id", _txtViewQuestion.text, @"feedback", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"add_feedback"];
    
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    [SVProgressHUD dismiss];
    NSLog(@"%@", dictData);
    [self showAlertView];
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Add feedback failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
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
