//
//  MyPhotoTableViewCell.m
//  WorkMeOut
//
//  Created by LiKaShing on 11/02/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "MyPhotoTableViewCell.h"

@implementation MyPhotoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _imgBefore.layer.cornerRadius = 5;
    _imgAfter.layer.cornerRadius = 5;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
