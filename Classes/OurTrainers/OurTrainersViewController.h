//
//  OurTrainersViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface OurTrainersViewController : UIViewController <ServerCallDelegate>



@property (strong, nonatomic) IBOutlet UIButton *btnSelect;


@property (strong, nonatomic) IBOutlet UILabel *lblTrainer1;
@property (strong, nonatomic) IBOutlet UILabel *lblTrainer2;
@property (strong, nonatomic) IBOutlet UILabel *lblTrainer3;
@property (strong, nonatomic) IBOutlet UILabel *lblTrainer4;
@property (strong, nonatomic) IBOutlet UILabel *lblTrainer5;
@property (strong, nonatomic) IBOutlet UILabel *lblTrainer6;



- (IBAction)onNextClick1:(id)sender;
- (IBAction)onNextClick2:(id)sender;
- (IBAction)onNextClick3:(id)sender;
- (IBAction)onNextClick4:(id)sender;
- (IBAction)onNextClick5:(id)sender;
- (IBAction)onNextClick6:(id)sender;



- (IBAction)onCheckBtnClick:(id)sender;

- (IBAction)onBackClick:(id)sender;

@end
