//
//  WorkoutLibraryViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DBHandler.h"
//LiKaShing*
#import "SlideNavigationController.h"
//LiKaShing

@interface WorkoutLibraryViewController : UIViewController <ServerCallDelegate,SlideNavigationControllerDelegate>
{
    BOOL bRequestOrder;
}


@property (strong, nonatomic) DBHandler *dbhandler;


@property (strong, nonatomic) IBOutlet UINavigationItem *navigationBar;


@property (strong, nonatomic) IBOutlet UILabel *lblBiceps;
@property (strong, nonatomic) IBOutlet UILabel *lblBack;
@property (strong, nonatomic) IBOutlet UILabel *lblTriceps;
@property (strong, nonatomic) IBOutlet UILabel *lblGlutes;
@property (strong, nonatomic) IBOutlet UILabel *lblCalves;
@property (strong, nonatomic) IBOutlet UILabel *lblShoulder;
@property (strong, nonatomic) IBOutlet UILabel *lblChest;
@property (strong, nonatomic) IBOutlet UILabel *lblTrapezius;
@property (strong, nonatomic) IBOutlet UILabel *lblAbdominal;
@property (strong, nonatomic) IBOutlet UILabel *lblHamstring;
@property (strong, nonatomic) IBOutlet UILabel *lblAll;
@property (strong, nonatomic) IBOutlet UILabel *lblQuadriceps;




- (IBAction)onTriceps:(id)sender;
- (IBAction)onBiceps:(id)sender;
- (IBAction)onShoulder:(id)sender;
- (IBAction)onChest:(id)sender;
- (IBAction)onBackSubPart:(id)sender;
- (IBAction)onTrapezius:(id)sender;
- (IBAction)onGlutes:(id)sender;
- (IBAction)onAbdominal:(id)sender;
- (IBAction)onQuadriceps:(id)sender;
- (IBAction)onHamstring:(id)sender;
- (IBAction)onCalves:(id)sender;


- (IBAction)onBack:(id)sender;

@end
