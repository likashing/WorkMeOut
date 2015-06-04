//
//  AchivementsViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 20/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "AchivementsViewController.h"

@interface AchivementsViewController ()
{
}
@end

@implementation AchivementsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initComponents];
    
    [self initPopListView]; 
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initComponents
{
    
    [self dataRequest];
    
}


- (IBAction)onMyActivites:(id)sender {
    [self hideMenuView];
    [self performSegueWithIdentifier:@"goActivities" sender:nil];
}

- (IBAction)onRutineClick:(id)sender {
    [self hideMenuView];
    [self performSegueWithIdentifier:@"goMyWorkout" sender:nil];
}

- (IBAction)onWorkoutLibrary:(id)sender {
    [self hideMenuView];
    [self performSegueWithIdentifier:@"goWorkOutLibrary" sender:nil];
}

- (IBAction)onGetTrainer:(id)sender {
    [self hideMenuView];
    [self performSegueWithIdentifier:@"goGetTrainer" sender:nil];
}

- (IBAction)onFavouriteClick:(id)sender {
    [self hideMenuView];
}

- (IBAction)onMainMenuClick:(id)sender {
    [self hideMenuView];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onShareClick:(id)sender {
    
    [self showListView];
    
    //[self showActionSheetDisplay];
    
}

- (void) showActionSheetDisplay
{
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Share this Achivement:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Google+" otherButtonTitles:@"Facebook", @"Twitter", @"LinkedIn", @"WhatsApp", nil];
        [actionSheet showInView:self.view];
}

- (IBAction)onMenuClick:(id)sender {
    
    if ([self isMenuBoxVisible]) {
        [self hideMenuView];
    } else {
        [self showMenuView];
    }

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



////////////////////////============/////////////////////////

#pragma mark PopListView Delegate Part

- (void) initPopListView
{
    _options = [NSArray arrayWithObjects:
                 [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"google-plus.png"],@"img",@"Google+",@"text", nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"facebook.png"],@"img",@"Facebook",@"text", nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"twitter.png"],@"img",@"Twitter",@"text", nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"linkedin.png"],@"img",@"LinkedIn",@"text", nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"whatsapp.png"],@"img",@"WhatsApp",@"text", nil],
                 nil];

}

- (void)showListView
{
    LeveyPopListView *lplv = [[LeveyPopListView alloc] initWithTitle:@"Share this Achivement:" options:_options];
    lplv.delegate = self;
    [lplv showInView:self.view animated:YES];
    
}

#pragma mark - LeveyPopListView delegates
- (void)leveyPopListView:(LeveyPopListView *)popListView didSelectedIndex:(NSInteger)anIndex
{
    _strShareSite = [NSString stringWithFormat:@"You have selected %@",[[_options objectAtIndex:anIndex] objectForKey:@"text"]];
    
    NSLog(@"anIndex: %ld", (long)anIndex);
    
    if (anIndex == 0) {
        
    } else if (anIndex == 1) {
        
    } else if (anIndex == 2) {
        
    } else if (anIndex == 3) {
        
    } else if (anIndex == 4) {
        
    }
    
    
}
- (void)leveyPopListViewDidCancel
{
    
}


////////////////////////===================//////////////////


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
    [APPDELEGATE.serverCall requestServer:dict url:@"get_achievements"];
    
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    //[self hideProgress];
    
    NSMutableArray *info = [[NSMutableArray alloc] init];
    info = [dictData objectForKey:@"result"];
    
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
