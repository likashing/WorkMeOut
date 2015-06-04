//
//  ArticleCategoryViewController.h
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

@interface ArticleCategoryViewController : UIViewController <UITextFieldDelegate, ServerCallDelegate, UITableViewDataSource, UITableViewDelegate,SlideNavigationControllerDelegate>


@property (strong, nonatomic) IBOutlet UIView *viewFoodItem;

@property (strong, nonatomic) IBOutlet UITextField *txtFoodItem;

@property (strong, nonatomic) DBHandler *dbhandler;

@property (strong, nonatomic) IBOutlet UITableView *tblArtCategory;

@property (strong, nonatomic) NSMutableArray *array;





- (IBAction)onBack:(id)sender;





@end
