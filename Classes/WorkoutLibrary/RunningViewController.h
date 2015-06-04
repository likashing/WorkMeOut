//
//  SideLungeViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RunningViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) IBOutlet UIView *subpageView1;
@property (strong, nonatomic) IBOutlet UIView *subpageView2;
@property (strong, nonatomic) IBOutlet UIView *subpageView3;





- (IBAction)onStarClick:(id)sender;
- (IBAction)onAddExerciseClick:(id)sender;

- (IBAction)onPreviousClick:(id)sender;
- (IBAction)onNextClick:(id)sender;



- (IBAction)onEditBtnClick:(id)sender;
- (IBAction)onBack:(id)sender;

@end
