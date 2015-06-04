//
//  NutritionalViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface NutritionalViewController : UIViewController <ServerCallDelegate>


@property   NSInteger         meals_id;





- (IBAction)onBack:(id)sender;


@end
