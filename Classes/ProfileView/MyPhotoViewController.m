//
//  MyPhotoViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "MyPhotoViewController.h"
#import "MyPhotoTableViewCell.h"
#import "PhotoDetailViewController.h"



@interface MyPhotoViewController ()

@end

@implementation MyPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    bAddCell = false;
    [self dataRequest];

}


- (IBAction)onCommentBtn:(id)sender {
    
    
}

- (IBAction)onCommentClick:(id)sender
{
    UIView *view = (UIView *)sender;
    NSLog(@"%d", (int)view.tag);
    index = (int)view.tag;
    [self performSegueWithIdentifier:@"goPhotoDetail" sender:nil];
}

- (IBAction)onAddClick:(id)sender {
    
    [self performSegueWithIdentifier:@"goAddPhotos" sender:nil];
    
}

- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void) goNext:(id)sender
{
    
}

/////////////////////////////////////////////////////////////

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqual:@"goPhotoDetail"]) {
        PhotoDetailViewController *view = [segue destinationViewController];
        NSDictionary *dict = [_arr_photos objectAtIndex:index*2];
        NSString *str_id = [dict objectForKey:@"trainee_photo_group_id"];
        
        view.str_groupid = str_id;
        
        NSLog(@"Photo GroupID: %@", str_id);
        
    }
    
}


////////////////////====================/////////////////////
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arr_photos count] / 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPhotoTableViewCell *cell = [_tblPhotoGroup dequeueReusableCellWithIdentifier:@"MyPhotoCell"];
    
    NSInteger i = indexPath.row * 2;
    
    NSDictionary *dictA = [_arr_photos objectAtIndex:i];
    NSString *str_imageurlA = [dictA objectForKey:@"url"];
    NSURL *urlA = [NSURL URLWithString:[NSString stringWithFormat:@"http://beinmedia.com/clients/workmeout/%@", str_imageurlA]];
    [cell.imgBefore setImageURL: urlA];
    
    NSDictionary *dictB = [_arr_photos objectAtIndex:i+1];
    NSString *str_imageurlB = [dictB objectForKey:@"url"];
    NSURL *urlB = [NSURL URLWithString:[NSString stringWithFormat:@"http://beinmedia.com/clients/workmeout/%@", str_imageurlB]];
    [cell.imgAfter setImageURL: urlB];
    
    cell.btnComment.tag = indexPath.row;
    
    NSLog(@"Array Count: %lu", (unsigned long)indexPath.row);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    index = indexPath.row;
    [self performSegueWithIdentifier:@"goPhotoDetail" sender:nil];
}


///////////////////===============///////////////////
#pragma mark ServerCallDelegate

- (void) dataRequest {
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    [SVProgressHUD show];
    NSString *str_id = APPDELEGATE.userInfo.user_id;
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: str_id, @"user_id", str_id, @"id", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_trainee_photos"];
    
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    //result = id, trainee_photo_group_id, trainee_id, created_at, updated_at, file_name,
    
    _arr_photos = [dictData objectForKey:@"result"];
    
    [SVProgressHUD dismiss];
    if (_arr_photos.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"You don`t have photos yet." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    [_tblPhotoGroup reloadData];
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Getting photo group failed!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}





@end
