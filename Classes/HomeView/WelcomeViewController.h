//
//  WelcomeViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 20/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"



@interface WelcomeViewController : UIViewController <UIActionSheetDelegate, ServerCallDelegate>

@property (strong, nonatomic) IBOutlet UINavigationItem *navigationBar;

@property (strong, nonatomic) IBOutlet UIView *viewCover;
@property (strong, nonatomic) IBOutlet UIImageView *imgCover;


@property (strong, nonatomic) IBOutlet UILabel *lblManagedBy;
@property (strong, nonatomic) IBOutlet UILabel *lblContinue;



- (IBAction)onContinueClick:(id)sender;


@end
