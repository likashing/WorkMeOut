//
//  MyPhotoTableViewCell.h
//  WorkMeOut
//
//  Created by LiKaShing on 11/02/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"



@interface MyPhotoTableViewCell : UITableViewCell




@property (strong, nonatomic) IBOutlet UIButton *btnImageBefore;
@property (strong, nonatomic) IBOutlet UIButton *btnImageAfter;
@property (strong, nonatomic) IBOutlet AsyncImageView *imgBefore;
@property (strong, nonatomic) IBOutlet AsyncImageView *imgAfter;



@property (strong, nonatomic) IBOutlet UIButton *btnComment;



@end
