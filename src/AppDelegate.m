//
//  AppDelegate.m
//  ISBVI Magnifier
//
//  Created by Manik Kalra on 2/1/16.
//  Copyright © 2016 Manik Kalra. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (nonatomic, strong) MagnifierSplitViewController *splitViewController;
@property (nonatomic, strong) MagnifierLiveVideoStreamViewController *liveVideoStreamViewController;
@property (nonatomic, strong) MagnifierPhotoPickerViewController *photoPickerViewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //Allocates the main view controller for the splitscreeen
    self.splitViewController = [[MagnifierSplitViewController alloc] initWithNibName:@"MagnifierSplitViewController" bundle:nil];
    
    __weak AppDelegate *weakSelf = self;
    self.splitViewController.loadCompletionBlock = ^void(void) {
        
        // These are the main view controllers derivatives, which implement their own functions, you have the livevideo feed, and the photo picker (still image portion of the screen)
        weakSelf.liveVideoStreamViewController = [[MagnifierLiveVideoStreamViewController alloc] initWithNibName:@"MagnifierLiveVideoStreamViewController" bundle:nil];
        weakSelf.liveVideoStreamViewController.delegate = weakSelf;
        [weakSelf.splitViewController setPrimaryViewController:weakSelf.liveVideoStreamViewController];
        
        weakSelf.photoPickerViewController = [[MagnifierPhotoPickerViewController alloc] initWithNibName:@"MagnifierPhotoPickerViewController" bundle:nil];
        [weakSelf.splitViewController setSecondaryViewController:weakSelf.photoPickerViewController];
        weakSelf.photoPickerViewController.delegate = weakSelf;

    };

    [self.window setRootViewController:self.splitViewController];
    [self.window makeKeyAndVisible];
    
    // Disable sleep for the iPad
    [UIApplication sharedApplication].idleTimerDisabled = YES;

    
    return YES;
}

-(void)toggleSplitView
{
    [self.splitViewController toggleSplitView];
}

#pragma mark - Full Screen methods 

-(void)showFullScreenImageWithInfo:(JTSImageInfo *)info
{
    // Setup delegate for full screen images
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:info
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Blurred];
    
    // Present the view controller.
    [imageViewer showFromViewController:self.splitViewController transition:JTSImageViewControllerTransition_FromOriginalPosition];
}

#pragma mark - PhotoPicker Methods

 // This delegate method is called whenever a user taps on a still image in MagnifierPhotoPickerViewController
-(void)showPhotoPicker
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
            picker.delegate = self;
            
            // Optionally present picker as a form sheet on iPad
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                picker.modalPresentationStyle = UIModalPresentationFormSheet;
            
            [self.splitViewController presentViewController:picker animated:YES completion:nil];
        });
    }];
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset
{
    for (PHAsset *asset in picker.selectedAssets)
    {
        [picker deselectAsset:asset];
    }
    
    return YES;
}
 // selects pictures for library
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    // assets contains PHAsset objects.
    PHAsset *asset = assets[0];
    
    PHImageManager *manager = [PHImageManager defaultManager];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.synchronous = YES;
    
    [manager requestImageDataForAsset:asset
                              options:options
                        resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info)
    {
        UIImage *image = [UIImage imageWithData:imageData];
        [self.photoPickerViewController setImage:image];
     }];
    
    [self.splitViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Clicked Picture Handling 

// This delegate method is called whenever a user requests a picture to be clicked from the live vide stream. There is a delay between the button press and actual capture of this image. That is why this method shows an activity indicator to show some activity to the user
-(void)pictureClickRequested
{
    [self.photoPickerViewController showActivityIndicator];
}

// This delegate method is called whenever the image click from live video has been finished and the image is ready to be set in the MagnifierPhotoPickerViewController
-(void)pictureClicked:(UIImage *)image
{
     [self.photoPickerViewController setImage:image];
}

@end