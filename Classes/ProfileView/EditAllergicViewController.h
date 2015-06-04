//
//  EditAllergicViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ZFTokenField.h"



@interface EditAllergicViewController : UIViewController <ServerCallDelegate, ZFTokenFieldDataSource, ZFTokenFieldDelegate>
{
    REQUEST_ALLERGIC requestState;
    int del_index;
    
}

@property (strong, nonatomic) IBOutlet ZFTokenField *tokenField;
@property (strong, nonatomic) NSMutableArray *tokens;



@property (strong, nonatomic) NSString *strItem;





- (IBAction)onTapGesture:(id)sender;

- (IBAction)onSaveClick:(id)sender;


- (IBAction)onBack:(id)sender;

@end
