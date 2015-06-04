//
//  MainMenuFreeView.h
//  WorkMeOut
//
//  Created by LiKaShing on 20/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "KDGoalBar.h"


@interface MainMenuFreeView : UIViewController <ServerCallDelegate, UITableViewDataSource, UITableViewDelegate>



@property (strong, nonatomic) IBOutlet UITableView *tblActivity;
@property (strong, nonatomic) NSMutableArray *array;


@property (strong, nonatomic) IBOutlet KDGoalBar *viewRoundProgress;





@property (strong, nonatomic) IBOutlet UILabel *lblStartWorkouts;
@property (strong, nonatomic) IBOutlet UILabel *lblGetTrainer;
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



- (IBAction)onArticleBtnClick:(id)sender;
- (IBAction)onFemaleWorkouts:(id)sender;


- (IBAction)onBack:(id)sender;


@end
