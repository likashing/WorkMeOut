//
//  EditConditionsViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface EditConditionsViewController : UIViewController <ServerCallDelegate>
{
    BOOL bRequestSet;
}

@property (strong, nonatomic) IBOutlet UIButton *btnVeryhealthy;
@property (strong, nonatomic) IBOutlet UIButton *btnModerately;
@property (strong, nonatomic) IBOutlet UIButton *btnNothealthy;

@property (strong, nonatomic) IBOutlet UIImageView *img_check1;
@property (strong, nonatomic) IBOutlet UIImageView *img_check2;
@property (strong, nonatomic) IBOutlet UIImageView *img_check3;



- (IBAction)onVeryhealthy:(id)sender;
- (IBAction)onMorderatelyhealthy:(id)sender;
- (IBAction)onNothealthy:(id)sender;



- (IBAction)onBack:(id)sender;

@end
