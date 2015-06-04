//
//  GymDirectoriesViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface GymDirectoriesViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, ServerCallDelegate>
{
    NSInteger index;
}


@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *arr_directories;







- (IBAction)onBackBtn:(id)sender;


@end
