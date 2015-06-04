//
//  ExerciseListViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ExerciseListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ServerCallDelegate>
{
    BOOL bDuplicateRecently;
    BOOL bDuplicateFavourite;
}
 
@property (strong, nonatomic) IBOutlet UINavigationItem *navigationBar;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UIView *favouritesView;
@property (strong, nonatomic) IBOutlet UIView *exerciseView;
@property (strong, nonatomic) IBOutlet UIView *recentView;


@property (strong, nonatomic) IBOutlet UIButton *btnFavourites;
@property (strong, nonatomic) IBOutlet UIButton *btnExercise;
@property (strong, nonatomic) IBOutlet UIButton *btnRecent;


@property (strong, nonatomic) IBOutlet UITableView *tblFavorite;
@property (strong, nonatomic) IBOutlet UITableView *tblExercise;
@property (strong, nonatomic) IBOutlet UITableView *tblRecent;

@property (strong, nonatomic) NSMutableArray *array;
@property   int      subpart_id;

@property BOOL bFemaleWorkouts;



- (IBAction)onFavouritesClick:(id)sender;
- (IBAction)onExerciseClick:(id)sender;
- (IBAction)onRecentClick:(id)sender;


- (IBAction)onBackClick:(id)sender;

@end
