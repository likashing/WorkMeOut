//
//  DirectoryCollectionViewCell.m
//  WorkMeOut
//
//  Created by LiKaShing on 22/2/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "DirectoryCollectionViewCell.h"

@implementation DirectoryCollectionViewCell

- (void) initWithFrame: (CGPoint)point percent:(float)percent
{
   
    _star = [[CWStarRateView alloc] initWithFrame:CGRectMake(point.x - 30, point.y - 30, 60, 15) numberOfStars:5];
    _star.scorePercent = percent;
    _star.allowIncompleteStar = YES;
    _star.hasAnimation = YES;
    [_viewRating addSubview:_star];
    
    
}




@end
