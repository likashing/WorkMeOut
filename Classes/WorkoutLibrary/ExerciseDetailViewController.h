//
//  SideLungeViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "AppDelegate.h"
#import "AsyncImageView.h"


@interface ExerciseDetailViewController : UIViewController <ServerCallDelegate>
{
    BOOL bRequestOrder;
    BOOL bDuplicateFavourite;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;


@property (strong, nonatomic) MPMoviePlayerViewController *movieController;

@property (strong, nonatomic) IBOutlet UIView *subpageView1;
@property (strong, nonatomic) IBOutlet UIView *subpageView2;
@property (strong, nonatomic) IBOutlet UIView *subpageView3;

@property (strong, nonatomic) IBOutlet UINavigationItem *exerciseNavi;



@property (strong, nonatomic) IBOutlet UILabel *lbl_pri_muscle;
@property (strong, nonatomic) IBOutlet UILabel *lbl_sec_muscle;
@property (strong, nonatomic) IBOutlet UILabel *lbl_equipment;

@property (strong, nonatomic) NSURL *str_image_url;
@property (strong, nonatomic) NSURL *video_url;

@property (strong, nonatomic) NSMutableArray *arrSteps;


@property (strong, nonatomic) IBOutlet AsyncImageView *stepImage1;
@property (strong, nonatomic) IBOutlet AsyncImageView *stepImage2;
@property (strong, nonatomic) IBOutlet AsyncImageView *stepImage3;


@property (strong, nonatomic) IBOutlet UIButton *btnFavourite;
@property (strong, nonatomic) NSMutableDictionary *dictFavourite;

@property BOOL          bFavourite;



+ (ExerciseDetailViewController *) SharedData;

- (IBAction)onTabGesture:(id)sender;

- (IBAction)onEditBtnClick:(id)sender;
- (IBAction)onStarClick:(id)sender;
- (IBAction)onAddExerciseClick:(id)sender;

- (IBAction)onNextClick:(id)sender;
- (IBAction)onPreviousClick:(id)sender;

- (IBAction)onBack:(id)sender;

@end
