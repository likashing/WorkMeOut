//
//  ArticlesViewController.h
//  WorkMeOut
//
//  Created by LiKaShing on 20/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DBHandler.h"



@interface ArticlesViewController : UIViewController <ServerCallDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tblArticles;

@property (strong, nonatomic) DBHandler *dbhandler;

@property (strong, nonatomic) NSMutableArray *array;



- (IBAction)onBack:(id)sender;




@end
