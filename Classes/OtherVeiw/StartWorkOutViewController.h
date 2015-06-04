//
//  StartWorkOutViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 20/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"



@interface StartWorkOutViewController : UIViewController <ServerCallDelegate>


@property (strong, nonatomic) IBOutlet UINavigationItem *navigationBar;

@property (strong, nonatomic) IBOutlet UILabel *lblProgramName;
@property (strong, nonatomic) IBOutlet UILabel *lblDifficulty;
@property (strong, nonatomic) IBOutlet UILabel *lblFrequency;
@property (strong, nonatomic) IBOutlet UILabel *lblProgress;
@property (strong, nonatomic) IBOutlet UILabel *lblType;
@property (strong, nonatomic) IBOutlet UILabel *lblCreatedDate;


@property (strong, nonatomic) NSString *strProgramName;
@property (strong, nonatomic) NSString *strDifficulty;
@property (strong, nonatomic) NSString *strFrequency;
@property (strong, nonatomic) NSString *strProgress;
@property (strong, nonatomic) NSString *strType;
@property (strong, nonatomic) NSString *strCreatedDate;




- (IBAction)onStartWorkoutClick:(id)sender;
- (IBAction)onEndWorkoutClick:(id)sender;


- (IBAction)onBack:(id)sender;


@end
