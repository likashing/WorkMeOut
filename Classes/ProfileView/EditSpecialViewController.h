//
//  EditSpecialViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"



@interface EditSpecialViewController : UIViewController <ServerCallDelegate, UITextViewDelegate>

{
    BOOL bRequestSet;
}


@property (strong, nonatomic) IBOutlet UITextView *txtViewNotes;





- (IBAction)tapGesture:(id)sender;


- (IBAction)onBack:(id)sender;

@end
