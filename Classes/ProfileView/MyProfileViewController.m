//
//  MyProfileViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "MyProfileViewController.h"




@interface MyProfileViewController ()

@end

@implementation MyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    n_lblcount = 0;
    _arrayLabel = [[NSMutableArray alloc] init];
    _arrayPhotos = [[NSMutableArray alloc] init];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [self componentsFormat];
    [self getTraineePhotos];
    
}


- (void) componentsFormat
{
    
    [_scrollview setContentSize:CGSizeMake(327, 800)];
    _scrollview.scrollEnabled = YES;
    _scrollview.layer.cornerRadius = 5;
    
    [_scrollview1 setContentSize:CGSizeMake(900, 145)];
    _scrollview1.scrollEnabled = YES;
    
    _txtViewComments.layer.cornerRadius = 5;
    
    
    //My Profile Info Part
    [APPDELEGATE getUserInfo];
    _lblName.text = APPDELEGATE.userInfo.name;
    if ([APPDELEGATE.userInfo.gender isEqual:@"m"] || [APPDELEGATE.userInfo.gender isEqual:@"Male"]) {
         _lblGender.text = @"Male";
    } else {
         _lblGender.text = @"Female";
    }
   
    _lblHeight.text = [NSString stringWithFormat:@"%ldcm", (long)APPDELEGATE.userInfo.height];
    _lblWeight.text = [NSString stringWithFormat:@"%ldkg", (long)APPDELEGATE.userInfo.weight];
    _lblAge.text = [NSString stringWithFormat:@"%@yrs", APPDELEGATE.userInfo.user_age];
    
    
    _lblHealthyCondition.text = APPDELEGATE.strHealthyCondition;
    _txtViewComments.text = APPDELEGATE.receivedInfo.special_note;
    
    for (int i = 0; i < n_lblcount; i ++) {
        if (_lblFoods.tag == i)
            [_lblFoods removeFromSuperview];
    }
    [_arrayLabel removeAllObjects];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getPhotosToServer: (NSMutableArray *)urls count: (int)cnt
{
    AsyncImageView *photos;
    int j = 0, k = 0;
    for (int i = 0; i < cnt; i ++) {
        k = i % 2;
        if (k == 0) {
            photos = [[AsyncImageView alloc] initWithFrame:CGRectMake(5+j*74, 0, 70, 70)];
        } else {
            photos = [[AsyncImageView alloc] initWithFrame:CGRectMake(5+j*74, 75, 70, 70)];

            j ++;
            
        }
        
        [photos setImageURL: [urls objectAtIndex:i]];
        [_viewPhotoGroup addSubview:photos];
        
    }
}

- (IBAction)onMyActivities:(id)sender {
    [self performSegueWithIdentifier:@"goMyWorkouts" sender:nil];
    
}

- (IBAction)onAchievements:(id)sender {
    [self performSegueWithIdentifier:@"goAchievements" sender:nil];
}

- (IBAction)onWorkoutLibrary:(id)sender {
    [self performSegueWithIdentifier:@"Achievements" sender:nil];
}

- (IBAction)onGetTrainner:(id)sender {
    [self performSegueWithIdentifier:@"goGetTrainer" sender:nil];
    
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)onNextClick:(id)sender {
}

- (IBAction)onBackPhotoClick:(id)sender {
}

- (IBAction)onMenuBtnClick:(id)sender {
    
    if ([self isMenuBoxVisible]) {
        [self hideMenuView];
    } else {
        [self showMenuView];
    }

    
}



- (UILabel *) createLabel: (NSString *)title positionRect: (CGRect)rect
{
    
    _lblFoods = [[UILabel alloc] initWithFrame:rect];
    _lblFoods.text = title;
    _lblFoods.tag = n_lblcount;
    _lblFoods.textColor = [UIColor blackColor];
    _lblFoods.lineBreakMode = NSLineBreakByWordWrapping;
    _lblFoods.backgroundColor = [UIColor clearColor];
    
    [_arrayLabel addObject:_lblFoods];
    return _lblFoods;
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




////////////////////////////================/////////////////////////

#pragma mark ServerCallDelegate

- (void) getTraineePhotos
{
    get_info = GET_PHOTOS;
    NSDictionary *dict;
    
    NSString *user_id = APPDELEGATE.userInfo.user_id;
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    APPDELEGATE.serverCall.delegate = self;
    
    [self showProgress:@"Please Wait"];
    dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", user_id, @"id", nil];
    
    [APPDELEGATE.serverCall requestServer:dict url:@"get_trainee_photos"];
    NSLog(@"%@", dict);

}



- (void) getAllergicFood {
    
    get_info = GET_ALLERGICFOOD;
    NSDictionary *dict;
    
    NSString *user_id = APPDELEGATE.userInfo.user_id;
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    APPDELEGATE.serverCall.delegate = self;
    
    dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", user_id, @"id", nil];
    
    [APPDELEGATE.serverCall requestServer:dict url:@"get_allergies"];
    NSLog(@"%@", dict);
}

- (void) getUnwantedFood {
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    APPDELEGATE.serverCall.delegate = self;

    get_info = GET_UNWANTEDFOOD;
    NSString *user_id = APPDELEGATE.userInfo.user_id;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", user_id, @"id", nil];
   
    [APPDELEGATE.serverCall requestServer:dict url:@"get_unwanted_food"];
    NSLog(@"%@", dict);
}

- (void) getHealthyCondition {
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    APPDELEGATE.serverCall.delegate = self;

    get_info = GET_HEALTHY;
    NSString *user_id = APPDELEGATE.userInfo.user_id;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", user_id, @"trainee_id", nil];
    
    [APPDELEGATE.serverCall requestServer:dict url:@"get_health_condition"];
    NSLog(@"%@", dict);

}

- (void) getNote {
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    APPDELEGATE.serverCall.delegate = self;

    get_info = GET_NOTE;
    NSString *user_id = APPDELEGATE.userInfo.user_id;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", user_id, @"trainee_id", nil];
    
    [APPDELEGATE.serverCall requestServer:dict url:@"get_special_note"];
    NSLog(@"%@", dict);
}



- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    
    if (get_info == GET_PHOTOS) {
        NSString *str_id = APPDELEGATE.userInfo.user_id;
        NSString *str_photo;
        NSURL *str_photo_url;
        NSMutableArray *arr_url = [[NSMutableArray alloc] init];
        
        _arrayPhotos = [dictData objectForKey:@"result"];
        for (NSDictionary *dictItem in _arrayPhotos) {
            
            str_photo = [dictItem objectForKey:@"url"];
            str_photo_url = [NSURL URLWithString:[NSString stringWithFormat:@"http://beinmedia.com/clients/workmeout/%@", str_photo]];
            
            [arr_url addObject:str_photo_url];
            
        }
        [self getPhotosToServer:arr_url count:(int)_arrayPhotos.count];
        if (_arrayPhotos.count == 0) {
            _lblNoPhotos.hidden = NO;
        } else {
            _lblNoPhotos.hidden = YES;
        }
        [self getAllergicFood];
        return;
    }
    else if (get_info == GET_ALLERGICFOOD)
    {
        NSLog(@"Allergic get Ok!");
        _arrayAllergic = [dictData objectForKey:@"result"]; ////???
        int j = 0, k = -1;
        for (int i = 0; i < _arrayAllergic.count; i++) {
            k ++;
            NSDictionary *dictItem = [_arrayAllergic objectAtIndex:i];
            if (i%3 == 0 && i > 0) {
                j ++;
                k = 0;
            }
            CGRect rect = CGRectMake(k * 100 + 35, 235 + j*30, 60, 20);
            NSString *title = [dictItem objectForKey:@"name"];
            
            [_viewEdit addSubview:[self createLabel:title positionRect:rect]];
        }
        
        APPDELEGATE.arr_allergic = _arrayAllergic;
        [self getUnwantedFood];
        return;
    }
    else if (get_info == GET_UNWANTEDFOOD)
    {
        NSLog(@"Allergic get Ok!");
        _arrayUnwantedFood = [dictData objectForKey:@"result"];
        int j = 0, k = -1;
        for (int i = 0; i < _arrayUnwantedFood.count; i++) {
            k ++;
            NSDictionary *dictItem = [_arrayUnwantedFood objectAtIndex:i];
            if (i%3 == 0 && i > 0) {
                j ++;
                k = 0;
            }
            CGRect rect = CGRectMake(k * 100 + 35, 353 + j*30, 60, 20);
            NSString *title = [dictItem objectForKey:@"name"];
            
            [_viewEdit addSubview:[self createLabel:title positionRect:rect]];

        }
        
        APPDELEGATE.arr_unwanted = _arrayUnwantedFood;
        [self getHealthyCondition];
        return;
    }
    else if (get_info == GET_HEALTHY)
    {
        
        _lblHealthyCondition.text = [dictData objectForKey:@"condition"];
        
        [self getNote];
        return;
    }
    else if (get_info == GET_NOTE)
    {
        _txtViewComments.text = [dictData objectForKey:@"note"];
        
    }
    
    [self hideProgress];
    
}

- (void) OnConnectFail
{
    [self hideProgress];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Get profile info failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
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
