//
//  ArticlePageViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AsyncImageView.h"


@interface ArticlePageViewController : UIViewController <ServerCallDelegate, UITableViewDataSource, UITableViewDelegate>
{
    BOOL bDescriptionClick;
    BOOL bCommentsClick;
    
}


@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@property (strong, nonatomic) IBOutlet UIButton *btnDescription;
@property (strong, nonatomic) IBOutlet UIButton *btnComments;

@property (strong, nonatomic) IBOutlet UIView *descriptionView;
@property (strong, nonatomic) IBOutlet UIView *commentsView;


@property (strong, nonatomic) IBOutlet AsyncImageView *imgCover;
@property (strong, nonatomic) IBOutlet UILabel *lblArtTitle;

@property (strong, nonatomic) IBOutlet UIWebView *contentView;
@property (strong, nonatomic) IBOutlet UITableView *tblComments;

@property (strong, nonatomic) NSMutableArray *array;





- (IBAction)onDescriptionBtnClick:(id)sender;
- (IBAction)onCommentsBtnClick:(id)sender;

- (void) showPage: (BOOL)bShow;

- (IBAction)onBack:(id)sender;


@end
