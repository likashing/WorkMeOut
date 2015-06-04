//
//  TermsViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TermsViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *txtViewTerm;

- (IBAction)onBackBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
