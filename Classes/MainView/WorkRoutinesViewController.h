//
//  WorkRoutinesViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXPopover.h"
#import "AppDelegate.h"



typedef enum {
    state_add,
    state_del,
    state_edit,
    state_copy
} EDITMENU_STATE;



@interface WorkRoutinesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIPopoverControllerDelegate, ServerCallDelegate>
{
    int nEditBtnIndex;
    EDITMENU_STATE editmenu_state;
    
} 

@property (strong, nonatomic) IBOutlet UITableView *tblWorkouts;
@property (strong, nonatomic) NSMutableArray *aryWorkouts;




@property (nonatomic, strong) DXPopover *popover;
@property (strong, nonatomic) UITableView *tblPopover;

@property (strong, nonatomic) NSArray *aryTitle;


///===///===///===////

@property (strong, nonatomic) IBOutlet UIView *viewMenuBox;
@property (strong, nonatomic) IBOutlet UIView *viewEditMenu;


- (IBAction)onMenuBtnClick:(id)sender;
- (IBAction)onEditBtnClick:(id)sender;


// Sub Menu Button Events

- (IBAction)onAddWorkoutClick:(id)sender;
- (IBAction)onDelWorkoutClick:(id)sender;
- (IBAction)onEditWorkoutClick:(id)sender;
- (IBAction)onCopyWorkoutClick:(id)sender;


- (IBAction)onMyActivitiesClick:(id)sender;
- (IBAction)onAchievementsClick:(id)sender;
- (IBAction)onWorkoutLibrary:(id)sender;
- (IBAction)onGetTrainerClick:(id)sender;
- (IBAction)onFavouriteExercisesClick:(id)sender;
- (IBAction)onMainMenuClick:(id)sender;








@end
