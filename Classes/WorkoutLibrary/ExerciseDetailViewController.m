//
//  SideLungeViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "ExerciseDetailViewController.h"

@interface ExerciseDetailViewController ()

@end

@implementation ExerciseDetailViewController

static ExerciseDetailViewController *sharedData = nil;

+ (ExerciseDetailViewController *) SharedData
{
    if (!sharedData) {
        sharedData = [[ExerciseDetailViewController alloc] init];
    }
    return sharedData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self componentsFormat];
    
    [self dataRequest];
    
}

- (void) componentsFormat
{
    _scrollview.layer.cornerRadius = 5;
    [_scrollview setContentSize:CGSizeMake(990, 190)];
    _scrollview.scrollEnabled = NO;
    _stepImage1.hidden = false;
    
    _dictFavourite = [[NSMutableDictionary alloc] init];

    _bFavourite = APPDELEGATE.bFavourite;
    
    if (_bFavourite) {
        _btnFavourite.selected = true;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillDisappear:(BOOL)animated
{
    APPDELEGATE.bFavourite = false;
}



- (IBAction)onTabGesture:(id)sender {
    
    _stepImage1.hidden = true;
    
    [self displayMovie:_video_url];
    
}

- (IBAction)onEditBtnClick:(id)sender {
    [self performSegueWithIdentifier:@"goEditView" sender:nil];

}

- (IBAction)onStarClick:(id)sender {
    
    _btnFavourite.selected = !_btnFavourite.selected;
    _bFavourite = !_bFavourite;
    
    NSLog(@"Favourite Bool Value: %hhd", _bFavourite);
    
    for (NSMutableDictionary *temp in APPDELEGATE.arr_favoriteExercises) {
        if ([temp.description isEqual:_dictFavourite.description]) {
            bDuplicateFavourite = true;
        }
    }
    if (!bDuplicateFavourite && _bFavourite) {
        [APPDELEGATE.arr_favoriteExercises addObject:_dictFavourite];
        [APPDELEGATE saveFavoriteExerciseList];
    } else if (bDuplicateFavourite && !_bFavourite) {
        [APPDELEGATE.arr_favoriteExercises removeObject:_dictFavourite];
    } else {
        bDuplicateFavourite = false;
    }
    
    [APPDELEGATE saveFavoriteExerciseList];

    APPDELEGATE.bFavourite = _bFavourite;
    
}

- (IBAction)onAddExerciseClick:(id)sender {
    
    [self performSegueWithIdentifier:@"goEditView" sender:nil];
    
}

- (IBAction)onNextClick:(id)sender {
}

- (IBAction)onPreviousClick:(id)sender {
}

- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//LiKaShing*
- (void) displayMovie: (NSURL *) url
{
    MPMoviePlayerViewController *moviePlayer =
    [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackStateChange:)
                                                 name:MPMoviePlayerScalingModeDidChangeNotification
                                               object:moviePlayer.moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackStateChange:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:moviePlayer.moviePlayer];
    _movieController = moviePlayer;
    _movieController.moviePlayer.repeatMode = YES;
    moviePlayer.view.frame = _subpageView1.bounds;
    
    [_subpageView1 addSubview:_movieController.view];
    [_movieController.moviePlayer prepareToPlay];
    //[self  presentMoviePlayerViewControllerAnimated:moviePlayer];
    
}
-(void)playbackStateChange:(NSNotification*)aNotification{
    if ([aNotification.name isEqualToString:MPMoviePlayerScalingModeDidChangeNotification]) {
        if(_movieController.moviePlayer.isFullscreen)
        {
            [_movieController.moviePlayer setFullscreen:NO animated:YES];
            _movieController.moviePlayer.view.frame = _subpageView1.bounds;
        }else{
            [_movieController.moviePlayer setFullscreen:YES animated:YES];
            _movieController.moviePlayer.view.frame = self.view.bounds;
        }
    }else if ([aNotification.name isEqualToString:MPMoviePlayerPlaybackDidFinishNotification]){
        
    }
    
}
//LiKaShing

///////////////////===============///////////////////

#pragma mark ServerCallDelegate


- (void) dataRequest {
    
    bRequestOrder = true;
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    [SVProgressHUD show];
    //[self showProgress:@"Please Wait.."];
    
    NSString *user_id = APPDELEGATE.userInfo.user_id;
    
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", APPDELEGATE.receivedInfo.exercise_id, @"id", nil];
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_exercise"];
    
}

- (void) dataRequestSteps {
    
    bRequestOrder = false;
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    [SVProgressHUD show];
    //[self showProgress:@"Please Wait.."];
    
    NSString *user_id = APPDELEGATE.userInfo.user_id;
    
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", APPDELEGATE.receivedInfo.exercise_id, @"id", nil];
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_exercise_steps"];
    
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    _dictFavourite = (NSMutableDictionary*)dictData;
    
    if (bRequestOrder) {
        _exerciseNavi.title = [dictData objectForKey:@"name"];
        _lbl_pri_muscle.text = [dictData objectForKey:@"primary_muscle"];
        _lbl_sec_muscle.text = [dictData objectForKey:@"secondary_muscle"];
        _lbl_equipment.text = [dictData objectForKey:@"equipment"];
        
        _str_image_url = [NSURL URLWithString:[NSString stringWithFormat:@"http://beinmedia.com/clients/workmeout/%@", [dictData objectForKey:@"image"]]];

        [_stepImage1 setImageURL:_str_image_url];
        
        _video_url = [NSURL URLWithString:[NSString stringWithFormat:@"http://beinmedia.com/clients/workmeout/%@", [dictData objectForKey:@"video"]]];
        //[self displayMovie:movie_url];
        
        //[self dataRequestSteps];
        //return;

    } else {
        
        _arrSteps = [dictData objectForKey:@"result"];
//        for (int i = 0; i < _arrSteps.count; i ++) {
//            NSDictionary *temp = [_arrSteps objectAtIndex:i];
//            _str_image_url = [NSURL URLWithString:[NSString stringWithFormat:@"http://beinmedia.com/clients/workmeout/%@", [temp objectForKey:@"image"]]];
//            
//            if (i == 0) {
//                [_stepImage1 setImageURL:_str_image_url];
//            } else if (i == 1) {
//                [_stepImage2 setImageURL:_str_image_url];
//            } else if (i == 2) {
//                [_stepImage3 setImageURL:_str_image_url];
//            }
//        } 
        
    }
    
    [SVProgressHUD dismiss];
    
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Get Exercise failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}









@end
