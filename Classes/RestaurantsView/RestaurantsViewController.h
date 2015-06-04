//
//  RestaurantsViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DBHandler.h"


@interface RestaurantsViewController : UIViewController <UIActionSheetDelegate, UICollectionViewDataSource, UICollectionViewDelegate, ServerCallDelegate>
{
    NSInteger index;
}


@property (strong, nonatomic) IBOutlet UINavigationItem *navigationBar;
 
@property (strong, nonatomic) DBHandler *dbhandler;
@property (strong, nonatomic) IBOutlet UIView *viewSortBy;


@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;


@property (strong, nonatomic) IBOutlet UITextField *txtSortBy;

@property (strong, nonatomic) NSMutableArray *arr_restaurant;




- (IBAction)onSortByClick:(id)sender;


- (IBAction)onBack:(id)sender;

@end
