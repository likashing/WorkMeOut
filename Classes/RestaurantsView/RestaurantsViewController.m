//
//  RestaurantsViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "RestaurantsViewController.h"
#import "RestaurantsCollectionViewCell.h"
#import "MealsViewController.h"
#import "SlidingSpinner.h"



@interface RestaurantsViewController ()

@end

@implementation RestaurantsViewController

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
    _navigationBar.title = LOCALIZATION(@"Restaurants");
    
    
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
    index = 0;
    _viewSortBy.layer.cornerRadius = 5;
    
    _dbhandler = [[DBHandler alloc] init];
    
}




- (IBAction)onSortByClick:(id)sender {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"- Sort By -" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Popularity" , @"Alphabetically", nil];
    [sheet showInView:self.view];
    
}

- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

////////////////////===================////////////////////////
#pragma mark UIActionSheet Delegate

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        _txtSortBy.text = @"Popularity";
    } else if (buttonIndex == 1) {
        _txtSortBy.text = @"Alphabeically";
    }
    
}


////////////////////===================////////////////////////
#pragma mark UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_arr_restaurant count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RestaurantsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RestaurantsCell" forIndexPath:indexPath];
    
    NSDictionary *dict = [_arr_restaurant objectAtIndex:indexPath.item];
    NSString *str_name = [dict objectForKey:@"name"];
    NSString *str_imageurl = [dict objectForKey:@"image"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://beinmedia.com/clients/workmeout/%@", str_imageurl]];
    
    [cell.imgRestaurants setImageURL: url];
    
    if (cell.imgRestaurants.image == nil) {
        //spinner display
        APPDELEGATE.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        APPDELEGATE.spinner.center = cell.center;
        [APPDELEGATE.spinner startAnimating];
        [cell addSubview:APPDELEGATE.spinner];

    } else {
        [APPDELEGATE.spinner stopAnimating];

    }
    //[cell viewWithTag:str_name];
    cell.layer.cornerRadius = 5;
    
    NSLog(@"full URL: %@", url);
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    index = indexPath.item;
    [self performSegueWithIdentifier:@"goMeals" sender:nil];
}


/////////////////////////////////////////////////////////////

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    MealsViewController *view = [segue destinationViewController];
    NSDictionary *dict = [_arr_restaurant objectAtIndex:index];
    NSString *str_id = [dict objectForKey:@"id"];
    
    view.restaurants_id = [str_id integerValue];
    
}

///////////////////=================///////////////////////

#pragma mark ServerCallDelegate
- (void) dataRequest {
    
    //[SVProgressHUD show];
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    NSString *strID = APPDELEGATE.userInfo.user_id;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: strID, @"user_id", strID, @"id", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_restaurants"];
    
    
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    //[SVProgressHUD dismiss];
    NSLog(@"%@", dictData);
    
    _arr_restaurant = [[NSMutableArray alloc] init];
    _arr_restaurant = [dictData objectForKey:@"result"];
    //result = id, name, image
    
    for (NSDictionary *dict in _arr_restaurant) {
        
    }
    
    [_collectionView reloadData];
    
    
}

- (void) OnConnectFail
{
    //[SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Restaurants info getting failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}








@end
