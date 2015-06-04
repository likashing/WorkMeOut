//
//  ActivityTableViewCell.h
//  WorkMeOut
//
//  Created by LiKaShing on 17/02/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityTableViewCell : UITableViewCell



@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblCreated;


@property (strong, nonatomic) IBOutlet UIButton *btnGotoWorkout;



@end
