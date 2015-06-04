//
//  CommentTableViewCell.h
//  WorkMeOut
//
//  Created by LiKaShing on 17/3/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCommentTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UITextView *txtComments;


@end
