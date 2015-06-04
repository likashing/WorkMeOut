//
//  DirectoryCollectionViewCell.h
//  WorkMeOut
//
//  Created by LiKaShing on 22/2/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AsyncImageView.h"
#import "CWStarRateView.h"



@interface DirectoryCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet AsyncImageView *imgDirectory;


@property (strong, nonatomic) IBOutlet UIView *viewRating;

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;

@property (strong, nonatomic) CWStarRateView *star;





- (void) initWithFrame: (CGPoint)point percent:(float)percent;


@end
