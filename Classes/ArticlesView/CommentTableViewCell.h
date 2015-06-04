//
//  CommentTableViewCell.h
//  WorkMeOut
//
//  Created by LiKaShing on 12/02/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *lblUserName;
@property (strong, nonatomic) IBOutlet UILabel *lblNowDate;


@property (strong, nonatomic) IBOutlet UITextView *txtComments;


@end
