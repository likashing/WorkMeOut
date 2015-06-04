//
//  AddStepViewController.m
//  WorkMeOut
//
//  Created by LiKaShing on 21/01/15.
//  Copyright (c) 2015 LiKaShing. All rights reserved.
//

#import "AddStepViewController.h"
#import "MyPhotoViewController.h"



@interface AddStepViewController ()

@end

@implementation AddStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (IBAction)onTapGestureBefore:(id)sender {
    bClickBeforeImage = true;
    [self initPickerView];
    
}

- (IBAction)onTapGestureAfter:(id)sender {
    bClickBeforeImage = false;
    [self initPickerView];
    
}

- (void) initPickerView
{
    self.mediaPickerController = [[CRMediaPickerController alloc] init];
    self.mediaPickerController.delegate = self;
    
    [self.mediaPickerController show];

}

- (IBAction)onSaveClick:(id)sender {
    
    [self showProgress:@"Uploading.."];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       [self dataRequest];
                   });
    
    
    APPDELEGATE.imageBefore = _imageBefore.image;
    APPDELEGATE.imageAfter = _imageAfter.image;
    
}

- (IBAction)onBackClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
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



///////////////////===============///////////////////

#pragma mark ServerCallDelegate
- (void) dataRequest {
    APPDELEGATE.serverCall = [[ServerCall alloc] init];
    
    NSData *imagedata1 = UIImageJPEGRepresentation(_imageBefore.image, 0.4);
    NSData *imagedata2 = UIImageJPEGRepresentation(_imageAfter.image, 0.4);
    
    NSString *image_data1 = [self nsdataToBase64String:imagedata1];
    NSString *image_data2 = [self nsdataToBase64String:imagedata2];
    
    NSString *strID = APPDELEGATE.userInfo.user_id;
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: strID, @"user_id", strID, @"trainee_id", image_data1, @"image_data1", image_data2, @"image_data2", nil];

    
    NSLog(@"%@", dict);
    
    APPDELEGATE.serverCall.delegate = self;
    [APPDELEGATE.serverCall requestServer:dict url:@"upload_images"];
    
    
}


- (void) OnReceived: (NSDictionary*) dictData {
    
    NSLog(@"%@", dictData);
    
        
    
    [self hideProgress];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Save Success." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    
}

- (void) OnConnectFail
{
    [self hideProgress];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:@"Image save failed!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

//////////////////////==============///////////////////////////

#pragma mark Base64 Encode/Decode Proc

- (NSString *)nsdataToBase64String: (NSData *)data
{
    // Get NSString from NSData object in Base64
    NSString *base64Encoded;
    
    if ([data respondsToSelector:@selector(base64EncodedStringWithOptions:)]) {
        base64Encoded = [data base64EncodedStringWithOptions:kNilOptions];  // iOS 7+
    } else {
        base64Encoded = [data base64Encoding];
    }
    
    return base64Encoded;
}

- (NSString *)encodeToBase64String: (UIImage *)image
{
    NSString *imagedata = [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return imagedata;
}

- (UIImage *)decodeBase64ToImage: (NSString *)strEncodeData
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return [UIImage imageWithData:data];
    
}


/////////////////////==========================//////////////////

#pragma mark - CPDMediaPickerControllerDelegate

- (void)CRMediaPickerController:(CRMediaPickerController *)mediaPickerController didFinishPickingAsset:(ALAsset *)asset error:(NSError *)error
{
    if (!error) {
        
        if (asset) {
            
            if ([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                
                ALAssetRepresentation *representation = asset.defaultRepresentation;
                UIImage *image = [UIImage imageWithCGImage:representation.fullScreenImage];
                if (bClickBeforeImage) {
                    self.imageBefore.image = image;
                } else {
                    self.imageAfter.image = image;
                }
                
                
            } else if ([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo]) {
                
                self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:asset.defaultRepresentation.url];
                self.moviePlayer.movieSourceType = MPMediaTypeMovie;
                self.moviePlayer.controlStyle = MPMovieControlStyleDefault;
                self.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
                self.moviePlayer.repeatMode = MPMovieRepeatModeNone;
                self.moviePlayer.allowsAirPlay = NO;
                self.moviePlayer.shouldAutoplay = NO;
                
                //self.moviePlayer.view.frame = self.videoView.bounds;
                self.moviePlayer.view.autoresizingMask = (UIViewAutoresizing)(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
                //[self.videoView addSubview:self.moviePlayer.view];
                
                [self.moviePlayer prepareToPlay];
                
            }
            
        } else {
            NSLog(@"No media selected");
        }
        
    } else {
        NSLog(@"%@", error.localizedDescription);
    }
}

- (void)CRMediaPickerControllerDidCancel:(CRMediaPickerController *)mediaPickerController
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}



@end
