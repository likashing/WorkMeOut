//
//  DirectoriesViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "DirectoriesViewController.h"
#import "DirectoryCollectionViewCell.h"
#import "StoreViewController.h"



@interface DirectoriesViewController ()
{
    int nRequest;
    NSInteger index;
    NSString *directory_id;
    
}
@end

@implementation DirectoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    nRequest = 0;
    
    [self dataRequestGym];
    
    [self componentsFormat];
    
    
}

- (void) componentsFormat
{
    _scrollview.layer.cornerRadius = 5;
    [_scrollview setContentSize:CGSizeMake(327, 800)];
    _scrollview.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onHealthyChoices:(id)sender {
    [self performSegueWithIdentifier:@"goHealthy" sender:nil];
}

- (IBAction)onGymDirectories:(id)sender {
    [self performSegueWithIdentifier:@"goGymDirectories" sender:nil];
}

- (IBAction)onSupplementStores:(id)sender {
    [self performSegueWithIdentifier:@"goSuplementsStore" sender:nil];
}

- (IBAction)onGymMore:(id)sender {
    [self performSegueWithIdentifier:@"goGymDirectories" sender:nil];
}

- (IBAction)onStoreMore:(id)sender {
    [self performSegueWithIdentifier:@"goSuplementsStore" sender:nil];
}

- (IBAction)onHealthyMore:(id)sender {
    [self performSegueWithIdentifier:@"goHealthy" sender:nil];
}

- (IBAction)onBackBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void) reloadCollectionView
{
    [_collectionGym reloadData];
    [_collectionStore reloadData];
    [_collectionHealthy reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"gotoDetails"]) {
        StoreViewController *view = [segue destinationViewController];
        view.directory_id = directory_id;
        
        NSLog(@"%@", directory_id);

    }
    
}



////////////////////===================////////////////////////
#pragma mark UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == _collectionGym) {
//        if (_arr_gym.count == 0) {
//            return 1;
//        }
        return [_arr_gym count];
    } else if (collectionView == _collectionStore) {
//        if (_arr_store.count == 0) {
//            return 1;
//        }
        return [_arr_store count];

    } else if (collectionView == _collectionHealthy) {
//        if (_arr_healthy.count == 0) {
//            return 1;
//        }
        return [_arr_healthy count];
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DirectoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DirectoryCell" forIndexPath:indexPath];
    NSDictionary *dict = [[NSDictionary alloc] init];
    
    if (collectionView == _collectionGym) {
        dict = [_arr_gym objectAtIndex:indexPath.item];
    } else if (collectionView == _collectionStore) {
        dict = [_arr_store objectAtIndex:indexPath.item];
    } else if (collectionView == _collectionHealthy) {
        dict = [_arr_healthy objectAtIndex:indexPath.item];
    }
    
    NSString *str_name = [dict objectForKey:@"name"];
    NSString *str_imageurl = [dict objectForKey:@"image"];
    float rate = [[dict objectForKey:@"recommended"] floatValue];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://beinmedia.com/clients/workmeout/%@", str_imageurl]];
    
    [cell.imgDirectory setImageURL: url];
    cell.lblTitle.text = str_name;
    [cell initWithFrame:cell.center percent: rate/5];
    
    if (cell.imgDirectory.image == nil) {
        //spinner display
        APPDELEGATE.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        APPDELEGATE.spinner.center = cell.center;
        [APPDELEGATE.spinner startAnimating];
        [cell addSubview:APPDELEGATE.spinner];
        
    } else {
        [APPDELEGATE.spinner stopAnimating];
        
    }
    
    cell.layer.cornerRadius = 5;
    
    NSLog(@"full URL: %@", url);
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    index = indexPath.item;
    NSDictionary *temp = [[NSDictionary alloc] init];
    
    if (collectionView == _collectionGym) {
        temp = [_arr_gym objectAtIndex:index];
        directory_id = [temp objectForKey:@"id"];
    } else if (collectionView == _collectionHealthy)
    {
        temp = [_arr_healthy objectAtIndex:index];
        directory_id = [temp objectForKey:@"id"];
    } else if (collectionView == _collectionStore)
    {
        temp = [_arr_store objectAtIndex:index];
        directory_id = [temp objectForKey:@"id"];
    }
    
    [self performSegueWithIdentifier:@"gotoDetails" sender:nil];
    
}




///////////////////////================////////////////////////
#pragma mark ServerCall Delegate

- (void) dataRequestGym
{
    [SVProgressHUD show];
    nRequest = 1;
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    NSString *str_user_id = APPDELEGATE.userInfo.user_id;
    NSString *str_type = @"gym";
    
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:str_user_id, @"user_id", str_user_id, @"id", str_type, @"type", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_directories"];
    
}

- (void) dataRequestStore
{
    nRequest = 2;
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    NSString *str_user_id = APPDELEGATE.userInfo.user_id;
    NSString *str_type = @"store";
    
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:str_user_id, @"user_id", str_user_id, @"id", str_type, @"type", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_directories"];
    
}

- (void) dataRequestHealthy
{
    nRequest = 3;
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    NSString *str_user_id = APPDELEGATE.userInfo.user_id;
    
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:str_user_id, @"user_id", str_user_id, @"id", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_recommended_directories"];
    
}



- (void) OnReceived:(NSDictionary *)dictData
{
    NSLog(@"%@", dictData);
    if (nRequest == 1) {
        _arr_gym = [[NSMutableArray alloc] init];
        _arr_gym = [dictData objectForKey:@"result"];
        
        if (_arr_gym.count == 0) {
            _lblNoGym.text = @"No Gyms Yet.";
            _btnGymsMore.hidden = YES;
        }
        [_collectionGym reloadData];
        [self dataRequestStore];
        return;
    } else if (nRequest == 2) {
        _arr_store = [[NSMutableArray alloc] init];
        _arr_store = [dictData objectForKey:@"result"];
        
        if (_arr_store.count == 0) {
            _lblNoStore.text = @"No Stores Yet.";
            _btnStoresMore.hidden = YES;
        }
        [_collectionStore reloadData];
        [self dataRequestHealthy];
        return;
    } else if (nRequest == 3) {
        _arr_healthy = [[NSMutableArray alloc] init];
        _arr_healthy = [dictData objectForKey:@"result"];
        
        if (_arr_healthy.count == 0) {
            _lblNoHealthy.text = @"No Healthy Choices Yet.";
            _btnHealthyMore.hidden = YES;
        }
        
    }
    
    
    [SVProgressHUD dismiss];
    [self reloadCollectionView];
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    [self reloadCollectionView];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Get directories failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
    
}



//LiKaShing*
#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}
//LiKaShing


@end
