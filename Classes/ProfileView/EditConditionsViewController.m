//
//  EditConditionsViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "EditConditionsViewController.h"
#import "AppDelegate.h"


@interface EditConditionsViewController ()

@end

@implementation EditConditionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initComponents];
}

- (void) initComponents
{
    _img_check1.hidden = YES;
    _img_check2.hidden = YES;
    _img_check3.hidden = YES;
    
    bRequestSet = false;
    [self dataRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) buttonClickEvent: (int)index
{
    [self checkCondition:index];
    
    bRequestSet = true;
    [self dataRequest];
}

- (void) checkCondition: (int)index
{
    if (index == 1) {
        _img_check1.hidden = NO;
        _img_check2.hidden = YES;
        _img_check3.hidden = YES;
        APPDELEGATE.strHealthyCondition = @"Very healthy";
    } else if (index == 2) {
        _img_check1.hidden = YES;
        _img_check2.hidden = NO;
        _img_check3.hidden = YES;
        APPDELEGATE.strHealthyCondition = @"Moderately healthy";
    } else if (index == 3) {
        _img_check1.hidden = YES;
        _img_check2.hidden = YES;
        _img_check3.hidden = NO;
        APPDELEGATE.strHealthyCondition = @"Not healthy";
    }

}


- (IBAction)onVeryhealthy:(id)sender {
    
    [self buttonClickEvent:1];
    
}

- (IBAction)onMorderatelyhealthy:(id)sender {
    [self buttonClickEvent:2];
}

- (IBAction)onNothealthy:(id)sender {
    [self buttonClickEvent:3];
}

- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

////////////////////=============////////////////////
#pragma mark ProgressHUD part

- (void) showProgress:(NSString *)message
{
    [MBProgressHUD showHUDAddedTo:self.view text:message animated:YES];
}

- (void) hideProgress
{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
}



///////////////////////======================/////////////////
#pragma mark ServerCallDelegate

- (void) dataRequest {
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    APPDELEGATE.serverCall.delegate = self;
    
    NSDictionary *dict;
    
    NSString *user_id = APPDELEGATE.userInfo.user_id;
    
    if (bRequestSet) {
        [self showProgress:@"Setting.."];
        
        dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", user_id, @"trainee_id", APPDELEGATE.strHealthyCondition, @"condition", nil];
        NSLog(@"Condition: %@", dict);
        [APPDELEGATE.serverCall requestServer:dict url:@"set_health_condition"];
        
    } else {
        [self showProgress:@"Getting.."];
        
        dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", user_id, @"trainee_id", nil];
        
        [APPDELEGATE.serverCall requestServer:dict url:@"get_health_condition"];
        
    }
    
    NSLog(@"%@", dict);
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    
    if (bRequestSet) {
        NSLog(@"Health condition set Ok,");
    } else {
        
        APPDELEGATE.receivedInfo.condition_name = [dictData objectForKey:@"condition"];
        
        NSLog(@"Health condition get Ok,");
        
        NSString *str = APPDELEGATE.receivedInfo.condition_name;
        if ([str isEqual: @"Very healthy"]) {
            [self checkCondition:1];
        }
        else if ([str isEqual: @"Moderately healthy"])
        {
            [self checkCondition:2];
        }
        else if ([str isEqual: @"Not healthy"])
        {
            [self checkCondition:3];
        }
        
    }
    
    [self hideProgress];
}

- (void) OnConnectFail
{
    [self hideProgress];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Operation failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}




























@end
