//
//  CustomItemView.h
//  WorkMeOut
//
//  Created by LiKaShing on 29/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomItemView : UIView

@property (strong, nonatomic)  UILabel *label;
@property (strong, nonatomic)  UIButton *btnCross;

- (UIView *) createNewView: (NSString *) title;






@end
