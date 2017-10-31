//
//  MagnifierImageFilters.h
//  ISBVI Magnifier
//
//  Created by Manik Kalra on 07/02/16.
//  Copyright © 2016 Manik Kalra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>
#import "OmniFilter.h"
#import "GPUImagePrewittEdgeDetectionFilter.h"
#import "GPUImageAdaptiveThresholdFilter.h"

//These are the emum that are called to cycle through the filters 
typedef NS_ENUM (NSInteger, MagnifierFilters)
{
    MagnifierFilterNone,
    MagnifierFilterInverted,
    MagnifierFilterBlackBackgroundPinkText,
    MagnifierFilterYellowBackgroundBlackText,
    MagnifierFilterBlackBackgroundYellowText,
    MagnifierFilterOrangeBackgroundBlackText,
    MagnifierFilterBlackBackgroundOrangeText,
    MagnifierFilterYellowBackgroundBlueText,
    MagnifierFilterBlueBackgroundYellowText,
    MagnifierFilterWhiteBackgroundBlueText,
    MagnifierFilterBlueBackgroundWhiteText,
    MagnifierFilterGreenBackgroundBlueText,
    MagnifierFilterBlueBackgroundGreenText,
    MagnifierFilterCount
};

@interface MagnifierImageFilters : NSObject

+(instancetype)sharedInstance;

// Image filtering methods
-(UIImage *)getFilteredImageForFilterIndex:(NSInteger)index andImage:(UIImage *)image;

@end
