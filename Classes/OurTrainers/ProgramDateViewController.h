//
//  ProgramDateViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarView.h"


@interface ProgramDateViewController : UIViewController <UIActionSheetDelegate, CalendarDelegate>
{
    CalendarView *calendarView;
    
}

@property (strong, nonatomic) IBOutlet UIView *viewSelectProgram;

@property (strong, nonatomic) IBOutlet UIView *viewCalendarBG;
@property (strong, nonatomic) IBOutlet UITextField *txtSelectProgram;




- (IBAction)onProgramSelect:(id)sender;


- (IBAction)onAvailableClick:(id)sender;
- (IBAction)onUnavailableClick:(id)sender;


- (IBAction)onBackClick:(id)sender;

@end
