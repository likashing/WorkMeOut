//
//  ActivitiesViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface ActivitiesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ServerCallDelegate>


@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@property (strong, nonatomic) IBOutlet UITableView *tblComplete;
@property (strong, nonatomic) IBOutlet UITableView *tblProgress;


@property (strong, nonatomic) IBOutlet UIView *completedView;
@property (strong, nonatomic) IBOutlet UIView *inprogressView;

@property (strong, nonatomic) IBOutlet UIButton *btnInProgress;
@property (strong, nonatomic) IBOutlet UIButton *btnCompleted;

@property (strong, nonatomic) NSMutableArray *arr_completed;
@property (strong, nonatomic) NSMutableArray *arr_progress;




- (IBAction)onCompletedClick:(id)sender;
- (IBAction)onInProgressClick:(id)sender;

- (IBAction)onGotoWorkout:(id)sender;

- (IBAction)onMenuClick:(id)sender;


@end
