//
//  StoreViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AsyncImageView.h"



@interface StoreViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, ServerCallDelegate>
{
    BOOL bDirectoryOrComments;
    DIRECTORYPART direcoryPart;
}


@property (strong, nonatomic) IBOutlet UINavigationItem *naviBar;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;


@property (strong, nonatomic) NSString *directory_id;


@property (strong, nonatomic) IBOutlet AsyncImageView *asyncImage;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription;


@property (strong, nonatomic) IBOutlet UITableView *tblComments;
@property (strong, nonatomic) IBOutlet UITextView *txtCommentView;
@property (strong, nonatomic) IBOutlet UILabel *lblPlaceHolder;

@property (strong, nonatomic) NSMutableArray *arr_comments;



- (IBAction)onSubmitClick:(id)sender;

- (IBAction)onBackBtn:(id)sender;


@end
