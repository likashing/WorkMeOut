//
//  PhotoDetailViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AsyncImageView.h"



typedef enum : NSUInteger {
    get_photogroup,
    add_comment,
} SUB_REQUEST;

@interface PhotoDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate, ServerCallDelegate>
{
    SUB_REQUEST sub_request;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;


@property (strong, nonatomic) IBOutlet UITextView *txtComments;



@property (strong, nonatomic) IBOutlet UIButton *imageBefore;
@property (strong, nonatomic) IBOutlet UIButton *imageAfter;

@property (strong, nonatomic) IBOutlet AsyncImageView *imgBefore;
@property (strong, nonatomic) IBOutlet AsyncImageView *imgAfter;


@property (strong, nonatomic) NSMutableArray *arr_photos;
@property (strong, nonatomic) NSString *str_groupid;
@property (strong, nonatomic) NSMutableArray *arr_getcomments;
@property (strong, nonatomic) NSMutableArray *arr_comments;

@property (strong, nonatomic) IBOutlet UITableView *tblComments;
@property (strong, nonatomic) IBOutlet UILabel *lblPlaceHolder;






- (IBAction)onReadMoreClick:(id)sender;

- (IBAction)onSaveClick:(id)sender;
- (IBAction)onTrushClick:(id)sender;

- (IBAction)onBack:(id)sender;





@end
