//
//  ArticlePageViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "ArticlePageViewController.h"
#import "CommentTableViewCell.h"



@interface ArticlePageViewController ()

@end

@implementation ArticlePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self componentsFormats];
    
    [self dataRequest];
    
}

- (void) componentsFormats
{
    
    [_scrollview setContentSize:CGSizeMake(756, 320)];
    _scrollview.scrollEnabled = NO;
    
    [_contentView setBackgroundColor:[UIColor colorWithRed:208/255.0 green:239/255.0 blue:241/255.0 alpha:0.9]];
    [_contentView setOpaque:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onDescriptionBtnClick:(id)sender {
    
    _btnDescription.selected = !_btnDescription.selected;
    
    [self showPage:YES];
}

- (IBAction)onCommentsBtnClick:(id)sender {
    
    _btnComments.selected = !_btnComments.selected;
    
    [self showPage:NO];
}

- (void) showPage: (BOOL)bShow
{
    if (bShow) {
        [_scrollview scrollRectToVisible:_descriptionView.frame animated:YES];
        _btnComments.selected = NO;
        
    } else {
        [_scrollview scrollRectToVisible:_commentsView.frame animated:YES];
        _btnDescription.selected = NO;
    }
}

- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

/////////////////////////===================////////////////////////
//#pragma mark UITableView DataSource
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 3;//[_array count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    CommentTableViewCell *cell = [_tblComments dequeueReusableCellWithIdentifier:@"CommentCell"];
//    
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    
//    if (_array.count != 0) {
//        NSDictionary *temp = [_array objectAtIndex:indexPath.row];
//        cell.lblUserName.text = APPDELEGATE.userInfo.name;
//        cell.lblNowDate.text = [temp objectForKey:@"created_at"];
//        cell.txtComments.text = [temp objectForKey:@"comment"];
//    }
//    
//    
//    
//    return cell;
//}
//
//
//- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    
//}

//////////////////////=========////////////////////////

#pragma mark ServerCall Delegate

- (void) dataRequest
{
    [SVProgressHUD show];
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    NSString *str_user_id = APPDELEGATE.userInfo.user_id;
    NSString *str_article_id = [NSString stringWithFormat:@"%ld", APPDELEGATE.n_select_index];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:str_user_id, @"user_id", str_article_id, @"id", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_article"];
    
}


- (void) OnReceived:(NSDictionary *)dictData
{
    [SVProgressHUD dismiss];
    NSLog(@"%@", dictData);
    
    _lblArtTitle.text = [dictData objectForKey:@"title"];
    NSString *str_url = [dictData objectForKey:@"image"];
    NSString *str_content = [dictData objectForKey:@"content"];
    [_contentView loadHTMLString:str_content baseURL:nil];
    
    if (![str_url isEqual:@""]) {
        [_imgCover setImageURL:[NSURL URLWithString:str_url]];
    }
    
    _array = [dictData objectForKey:@"article_comments"];
    
    [_tblComments reloadData];
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Get article procedu failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
    
}








@end
