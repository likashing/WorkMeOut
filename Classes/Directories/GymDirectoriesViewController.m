//
//  GymDirectoriesViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "GymDirectoriesViewController.h"
#import "DirectoryCollectionViewCell.h"
#import "StoreViewController.h"



@interface GymDirectoriesViewController ()

@end

@implementation GymDirectoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self dataRequest];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onBackBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}




////////////////////===================////////////////////////
#pragma mark UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    if (_arr_directories.count == 0) {
//        return 1;
//    }
    return [_arr_directories count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DirectoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DirectoryCell" forIndexPath:indexPath];
    
    NSDictionary *dict = [_arr_directories objectAtIndex:indexPath.item];
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
    [self performSegueWithIdentifier:@"goStore" sender:nil];
}


/////////////////////////////////////////////////////////////

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    StoreViewController *view = [segue destinationViewController];
    NSDictionary *dict = [_arr_directories objectAtIndex:index];
    NSString *str_id = [dict objectForKey:@"id"];
    
    view.directory_id = str_id;
    
}




//////////////////////=========////////////////////////

#pragma mark ServerCall Delegate

- (void) dataRequest
{
    [SVProgressHUD show];
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    NSString *str_user_id = APPDELEGATE.userInfo.user_id;
    NSString *str_type = @"gym"; // Enter Directory`s ID
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:str_user_id, @"user_id", str_user_id, @"id", str_type, @"type", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_directories"];
    
}


- (void) OnReceived:(NSDictionary *)dictData
{
    [SVProgressHUD dismiss];
    NSLog(@"%@", dictData);
    
    //result = id, directory_type_id, name, description, image, recommended,
    _arr_directories = [[NSMutableArray alloc] init];
    _arr_directories = [dictData objectForKey:@"result"];
    
    if (_arr_directories.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Note!" message:@"No Gyms Yet." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    
    [_collectionView reloadData];
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Directories getting failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
    
}








/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
