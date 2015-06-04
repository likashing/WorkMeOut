//
//  MyPhotoViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface MyPhotoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ServerCallDelegate>
{
    BOOL bAddCell;
    NSInteger index;
}


@property (strong, nonatomic) IBOutlet UITableView *tblPhotoGroup;

@property (strong, nonatomic) NSMutableArray *arr_photos;


@property (strong, nonatomic) NSString *str_groupid;



- (IBAction)onBeforeBtn:(id)sender;
- (IBAction)onAfterBtn:(id)sender;
- (IBAction)onCommentBtn:(id)sender;
- (IBAction)onCommentClick:(id)sender;



- (IBAction)onAddClick:(id)sender;

- (IBAction)onBack:(id)sender;



@end
