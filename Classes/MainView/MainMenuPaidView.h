//
//  MainMenuPaidView.h
//  WorkMeOut
//
//  Created by LiKaShing on 20/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "KDGoalBar.h"


@interface MainMenuPaidView : UIViewController <ServerCallDelegate, UITableViewDataSource, UITableViewDelegate>



@property (strong, nonatomic) IBOutlet UITableView *tblActivities;
@property (strong, nonatomic) NSMutableArray *array;

@property (strong, nonatomic) IBOutlet KDGoalBar *viewRoundProgress;


@property (strong, nonatomic) IBOutlet UILabel *lblMyProfile;
@property (strong, nonatomic) IBOutlet UILabel *lblViewProfile;

@property (strong, nonatomic) IBOutlet UILabel *lblAchievements;
@property (strong, nonatomic) IBOutlet UIButton *btnViewAll;
@property (strong, nonatomic) IBOutlet UILabel *lblBeforeAfter;
@property (strong, nonatomic) IBOutlet UILabel *lblRestaurants;
@property (strong, nonatomic) IBOutlet UILabel *lblWorkoutLibrary;
@property (strong, nonatomic) IBOutlet UILabel *lblDirectory;
@property (strong, nonatomic) IBOutlet UILabel *lblArticles;
@property (strong, nonatomic) IBOutlet UILabel *lblAskUs;
@property (strong, nonatomic) IBOutlet UILabel *lblFemaleWorkouts;





- (IBAction)onFemaleWorkouts:(id)sender;

- (IBAction)onArticleBtnClick:(id)sender;

- (IBAction)onBack:(id)sender;

@end
