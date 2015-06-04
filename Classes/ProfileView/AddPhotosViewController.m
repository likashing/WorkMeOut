//
//  AddPhotosViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "AddPhotosViewController.h"

@interface AddPhotosViewController ()

@end

@implementation AddPhotosViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated
{
    [self initComponents];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) initComponents
{
    if (APPDELEGATE.imageBefore != nil) {
        [_imgBefore setImage: APPDELEGATE.imageBefore];
        [_imgAfter setImage: APPDELEGATE.imageAfter];
     }
    
}




- (IBAction)onAddPhoto:(id)sender {
}



- (IBAction)onBackClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}








@end
