//
//  KDGoalBarPercentLayer.h
//  AppearanceTest
//
//  Created by Kevin Donnelly on 1/10/12.
//  Copyright (c) 2012 -. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface KDGoalBarPercentLayer : CALayer

@property (nonatomic) CGFloat percent;
@property (nonatomic, retain) UIColor *color;
@end
