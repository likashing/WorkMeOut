//
//  ContactUsViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
//LiKaShing*
#import "SlideNavigationController.h"
//LiKaShing



@interface ContactUsViewController : UIViewController <UIAlertViewDelegate, UITextViewDelegate, ServerCallDelegate,SlideNavigationControllerDelegate>
{
    
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UITextView *txtViewQuestion;



- (IBAction)tapGesture:(id)sender;

- (IBAction)onBackBtn:(id)sender;


- (IBAction)onSubmit:(id)sender;



@end
