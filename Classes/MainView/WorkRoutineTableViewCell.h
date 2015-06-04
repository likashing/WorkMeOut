//
//  WorkRoutineTableViewCell.h
//  WorkMeOut
//
//  Created by LiKaShing on 11/02/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkRoutineTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIButton *btnNext;

@property (strong, nonatomic) IBOutlet UILabel *lblWorkoutName;
@property (strong, nonatomic) IBOutlet UILabel *lblProgress;

@end
