//
//  OurTrainersViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "OurTrainersViewController.h"


@interface OurTrainersViewController ()

@end

@implementation OurTrainersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initTextLable];
    
    //[self dataRequest];
    
}

- (void) initTextLable
{
    _lblTrainer1.text = @"Book a meeting";
    _lblTrainer2.text = @"Book a meeting";
    _lblTrainer3.text = @"Book a meeting";
    _lblTrainer4.text = @"Book a meeting";
    _lblTrainer5.text = @"Book a meeting";
    _lblTrainer6.text = @"Book a meeting";
    
}


- (void) changeTextLable
{
    _lblTrainer1.text = @"Buy a program";
    _lblTrainer2.text = @"Buy a program";
    _lblTrainer3.text = @"Buy a program";
    _lblTrainer4.text = @"Buy a program";
    _lblTrainer5.text = @"Buy a program";
    _lblTrainer6.text = @"Buy a program";

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)onNextClick1:(id)sender {
    [self navigationFunc];
}

- (IBAction)onNextClick2:(id)sender {
    [self navigationFunc];
}

- (IBAction)onNextClick3:(id)sender {
    [self navigationFunc];
}

- (IBAction)onNextClick4:(id)sender {
    [self navigationFunc];
}

- (IBAction)onNextClick5:(id)sender {
    [self navigationFunc];
}

- (IBAction)onNextClick6:(id)sender {
    [self navigationFunc];
}

- (void) navigationFunc
{
    if (_btnSelect.selected) {
        [self performSegueWithIdentifier:@"goBuyProgram" sender:nil];
    } else {
        [self performSegueWithIdentifier:@"goSelectProgram" sender:nil];
    }

}

- (IBAction)onCheckBtnClick:(id)sender {
    
    _btnSelect.selected = !_btnSelect.selected;
    
    if (_btnSelect.selected) {
        [self changeTextLable];
    } else {
        [self initTextLable];
    }
    
}

- (IBAction)onBackClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



///////////////////=================///////////////////////

#pragma mark ServerCallDelegate
- (void) dataRequest {
    
    [SVProgressHUD show];
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    NSString *strID = APPDELEGATE.userInfo.user_id;
    
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: strID, @"user_id", strID, @"id", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_trainee"];
    
  
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    
    [SVProgressHUD dismiss];
    
    APPDELEGATE.userInfo.user_id    = [dictData objectForKey:@"id"];
    APPDELEGATE.userInfo.name       = [dictData objectForKey:@"name"];
    APPDELEGATE.userInfo.gender     = [dictData objectForKey:@"gender"];
    APPDELEGATE.userInfo.birthday   = [dictData objectForKey:@"birthdate"];
    
    APPDELEGATE.userInfo.height     = [[dictData objectForKey:@"height"] integerValue];
    APPDELEGATE.userInfo.weight     = [[dictData objectForKey:@"weight"] integerValue];
    APPDELEGATE.userInfo.paid       = [dictData objectForKey:@"paid"];
    
    [APPDELEGATE saveUserInfo];
    
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Operation failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}




























@end
