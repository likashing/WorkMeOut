//
//  MyDietPlanViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"



@interface MyDietPlanViewController : UIViewController <ServerCallDelegate>


@property (strong, nonatomic) IBOutlet UIScrollView *scrollview1;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview2;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview3;

@property (strong, nonatomic) IBOutlet UIView *viewBreakfast1;
@property (strong, nonatomic) IBOutlet UIView *viewLunch1;
@property (strong, nonatomic) IBOutlet UIView *viewDinner1;
@property (strong, nonatomic) IBOutlet UIView *viewBreakfast2;
@property (strong, nonatomic) IBOutlet UIView *viewLunch2;
@property (strong, nonatomic) IBOutlet UIView *viewDinner2;
@property (strong, nonatomic) IBOutlet UIView *viewBreakfast3;
@property (strong, nonatomic) IBOutlet UIView *viewLunch3;
@property (strong, nonatomic) IBOutlet UIView *viewDinner3;



@property (strong, nonatomic) IBOutlet UIButton *btnBreakfast1;
@property (strong, nonatomic) IBOutlet UIButton *btnLunch1;
@property (strong, nonatomic) IBOutlet UIButton *btnDinner1;
@property (strong, nonatomic) IBOutlet UIButton *btnBreakfast2;
@property (strong, nonatomic) IBOutlet UIButton *btnLunch2;
@property (strong, nonatomic) IBOutlet UIButton *btnDinner2;
@property (strong, nonatomic) IBOutlet UIButton *btnBreakfast3;
@property (strong, nonatomic) IBOutlet UIButton *btnLunch3;
@property (strong, nonatomic) IBOutlet UIButton *btnDinner3;




- (IBAction)onDay1Breakfast:(id)sender;
- (IBAction)onDay1Lunch:(id)sender;
- (IBAction)onDay1Dinner:(id)sender;
- (IBAction)onDay2Breakfast:(id)sender;
- (IBAction)onDay2Lunch:(id)sender;
- (IBAction)onDay2Dinner:(id)sender;
- (IBAction)onDay3Breakfast:(id)sender;
- (IBAction)onDay3Lunch:(id)sender;
- (IBAction)onDay3Dinner:(id)sender;



- (IBAction)onFoodIconClick:(id)sender;
- (IBAction)onViewWorkoutsClick:(id)sender;

- (IBAction)onMenuClick:(id)sender;


@end
