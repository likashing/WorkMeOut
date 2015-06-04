//
//  AddStepViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CRMediaPickerController.h"

@import MediaPlayer;

@interface AddStepViewController : UIViewController <ServerCallDelegate, CRMediaPickerControllerDelegate>
{
    BOOL bClickBeforeImage;
}


@property (strong, nonatomic) IBOutlet UIImageView *imageBefore;
@property (strong, nonatomic) IBOutlet UIImageView *imageAfter;


@property (nonatomic, strong) IBOutlet UIView *overlayView;
@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;

@property (nonatomic, strong) CRMediaPickerController *mediaPickerController;
@property (nonatomic, assign) CRMediaPickerControllerMediaType selectedMediaType;
@property (nonatomic, assign) CRMediaPickerControllerSourceType selectedSourceType;





- (IBAction)onTapGestureBefore:(id)sender;
- (IBAction)onTapGestureAfter:(id)sender;


- (IBAction)onSaveClick:(id)sender;

- (IBAction)onBackClick:(id)sender;

@end
