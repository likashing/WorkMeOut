//
//  AddPhotosViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AsyncImageView.h"



@interface AddPhotosViewController : UIViewController <ServerCallDelegate>


@property (strong, nonatomic) IBOutlet UIButton *btnImageBefore;
@property (strong, nonatomic) IBOutlet UIButton *btnImageAfter;

@property (strong, nonatomic) IBOutlet AsyncImageView *imgBefore;
@property (strong, nonatomic) IBOutlet AsyncImageView *imgAfter;


- (IBAction)onAddPhoto:(id)sender;

- (IBAction)onBackClick:(id)sender;

@end
