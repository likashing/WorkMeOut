//
//  IntroductoryViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 20/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface IntroductoryViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIButton *btnEnglish;
@property (strong, nonatomic) IBOutlet UIButton *btnArab;

@property (strong, nonatomic) IBOutlet UIButton *btnStared;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;

@property (strong, nonatomic) NSArray *arrayOfLanguages;

@property (strong, nonatomic) IBOutlet UILabel *lblSelLang;
@property (strong, nonatomic) IBOutlet UILabel *lblStarted;
@property (strong, nonatomic) IBOutlet UILabel *lblLogin;


@property BOOL      bLangSelect;
@property BOOL      bLangEnglish;
@property BOOL      bLangArab;



- (IBAction)onEnglishClick:(id)sender;
- (IBAction)onArabClick:(id)sender;

- (IBAction)onGetStartClick:(id)sender;
- (IBAction)onLoginClick:(id)sender;




@end
