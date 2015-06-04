//
//  MyProfileViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDRTranslucentSideBar.h"
#import "AppDelegate.h"
#import "AsyncImageView.h"
//LiKaShing*
#import "SlideNavigationController.h"
//LiKaShing

typedef enum {
    GET_PHOTOS,
    GET_ALLERGICFOOD,
    GET_UNWANTEDFOOD,
    GET_HEALTHY,
    GET_NOTE

} GET_PROFILE_INFO;


@interface MyProfileViewController : UIViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, CDRTranslucentSideBarDelegate, ServerCallDelegate,SlideNavigationControllerDelegate>

{
    GET_PROFILE_INFO get_info;
    int n_lblcount;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview1;

@property (strong, nonatomic) IBOutlet UIView *viewEdit;
@property (strong, nonatomic) IBOutlet UIView *viewPhotoGroup;
@property (strong, nonatomic) IBOutlet UILabel *lblNoPhotos;


@property (strong, nonatomic) CDRTranslucentSideBar *menuBar;
@property (strong, nonatomic) IBOutlet UIView *viewMenuBox;


@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblGender;
@property (strong, nonatomic) IBOutlet UILabel *lblAge;
@property (strong, nonatomic) IBOutlet UILabel *lblHeight;
@property (strong, nonatomic) IBOutlet UILabel *lblWeight;

@property (strong, nonatomic) UILabel *lblFoods;

@property (strong, nonatomic) IBOutlet UILabel *lblHealthyCondition;

@property (strong, nonatomic) IBOutlet UITextView *txtViewComments;


@property (strong, nonatomic) NSMutableArray *arrayPhotos;
@property (strong, nonatomic) NSMutableArray *arrayAllergic;
@property (strong, nonatomic) NSMutableArray *arrayUnwantedFood;
@property (strong, nonatomic) NSMutableArray *arrayLabel;




- (IBAction)onMyActivities:(id)sender;
- (IBAction)onAchievements:(id)sender;
- (IBAction)onWorkoutLibrary:(id)sender;
- (IBAction)onGetTrainner:(id)sender;
- (IBAction)onBack:(id)sender;




- (IBAction)onNextClick:(id)sender;
- (IBAction)onBackPhotoClick:(id)sender;

- (IBAction)onMenuBtnClick:(id)sender;


- (void) showProgress:(NSString *)message;
- (void) hideProgress;


















@end
