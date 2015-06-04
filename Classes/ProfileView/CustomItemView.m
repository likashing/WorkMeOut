//
//  CustomItemView.m
//  WorkMeOut
//
//  Created by LiKaShing on 29/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "CustomItemView.h"

@implementation CustomItemView

- (UIView *) createNewView: (NSString *) title
{
//    CustomItemView *view = [[CustomItemView alloc] initWithFrame:CGRectMake(0, 0, 337, 45)];
//    view.layer.cornerRadius = 5;
    _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 320, 45)];
    
    _label.text = title;
    
    UIImage *btnImage = [UIImage imageNamed:@"btn_cross.png"];
    
    _btnCross = [[UIButton alloc] initWithFrame:CGRectMake(310, 20, 20, 20)];
    [_btnCross setBackgroundImage:btnImage forState:UIControlStateNormal];
    
    [self addSubview:_label];
    [self addSubview:_btnCross];
    
    return self;    
    
}




@end
