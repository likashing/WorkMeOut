//
//  ProgramDateViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 22/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "ProgramDateViewController.h"

@interface ProgramDateViewController ()

@end

@implementation ProgramDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initComponents];
    
    [self initCalendarView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) initComponents
{
    _viewSelectProgram.layer.cornerRadius = 5;
    
    _viewCalendarBG.layer.cornerRadius = 8;
}




- (IBAction)onProgramSelect:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"- Select Program -" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Bulk/Mass(Cost-$1)", @"Weight Loss(Cost-$1)", @"Cut/Fit(Cost-$1)",  nil];
    [actionSheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        _txtSelectProgram.text = @"Bulk/Mass(Cost-$1)";
    } else if (buttonIndex == 1) {
        _txtSelectProgram.text = @"Weight Loss(Cost-$1)";
    } else {
        _txtSelectProgram.text = @"Cut/Fit(Cost-$1)";
    }
}

- (IBAction)onAvailableClick:(id)sender {
    
    UIButton *btn =(UIButton *) sender;
    btn.selected = !btn.selected;
    
}

- (IBAction)onUnavailableClick:(id)sender {
    
    UIButton *btn = (UIButton *) sender;
    btn.selected = !btn.selected;
    
}

- (IBAction)onBackClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark CalendarView Delegate 

- (void) initCalendarView
{
    [self.view setBackgroundColor:[UIColor grayColor]];
    calendarView = [[CalendarView alloc]initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width-70, self.view.bounds.size.height/2-70)];
    calendarView.delegate = self;
    calendarView.calendarDate = [NSDate date];
    calendarView.layer.cornerRadius = 5;
    [calendarView setBackgroundColor:[UIColor whiteColor]];
    
    [_viewCalendarBG addSubview:calendarView];
    
    
}

- (void) tappedOnDate:(NSDate *)selectedDate
{
    NSLog(@"Selected meeting Day: %@", selectedDate);
    
}























@end
