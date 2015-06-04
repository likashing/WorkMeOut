//
//  PickerSubView.h
//  WorkMeOut
//
//  Created by LiKaShing on 23/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerSubView : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>


@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIPickerView *providerPickerView;
@property (nonatomic, strong) UIToolbar *providerToolbar;

@property (nonatomic, strong) NSNumber *amount;

- (void) createPickerView: (UIViewController *) main;



@end
