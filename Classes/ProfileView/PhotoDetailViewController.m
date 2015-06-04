//
//  PhotoDetailViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "PhotoCommentTableViewCell.h"


@interface PhotoDetailViewController ()

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getDataRequest];
    
    _arr_comments = [[NSMutableArray alloc] init];
    _arr_getcomments = [[NSMutableArray alloc] init];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [self componentsFormat];
}

- (void) componentsFormat
{
    _txtComments.layer.cornerRadius = 5;

    
    [_scrollview setScrollEnabled:NO];
    
    _scrollview.frame = CGRectMake(0, -20, SCRN_WIDTH, _scrollview.frame.size.height);
    _scrollview.contentSize = CGSizeMake(SCRN_WIDTH, self.view.frame.size.height + 120);
    
    if (APPDELEGATE.imageBefore != nil) {
        [_imgBefore setImage: APPDELEGATE.imageBefore];
        [_imgAfter setImage: APPDELEGATE.imageAfter];
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onReadMoreClick:(id)sender {
    [self dismissKeyboard];
}


- (IBAction)onSaveClick:(id)sender {
    
    [self dismissKeyboard];
    [self addDataRequest];
    _scrollview.scrollEnabled = NO;
    
    [_arr_comments addObject:_txtComments.text];
    [_tblComments reloadData];
    _txtComments.text = @"";
    
}

- (IBAction)onTrushClick:(id)sender {
    
    [self dismissKeyboard];
    
}

- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void) dismissKeyboard
{
    [_txtComments resignFirstResponder];
    //_txtCommentView.text = _txtComments.text;
    
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
    
    [_txtComments resignFirstResponder];
    
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



///////////////////===============///////////////////
#pragma mark ServerCallDelegate
- (void) addDataRequest {
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    sub_request = add_comment;
    
    [SVProgressHUD show];
    NSString *str_id = APPDELEGATE.userInfo.user_id;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: str_id, @"user_id", _str_groupid, @"trainee_photo_group_id", _txtComments.text, @"comment", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"add_photo_group_comment"];
    
}




- (void) getDataRequest {
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    sub_request = get_photogroup;
    
    [SVProgressHUD show];
    NSString *str_id = APPDELEGATE.userInfo.user_id;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: str_id, @"user_id", _str_groupid, @"id", nil];
    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"get_trainee_photo_group"];
    
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    [SVProgressHUD dismiss];
    
    //result = "photo_group", "photos":{"id", "trainee_photo_group_id", "created_at", "updated_at", "url"}
    
    if (sub_request == get_photogroup) {
        _arr_photos = [dictData objectForKey:@"photos"];
        _arr_getcomments = [dictData objectForKey:@"comments"];
        if (_arr_getcomments.count != 0) {
            for (NSDictionary *tempdict in _arr_getcomments) {
                [_arr_comments addObject:[tempdict objectForKey:@"comment"]];
            }
        }
        
        NSDictionary *dictA = [_arr_photos objectAtIndex:0];
        NSString *str_imageurlA = [dictA objectForKey:@"url"];
        NSURL *urlA = [NSURL URLWithString:[NSString stringWithFormat:@"http://beinmedia.com/clients/workmeout/%@", str_imageurlA]];
        [_imgBefore setImageURL: urlA];
        
        NSDictionary *dictB = [_arr_photos objectAtIndex:1];
        NSString *str_imageurlB = [dictB objectForKey:@"url"];
        NSURL *urlB = [NSURL URLWithString:[NSString stringWithFormat:@"http://beinmedia.com/clients/workmeout/%@", str_imageurlB]];
        [_imgAfter setImageURL: urlB];
        
        
        if (_arr_photos.count == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"You don`t have photos yet." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }

    } else if (sub_request == add_comment) {
        NSLog(@"Add comment Ok.");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Photo comment save success." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];

    }
    
    [_tblComments reloadData];
}

- (void) OnConnectFail
{
    [SVProgressHUD dismiss];
    
    if (sub_request == get_photogroup) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Getting photo group failed!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];

    } else if (sub_request == add_comment) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Save commnets failed!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];

    }
    
}







@end
