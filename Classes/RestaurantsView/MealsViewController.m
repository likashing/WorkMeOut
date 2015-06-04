//
//  MealsViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "MealsViewController.h"
#import "RestaurantsCollectionViewCell.h"
#import "NutritionalViewController.h"



@interface MealsViewController ()

@end

@implementation MealsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLanguageChangeNotification:) name:kNotificationLanguageChanged object:nil];
    [self configureViewFromLocalisation];

    [self initComponents];
    [self dataRequest];
    
}

- (void) configureViewFromLocalisation
{
    _navigationBar.title = LOCALIZATION(@"Exercise List");
    
}


- (void) receiveLanguageChangeNotification: (NSNotification *) notification
{
    if ([notification.name isEqualToString:kNotificationLanguageChanged]) {
        [self configureViewFromLocalisation];
    }
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationLanguageChanged object:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initComponents
{
    _viewSortBy.layer.cornerRadius = 5;
    _viewFilter.layer.cornerRadius = 5;
    
}




- (IBAction)onSortByClick:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"- Sort By -" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles: @"Popularity", @"Alphabeically", nil];

    sheet.tag = 111;
    [sheet showInView:self.view];

}

- (IBAction)onFilterClick:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"- Filter -" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"All meals", @"Breakfast", @"Lunch", @"Dinner", @"Food below 500cal", nil];
    
    sheet.tag = 222;
    [sheet showInView:self.view];
}

- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}




#pragma mark UIActionSheet Delegate

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 111) {
        if (buttonIndex == 0) {
            _txtSortBy.text = @"Popularity";
        } else if (buttonIndex == 1) {
            _txtSortBy.text = @"Alphabeically";
        }

    } else if (actionSheet.tag == 222) {
        if (buttonIndex == 0) {
            _txtFilter.text = @"All meals";
        } else if (buttonIndex == 1) {
            _txtFilter.text = @"Breakfast";
        } else if (buttonIndex == 2) {
            _txtFilter.text = @"Lunch";
        } else if (buttonIndex == 3) {
            _txtFilter.text = @"Dinner";
        } else if (buttonIndex == 4) {
            _txtFilter.text = @"Food below 500cal";
        }

    }
}


////////////////////===================////////////////////////
#pragma mark UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_arr_meals count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RestaurantsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MealsCell" forIndexPath:indexPath];
    NSDictionary *dict = [_arr_meals objectAtIndex:indexPath.item];
    NSString *str_imageurl = [dict objectForKey:@"image"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://beinmedia.com/clients/workmeout/%@", str_imageurl]];
    [cell.imgRestaurants setImageURL: url];
    
    cell.layer.cornerRadius = 5;
    
    NSLog(@"full URL: %@", url);
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    index = indexPath.item;
    [self performSegueWithIdentifier:@"goDetails" sender:nil];
}


/////////////////////////////////////////////////////////////

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NutritionalViewController *view = [segue destinationViewController];
    NSDictionary *dict = [_arr_meals objectAtIndex:index];
    NSString *str_id = [dict objectForKey:@"id"];
    
    view.meals_id = [str_id integerValue];
    
}



///////////////////=================///////////////////////

#pragma mark ServerCallDelegate
- (void) dataRequest {
    
    [SVProgressHUD show];
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    NSString *str_user_id = APPDELEGATE.userInfo.user_id;
    NSString *str_restaurant_id = [NSString stringWithFormat:@"%ld", (long)_restaurants_id];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: str_user_id, @"user_id", str_restaurant_id, @"id", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_restaurant_meals"];
    
    
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    [SVProgressHUD dismiss];
    NSLog(@"%@", dictData);
    
    _arr_meals = [[NSMutableArray alloc] init];
    _arr_meals = [dictData objectForKey:@"result"];
    //result = id, restaurant_id, name
    
    
    [_collectionView reloadData];
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Meals getting failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}










@end
