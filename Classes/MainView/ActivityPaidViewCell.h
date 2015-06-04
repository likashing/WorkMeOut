//
//  ActivityPaidViewCell.h
//  WorkMeOut
//
//  Created by LiKaShing on 21/2/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityPaidViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblCreated;


@property (strong, nonatomic) IBOutlet UIButton *btnGoWorkout;
@property (strong, nonatomic) IBOutlet UIButton *btnViewDiet;


@end
