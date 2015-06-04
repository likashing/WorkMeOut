//
//  EditFoodsViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ZFTokenField.h"


@interface EditFoodsViewController : UIViewController <ServerCallDelegate, ZFTokenFieldDelegate, ZFTokenFieldDataSource>
{
    REQUEST_UNWANTED_FOOD requestState;
    int del_index;
}

@property (strong, nonatomic) IBOutlet ZFTokenField *tokenField;
@property (strong, nonatomic) NSMutableArray *tokens;






- (IBAction)onSaveClick:(id)sender;

- (IBAction)onBack:(id)sender;

@end
