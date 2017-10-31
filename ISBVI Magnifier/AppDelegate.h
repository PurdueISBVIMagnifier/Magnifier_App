//
//  AppDelegate.h
//  ISBVI Magnifier
//
//  Created by Manik Kalra on 2/1/16.
//  Copyright © 2016 Manik Kalra. All rights reserved.
//


/* This h file is the top level h file that the application refers too. It contains the open source pod files that will use libraries to acces the Sony camera features, you can find the podfile in Pods -> Podfile. The Magnifier viewcontrollers (3) also refer to this h file. 
 */

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CTAssetsPickerController/CTAssetsPickerController.h>
#import "MagnifierSplitViewController.h"
#import "MagnifierLiveVideoStreamViewController.h"
#import "MagnifierPhotoPickerViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, MagnifierPhotoPickerDelegate, MagnifierPictureClickedDelegate, CTAssetsPickerControllerDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

