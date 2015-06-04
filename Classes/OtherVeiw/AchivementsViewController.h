//
//  AchivementsViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 20/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CDRTranslucentSideBar.h"
#import "LeveyPopListView.h"



@interface AchivementsViewController : UIViewController <UIActionSheetDelegate, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate, CDRTranslucentSideBarDelegate, LeveyPopListViewDelegate, ServerCallDelegate>




@property (strong, nonatomic) IBOutlet UIView *viewMenuBox;

@property (nonatomic, strong) CDRTranslucentSideBar *menuBar;


@property (strong, nonatomic) NSString *strShareSite;
@property (strong, nonatomic) NSArray *options;


@property (strong, nonatomic) UITableView *tblMenu;

- (IBAction)onMyActivites:(id)sender;
- (IBAction)onRutineClick:(id)sender;
- (IBAction)onWorkoutLibrary:(id)sender;
- (IBAction)onGetTrainer:(id)sender;
- (IBAction)onFavouriteClick:(id)sender;
- (IBAction)onMainMenuClick:(id)sender;


- (IBAction)onShareClick:(id)sender;
- (IBAction)onMenuClick:(id)sender;




@end
