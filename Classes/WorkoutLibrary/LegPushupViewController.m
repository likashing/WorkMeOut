//
//  SideLungeViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "LegPushupViewController.h"

@interface LegPushupViewController ()

@end

@implementation LegPushupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self componentsFormat];
    
}

- (void) componentsFormat
{
    _scrollview.layer.cornerRadius = 5;
    [_scrollview setContentSize:CGSizeMake(990, 190)];
    _scrollview.scrollEnabled = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)onStarClick:(id)sender {
}

- (IBAction)onAddExerciseClick:(id)sender {
}

- (IBAction)onPreviousClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)onNextClick:(id)sender {
}

- (IBAction)onEditBtnClick:(id)sender {
    
    [self performSegueWithIdentifier:@"goEditView" sender:nil];
    
}

- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
