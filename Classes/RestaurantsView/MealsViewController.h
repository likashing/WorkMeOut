//
//  MealsViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"



@interface MealsViewController : UIViewController <UIActionSheetDelegate, UICollectionViewDataSource, UICollectionViewDelegate, ServerCallDelegate>
{
    NSInteger index;
}

@property (strong, nonatomic) IBOutlet UINavigationItem *navigationBar;

@property (strong, nonatomic) IBOutlet UIView *viewSortBy;
@property (strong, nonatomic) IBOutlet UIView *viewFilter;

@property (strong, nonatomic) IBOutlet UITextField *txtSortBy;
@property (strong, nonatomic) IBOutlet UITextField *txtFilter;


@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *arr_meals;
@property NSInteger   restaurants_id;



- (IBAction)onSortByClick:(id)sender;
- (IBAction)onFilterClick:(id)sender;

- (IBAction)onBack:(id)sender;

@end
