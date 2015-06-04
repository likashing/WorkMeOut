//
//  StoreViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "StoreViewController.h"
#import "PhotoCommentTableViewCell.h"

@interface StoreViewController ()

@end




@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initVariable];
    
    [self dataRequestDirectory];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initVariable
{
    _arr_comments = [[NSMutableArray alloc] init];
    
    _txtCommentView.layer.cornerRadius = 5;
    
    [_scrollview setScrollEnabled:NO];
    
    _scrollview.frame = CGRectMake(0, 0, SCRN_WIDTH, _scrollview.frame.size.height);
    _scrollview.contentSize = CGSizeMake(SCRN_WIDTH, self.view.frame.size.height + 120);

    
}


- (IBAction)onSubmitClick:(id)sender {
    
    [self dismissKeyboard];
    //[self addDataRequest];
    _scrollview.scrollEnabled = NO;
    
    [_arr_comments addObject:_txtCommentView.text];
    
    [self dataRequestAddComment];
    [_tblComments reloadData];
    
    _txtCommentView.text = @"";
    
    
}

- (IBAction)onBackBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void) dismissKeyboard
{
    [_txtCommentView resignFirstResponder];
    
    [_scrollview setContentOffset:CGPointMake(0, -80) animated:YES];
    
}

//////////////////////////////////
#pragma mark UITextView Delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _lblPlaceHolder.hidden = YES;
    [_scrollview setScrollEnabled:YES];
    [_scrollview setContentOffset:CGPointMake(0, 120) animated:YES];
    
    return YES;
    
}


- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    [_txtCommentView resignFirstResponder];
    
    return YES;
}

////////////////////====================/////////////////////
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arr_comments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCommentTableViewCell *cell = [_tblComments dequeueReusableCellWithIdentifier:@"PhotoCommentCell"];
    
    cell.lblName.text = APPDELEGATE.userInfo.name;
    cell.txtComments.text = [_arr_comments objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



//////////////////////=========////////////////////////

#pragma mark ServerCall Delegate

- (void) dataRequestDirectory
{
    direcoryPart = GET_DIRECTORY;
    
    [SVProgressHUD show];
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    NSString *str_user_id = APPDELEGATE.userInfo.user_id;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:str_user_id, @"user_id", _directory_id, @"id", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_directory"];
    
}

- (void) dataRequestComments
{
    direcoryPart = GET_COMMENTS;
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    NSString *str_user_id = APPDELEGATE.userInfo.user_id;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:str_user_id, @"user_id", _directory_id, @"id", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_directory_reviews"];
    
}


- (void) dataRequestAddComment
{
    direcoryPart = ADD_COMMENT;
    
    [SVProgressHUD show];
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    NSString *str_user_id = APPDELEGATE.userInfo.user_id;
    /*{
    "type": "d",
    "directory_id": "ID of the directory",
    "trainee_id": "ID of the trainee",
    "review": "The comment text",
    "rating": "4"
     */
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:str_user_id, @"user_id", str_user_id, @"trainee_id", _directory_id, @"directory_id", @"d", @"type", @"5", @"rating", _txtCommentView.text, @"review", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"add_review"];
    
}


- (void) OnReceived:(NSDictionary *)dictData
{
    
    NSDictionary *dict = [dictData objectForKey:@"result"];
    
    if (direcoryPart == GET_DIRECTORY) {
        //result = id, directory_type_id, name, description, image, recommended.
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://beinmedia.com/clients/workmeout/%@", [dict objectForKey:@"image"]]];
        
        [_asyncImage setImageURL:url];
        
        _naviBar.title = [dict objectForKey:@"description"];
        _lblDescription.text = [dict objectForKey:@"name"];
        
        [self dataRequestComments];
        return;
        
    } else if (direcoryPart == GET_COMMENTS) {
        NSLog(@"%@", dictData);
        NSMutableArray *arrTemp = [NSMutableArray array];
        arrTemp = [dictData objectForKey:@"result"];
        for (NSDictionary *temp in arrTemp) {
            [_arr_comments addObject:[temp objectForKey:@"review"]];
        }
        
    } else if (direcoryPart == ADD_COMMENT) {
        NSLog(@"%@", dictData);
    }
    [_tblComments reloadData];
    [SVProgressHUD dismiss];
    
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Get directory failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
    
}






@end
