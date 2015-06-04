//
//  HealthyViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "HealthyViewController.h"
#import "StoreViewController.h"
#import "DirectoryCollectionViewCell.h"



@interface HealthyViewController ()
{
    NSInteger index;
}
@end

@implementation HealthyViewController

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
//    if (_arr_healthy.count == 0) {
//        return 1;
//    }
    return [_arr_healthy count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DirectoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DirectoryCell" forIndexPath:indexPath];
    
    NSDictionary *dict = [_arr_healthy objectAtIndex:indexPath.item];
    NSString *str_name = [dict objectForKey:@"name"];
    float rate = [[dict objectForKey:@"recommended"] floatValue];
    NSString *str_imageurl = [dict objectForKey:@"image"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://beinmedia.com/clients/workmeout/%@", str_imageurl]];
    
    [cell.imgDirectory setImageURL: url];
    cell.lblTitle.text = str_name;
    [cell initWithFrame:cell.center percent:rate/5];
    
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
    NSDictionary *dict = [_arr_healthy objectAtIndex:index];
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
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:str_user_id, @"user_id", str_user_id, @"id", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_recommended_directories"];
    
}


- (void) OnReceived:(NSDictionary *)dictData
{
    [SVProgressHUD dismiss];
    NSLog(@"%@", dictData);
    
    //result = id, directory_type_id, name, description, image, recommended,
    _arr_healthy = [[NSMutableArray alloc] init];
    _arr_healthy = [dictData objectForKey:@"result"];
    
    if (_arr_healthy.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Note!" message:@"No Healthy Choices Yet." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
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














@end
