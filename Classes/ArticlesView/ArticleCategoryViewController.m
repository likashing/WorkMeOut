//
//  ArticleCategoryViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "ArticleCategoryViewController.h"
#import "ArticleCategoryTableViewCell.h"


@interface ArticleCategoryViewController ()

@end

@implementation ArticleCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self componentsFormat];
    
    [self dataRequest];
    
}

- (void) componentsFormat
{
    _dbhandler = [[DBHandler alloc] init];
    
    _viewFoodItem.layer.cornerRadius = 5;
    
    _txtFoodItem.layer.cornerRadius = 5;
    
    _array = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) tableviewCreate
{
    _tblArtCategory = [[UITableView alloc] init];
    _tblArtCategory.delegate = self;
    _tblArtCategory.dataSource = self;
    
}


- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    [_txtFoodItem resignFirstResponder];
    
    return YES;
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
    
    ArticleCategoryTableViewCell *cell = [_tblArtCategory dequeueReusableCellWithIdentifier:@"ArtCategoryCell"];
        
    //[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (_array.count != 0) {
        NSDictionary *temp = [_array objectAtIndex:indexPath.row];
        cell.lblArticleCategoryName.text = [temp objectForKey:@"name"];
        cell.lblArticleCount.text = [NSString stringWithFormat:@"%@ articles", [temp objectForKey:@"articles_count"]];
    }
    
    //[cell.btnNext addTarget:self action:@selector(onNextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    APPDELEGATE.n_select_index = indexPath.row;
    [self performSegueWithIdentifier:@"goSubArticles" sender:nil];
}



//////////////////////=========////////////////////////

#pragma mark ServerCall Delegate

- (void) dataRequest
{
    [SVProgressHUD show];
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    NSString *str_user_id = APPDELEGATE.userInfo.user_id;
    NSString *str_category_id = @"1"; // Enter Category`s ID

    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:str_user_id, @"user_id", str_category_id, @"id", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_article_subcategories"];
    
}


- (void) OnReceived:(NSDictionary *)dictData
{
    [SVProgressHUD dismiss];
    NSLog(@"%@", dictData);
    
    _array = [dictData objectForKey:@"result"];
    
    APPDELEGATE.receivedInfo.arrArtCategory = _array;
    
    //[_dbhandler insertDBInfoListArtCategory:array];
    
    [_tblArtCategory reloadData];
    
    NSLog(@"%lu", (unsigned long)_array.count);
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Operation failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
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
