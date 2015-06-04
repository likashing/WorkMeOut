//
//  IntroductoryViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 20/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "IntroductoryViewController.h"
#import "Localisator.h"



@interface IntroductoryViewController ()

@end

@implementation IntroductoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initLanguages];
    
    [self initVariable];
    
}

- (void) initLanguages
{
    _arrayOfLanguages = [[[Localisator sharedInstance] availableLanguagesArray] copy];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLanguageChangeNotification:) name:kNotificationLanguageChanged object:nil];
    
    [self configureViewFromLocalisation];
}

- (void) configureViewFromLocalisation
{
    
    [_lblSelLang setText:LOCALIZATION(@"Select your language")];
    [_lblStarted setText:LOCALIZATION(@"Get Started")];
    [_lblLogin setText:LOCALIZATION(@"Login")];
    
}

- (void) initVariable
{
    _bLangSelect = false;
    _bLangEnglish = false;
    _bLangArab = false;
    
}



- (IBAction)onEnglishClick:(id)sender {
    
    if (_btnEnglish.selected) {
        return;
    }
    _bLangSelect = true;
    _bLangEnglish = true;
    
    [[Localisator sharedInstance] setLanguage:@"English"];
    _btnEnglish.selected = !_btnEnglish.selected;
    
    _btnStared.highlighted = false;
    _btnLogin.highlighted = false;
    
    _btnArab.selected = false;
    
}

- (IBAction)onArabClick:(id)sender {

    if (_btnArab.selected) {
        return;
    }
    _bLangSelect = true;
    _bLangArab = true;
    
    [[Localisator sharedInstance] setLanguage:@"Arabic"];
    _btnArab.selected = !_btnArab.selected;
    
    _btnStared.highlighted = false;
    _btnLogin.highlighted = false;

    
    _btnEnglish.selected = false;

}

//- (void) buttonClickCheck
//{
//    if (_bLangSelect) {
//        [_btnStared addTarget:self action:@selector(onGetStartClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_btnLogin addTarget:self action:@selector(onLoginClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//}

- (IBAction)onGetStartClick:(id)sender {
    
    if (!_bLangSelect) {
        return;
        
    } else {
        
        [self performSegueWithIdentifier:@"goSingUp" sender:nil];
    }
    
}

- (IBAction)onLoginClick:(id)sender {
    
    if (!_bLangSelect) {
        return;
        
    } else {
        
        [self performSegueWithIdentifier:@"goLogin" sender:nil];
    }

}

#pragma mark - Notification Methods

- (void) receiveLanguageChangeNotification: (NSNotification *) notification
{
    if ([notification.name isEqualToString:kNotificationLanguageChanged]) {
        [self configureViewFromLocalisation];
    }
}



#pragma mark - Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationLanguageChanged object:nil];
}






















@end
