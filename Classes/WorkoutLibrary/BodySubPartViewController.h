//
//  BicepsViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DBHandler.h"


@interface BodySubPartViewController : UIViewController <ServerCallDelegate>



@property (strong, nonatomic) IBOutlet UINavigationItem *subBodyPartBar;
@property (strong, nonatomic) IBOutlet UIImageView *imgBackground;

@property (strong, nonatomic) IBOutlet UIButton *btnPrimaryMuscle;



@property (strong, nonatomic) NSString *strBodyName;
@property   int      bodypart_id;
@property   int      subpart_id;

@property (strong, nonatomic) DBHandler *dbhandler;


- (IBAction)onSubPart:(id)sender;
- (IBAction)onBack:(id)sender;


- (IBAction)onLongHead_1:(id)sender;
- (IBAction)onShortHead:(id)sender;

- (IBAction)onMedialHead:(id)sender;
- (IBAction)onLateralHead:(id)sender;
- (IBAction)onLongHead:(id)sender;

- (IBAction)onLateralDeltoid:(id)sender;
- (IBAction)onPosterior:(id)sender;
- (IBAction)onAnteriorDeltoid:(id)sender;

- (IBAction)onPectoralisUpper:(id)sender;
- (IBAction)onPectoralisMiddle:(id)sender;
- (IBAction)onPectoralisLower:(id)sender;

- (IBAction)onAtissimusDorsi:(id)sender;
- (IBAction)onLowerBack:(id)sender;
- (IBAction)onMiddleBack:(id)sender;

- (IBAction)onTrapezius:(id)sender;

- (IBAction)onGluteusMaximus:(id)sender;

- (IBAction)onRectusAbdominal:(id)sender;
- (IBAction)onExternalOblique:(id)sender;

- (IBAction)onVastusLateralis:(id)sender;
- (IBAction)onSartorius:(id)sender;
- (IBAction)onRectusFemoris:(id)sender;
- (IBAction)onVastusMediaus:(id)sender;
- (IBAction)onGracilis:(id)sender;

- (IBAction)onSemitendinosus:(id)sender;
- (IBAction)onBicepsFemoris:(id)sender;

- (IBAction)onCalves:(id)sender;














@end
