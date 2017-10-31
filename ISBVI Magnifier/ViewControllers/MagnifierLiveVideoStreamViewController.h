//
//  MagnifierLiveVideoStreamViewController.h
//  ISBVI Magnifier
//
//  Created by Manik Kalra on 2/4/16.
//  Copyright © 2016 Manik Kalra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>
#import <MaterialControls/MDButton.h>
#import <SonyCameraRemoteAPI/SonyCameraRemoteAPIClient.h>
#import "MagnifierImageFilters.h"

@protocol MagnifierPictureClickedDelegate <NSObject>

-(void)pictureClickRequested;
-(void)toggleSplitView;
-(void)pictureClicked:(UIImage *)image;

@end

@interface MagnifierLiveVideoStreamViewController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) id<MagnifierPictureClickedDelegate> delegate;

@end
