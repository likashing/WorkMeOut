//
//  ArticlesViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 20/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "ArticlesViewController.h"
#import "ArticlesTableViewCell.h"



@interface ArticlesViewController ()

@end

@implementation ArticlesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initVariable];
    
    [self dataRequest];
    
}

- (void) initVariable
{
    _dbhandler = [[DBHandler alloc] init];
    
    _array = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) onNextBtnClick: (UIButton *)sender
{
    
}

- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


///////////////////////===================////////////////////////
#pragma mark UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ArticlesTableViewCell *cell = [_tblArticles dequeueReusableCellWithIdentifier:@"ArticleCell"];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (_array.count != 0) {
        NSDictionary *temp = [_array objectAtIndex:indexPath.row];
        cell.lblArticleName.text = [temp objectForKey:@"title"];
        cell.lblUpdated.text = [temp objectForKey:@"updated_at"];
    }
    
//    [cell.btnNext addTarget:self action:@selector(onNextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *temp = [APPDELEGATE.receivedInfo.arrArticles objectAtIndex:indexPath.row];
    APPDELEGATE.n_select_index = [[temp objectForKey:@"id"] integerValue];
    [self performSegueWithIdentifier:@"goArticlePage" sender:nil];
}




///////////////////=================///////////////////////

#pragma mark ServerCallDelegate
- (void) dataRequest {
    
    [SVProgressHUD show];
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    NSString *str_user_id = APPDELEGATE.userInfo.user_id;
    NSString *str_category_id = [NSString stringWithFormat:@"%ld", (long)APPDELEGATE.n_select_index + 1];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: str_user_id, @"user_id", str_category_id, @"id", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_articles"];
    
    
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    
    _array = [dictData objectForKey:@"result"];
    
    //[_dbhandler insertDBInfoListArtSubCategory:array];
    
    APPDELEGATE.receivedInfo.arrArticles = _array;
    
    [_tblArticles reloadData];
    
    [SVProgressHUD dismiss];
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Operation failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}



///////////////================////////////////
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end


