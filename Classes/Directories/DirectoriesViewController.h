//
//  DirectoriesViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
//LiKaShing*
#import "SlideNavigationController.h"
//LiKaShing


@interface DirectoriesViewController : UIViewController <UIScrollViewDelegate, ServerCallDelegate,SlideNavigationControllerDelegate>


@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;



@property (strong, nonatomic) IBOutlet UICollectionView *collectionGym;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionStore;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionHealthy;

@property (strong, nonatomic) NSMutableArray *arr_gym;
@property (strong, nonatomic) NSMutableArray *arr_store;
@property (strong, nonatomic) NSMutableArray *arr_healthy;

@property (strong, nonatomic) IBOutlet UIButton *btnGymsMore;
@property (strong, nonatomic) IBOutlet UIButton *btnStoresMore;
@property (strong, nonatomic) IBOutlet UIButton *btnHealthyMore;


@property (strong, nonatomic) IBOutlet UILabel *lblNoGym;
@property (strong, nonatomic) IBOutlet UILabel *lblNoStore;
@property (strong, nonatomic) IBOutlet UILabel *lblNoHealthy;





- (IBAction)onHealthyChoices:(id)sender;
- (IBAction)onGymDirectories:(id)sender;
- (IBAction)onSupplementStores:(id)sender;

- (IBAction)onGymMore:(id)sender;
- (IBAction)onStoreMore:(id)sender;
- (IBAction)onHealthyMore:(id)sender;



- (IBAction)onBackBtn:(id)sender;


@end
