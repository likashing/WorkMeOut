//
//  RestaurantsCollectionViewCell.m
//  WorkMeOut
//
//  Created by LiKaShing on 21/2/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "RestaurantsCollectionViewCell.h"

@implementation RestaurantsCollectionViewCell

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imgRestaurants = [[AsyncImageView alloc] initWithFrame:self.bounds];
        _imgRestaurants.contentMode = UIViewContentModeScaleAspectFill;
        _imgRestaurants.clipsToBounds = true;
        _imgRestaurants.layer.edgeAntialiasingMask = kCALayerLeftEdge | kCALayerRightEdge | kCALayerBottomEdge | kCALayerTopEdge;
        [[self contentView] addSubview: _imgRestaurants];
    }
    return self;
}


@end
