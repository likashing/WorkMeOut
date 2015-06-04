//
//  EditAllergicViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "EditAllergicViewController.h"
#import "CustomItemView.h"
#import "MBProgressHUD.h"


@interface EditAllergicViewController ()

@end

@implementation EditAllergicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [self componentsFormat];
    [self initTokenField];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [self.tokenField.textField resignFirstResponder];
}

//- (void) viewWillDisappear:(BOOL)animated
//{
//    self.tokens = [NSMutableArray array];
//    [self.tokenField reloadData];
//}

- (void) componentsFormat
{
    del_index = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onTapGesture:(id)sender {
    
    [_tokenField.textField resignFirstResponder];
    
}

- (IBAction)onSaveClick:(id)sender {
    
    self.tokens = [NSMutableArray array];
    [self.tokenField reloadData];

}


- (IBAction)onBack:(id)sender {
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



////////////////////////==============//////////////////////

#pragma mark TokenField init part

- (void) initTokenField
{
    
    _tokens = [[NSMutableArray alloc] init];
    NSMutableArray *arryTemp = [[NSMutableArray alloc] init];
    arryTemp = APPDELEGATE.arr_allergic;
    if (arryTemp != nil) {
        for (int i = 0; i < arryTemp.count; i ++) {
            NSDictionary *dic = [arryTemp objectAtIndex:i];
            [_tokens addObject:[dic objectForKey:@"name"]];
        }
    }
    
    _tokenField.dataSource = self;
    _tokenField.delegate = self;
    _tokenField.textField.placeholder = @"Enter a Allergic Food.";
    [_tokenField reloadData];  //refresh init.
    
    [_tokenField.textField becomeFirstResponder];
    
}

- (void)tokenDeleteButtonPressed:(UIButton *)tokenButton
{
    NSUInteger index = [self.tokenField indexOfTokenView:tokenButton.superview];
    if (index != NSNotFound) {
        
        del_index = (int)index;
        
        requestState = DEL_ALLERGIC;
        [self dataRequest:@"Deleting.."];                   // Delete
        
        
        [self.tokens removeObjectAtIndex:index];
        [self.tokenField reloadData];
    }
}

#pragma mark - ZFTokenField DataSource

- (CGFloat)lineHeightForTokenInField:(ZFTokenField *)tokenField
{
    return 50;
}

- (NSUInteger)numberOfTokenInField:(ZFTokenField *)tokenField
{
    return self.tokens.count;
}

- (UIView *)tokenField:(ZFTokenField *)tokenField viewForTokenAtIndex:(NSUInteger)index
{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"TokenView" owner:nil options:nil];
    UIView *view = nibContents[0];
    UILabel *label = (UILabel *)[view viewWithTag:2];
    UIButton *button = (UIButton *)[view viewWithTag:3];
    
    
    [button addTarget:self action:@selector(tokenDeleteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    label.text = self.tokens[index];
    CGSize size = [label sizeThatFits:CGSizeMake(1000, 40)];
    view.frame = CGRectMake(0, 0, 330, 50);
    view.backgroundColor = [UIColor colorWithRed:0.26 green:0.58 blue:0.78 alpha:1];
    
    return view;
}

#pragma mark - ZFTokenField Delegate

- (CGFloat)tokenMarginInTokenInField:(ZFTokenField *)tokenField
{
    return 5;
}

- (void)tokenField:(ZFTokenField *)tokenField didReturnWithText:(NSString *)text
{
    [self.tokens addObject:text];
    
    requestState = ADD_ALLERGIC;
    [self dataRequest:text];
    
    [tokenField reloadData];
    NSLog(@"Allergic Foods: %@", APPDELEGATE.receivedInfo.arrAllergic);
}

- (void)tokenField:(ZFTokenField *)tokenField didRemoveTokenAtIndex:(NSUInteger)index
{
    [self.tokens removeObjectAtIndex:index];
}

- (BOOL)tokenFieldShouldEndEditing:(ZFTokenField *)textField
{
    return YES;
}


////////////////////=============////////////////////
#pragma mark ProgressHUD part

- (void) showProgress:(NSString *)message
{
    [MBProgressHUD showHUDAddedTo:self.view text:message animated:YES];
}

- (void) hideProgress
{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
}


////////////////////////////================/////////////////////////

#pragma mark ServerCallDelegate

- (void) dataRequest: (NSString *)strAllergicFood {
    
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    APPDELEGATE.serverCall.delegate = self;
    
    NSDictionary *dict;
    
    NSString *user_id = APPDELEGATE.userInfo.user_id;
    
    if (requestState == ADD_ALLERGIC) {
        [self showProgress:@"Adding..."];
        dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", user_id, @"trainee_id", strAllergicFood, @"name", nil];
        
        [APPDELEGATE.serverCall requestServer:dict url:@"add_allergy"];
    
    } else if (requestState == GET_ALLERGIC) {
        [self showProgress:@"Please Wait"];
        dict = [[NSDictionary alloc] initWithObjectsAndKeys: user_id, @"user_id", user_id, @"id", nil];
        
        [APPDELEGATE.serverCall requestServer:dict url:@"get_allergies"];

    } else if (requestState == DEL_ALLERGIC) {
        [self showProgress:@"Deleting.."];
        
        NSDictionary *temp = [APPDELEGATE.arr_allergic objectAtIndex:del_index];
        NSString *str_del_id = [temp objectForKey:@"id"];
        
        dict = [[NSDictionary alloc] initWithObjectsAndKeys:user_id, @"user_id", str_del_id, @"id", nil];
        
        [APPDELEGATE.serverCall requestServer:dict url:@"delete_allergy"];
        NSLog(@"%@", str_del_id);
    }
    
    NSLog(@"%@", dict);
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    
    if (requestState == ADD_ALLERGIC) {
        
        [APPDELEGATE.arr_allergic addObject: dictData];
        
        APPDELEGATE.receivedInfo.allergic_id = [dictData objectForKey:@"id"];
        APPDELEGATE.receivedInfo.allergic_name = [dictData objectForKey:@"name"];
        
        
    } else if (requestState == GET_ALLERGIC) {
        
        NSLog(@"Allergic get Ok!");
    } else if (requestState == DEL_ALLERGIC) {
        NSLog(@"Allergic deleted Ok!");
    }
    
    
    [self hideProgress];
    
}

- (void) OnConnectFail
{
    [self hideProgress];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Operation failure!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}




@end
