//
//  MagnifierPhotoPickerViewController.h
//  ISBVI Magnifier
//
//  Created by Manik Kalra on 2/4/16.
//  Copyright © 2016 Manik Kalra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>
#import <MaterialControls/MDButton.h>
#import <JTSImageViewController@bulusoy/JTSImageViewController.h>
#import "MagnifierImageFilters.h"

@protocol MagnifierPhotoPickerDelegate <NSObject>

- (void)showPhotoPicker;
- (void)showFullScreenImageWithInfo:(JTSImageInfo *)info;

@end

@interface MagnifierPhotoPickerViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) id<MagnifierPhotoPickerDelegate> delegate;

-(void)showActivityIndicator;
-(void)setImage:(UIImage *)image;

@end
