//
//  MagnifierImageFilters.m
//  ISBVI Magnifier
//
//  Created by Manik Kalra on 07/02/16.
//  Copyright © 2016 Manik Kalra. All rights reserved.
//

#import "MagnifierImageFilters.h"

@implementation MagnifierImageFilters
{
    GPUImageAdaptiveThresholdFilter* alterer;
}

+(instancetype)sharedInstance
{
    static MagnifierImageFilters *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[MagnifierImageFilters alloc] init];
    });
    
    return sharedInstance;
}

//calls the adaptive threshold filter
-(instancetype)init
{
    if (self = [super init])
    {
        alterer = [[GPUImageAdaptiveThresholdFilter alloc] init];
    }
    
    return self;
}

-(UIImage *)getFilteredImageForFilterIndex:(NSInteger)index andImage:(UIImage *)image
{
    index = index % MagnifierFilterCount;
    
    switch (index)
    {
        case MagnifierFilterNone:
            return image;
        case MagnifierFilterInverted:
            return [self imageWithInversionFilter:image];
        case MagnifierFilterBlackBackgroundYellowText:
            return [self imageWithBlackBackgroundYellowTextFilter:image];
        case MagnifierFilterWhiteBackgroundBlueText:
            return [self imageWithWhiteBackgroundBlueTextFilter:image];
        case MagnifierFilterYellowBackgroundBlackText:
            return [self imageWithYellowBackgroundBlackTextFilter:image];
        case MagnifierFilterOrangeBackgroundBlackText:
            return [self imageWithOrangeBackgroundBlackTextFilter:image];
        case MagnifierFilterBlackBackgroundOrangeText:
            return [self imageWithBlackBackgroundOrangeTextFilter:image];
        case MagnifierFilterYellowBackgroundBlueText:
            return [self imageWithYellowBackgroundBlueTextFilter:image];
        case MagnifierFilterBlueBackgroundYellowText:
            return [self imageWithBlueBackgroundYellowTextFilter:image];
        case MagnifierFilterBlueBackgroundWhiteText:
            return [self imageWithBlueBackgroundWhiteTextFilter:image];
        case MagnifierFilterGreenBackgroundBlueText:
            return [self imageWithgreenBackgroundBlueTextFilter:image];
        case MagnifierFilterBlueBackgroundGreenText:
            return [self imageWithblueBackgroundGreenTextFilter:image];
        case MagnifierFilterBlackBackgroundPinkText:
            return [self imageWithBlackBackgroundPinkTextFilter:image];
    }
    
    return image;
}

//filters that will be used 
-(UIImage *)imageWithInversionFilter:(UIImage *)image
{
    OmniFilter *filter = [[OmniFilter alloc] initWithRGBValues:[[FilterRGBValues sharedInstance] inversionFilterValues]];
    UIImage *altered = [alterer imageByFilteringImage:image];
    UIImage *filteredImage = [filter imageByFilteringImage:altered];
    return filteredImage;
}

-(UIImage *)imageWithYellowBackgroundBlackTextFilter:(UIImage *)image
{
    OmniFilter *filter = [[OmniFilter alloc] initWithRGBValues:[[FilterRGBValues sharedInstance] yellowBackgroundBlackTextFilterValues]];
    UIImage *altered = [alterer imageByFilteringImage:image];
    UIImage *filteredImage = [filter imageByFilteringImage:altered];
    return filteredImage;
}

-(UIImage *)imageWithBlackBackgroundYellowTextFilter:(UIImage *)image
{

    OmniFilter *filter = [[OmniFilter alloc] initWithRGBValues:[[FilterRGBValues sharedInstance] blackBackgroundYellowTextFilterValues]];
    UIImage *altered = [alterer imageByFilteringImage:image];
    UIImage *filteredImage = [filter imageByFilteringImage:altered];
    return filteredImage;
}

-(UIImage *)imageWithOrangeBackgroundBlackTextFilter:(UIImage *)image
{
    OmniFilter *filter = [[OmniFilter alloc] initWithRGBValues:[[FilterRGBValues sharedInstance] orangeBackgroundBlackTextFilterValues]];
    UIImage *altered = [alterer imageByFilteringImage:image];
    UIImage *filteredImage = [filter imageByFilteringImage:altered];
    return filteredImage;
}

-(UIImage *)imageWithBlackBackgroundOrangeTextFilter:(UIImage *)image
{
    OmniFilter *filter = [[OmniFilter alloc] initWithRGBValues:[[FilterRGBValues sharedInstance] orangeBackgroundBlackTextFilterValues]];
    UIImage *altered = [alterer imageByFilteringImage:image];
    UIImage *filteredImage = [filter imageByFilteringImage:altered];
    return filteredImage;
}

-(UIImage *)imageWithYellowBackgroundBlueTextFilter:(UIImage *)image
{
    OmniFilter *filter = [[OmniFilter alloc] initWithRGBValues:[[FilterRGBValues sharedInstance] yellowBackgroundBlueTextFilterValues]];
    UIImage *altered = [alterer imageByFilteringImage:image];
    UIImage *filteredImage = [filter imageByFilteringImage:altered];
    return filteredImage;
}

-(UIImage *)imageWithBlueBackgroundYellowTextFilter:(UIImage *)image
{
    OmniFilter *filter = [[OmniFilter alloc] initWithRGBValues:[[FilterRGBValues sharedInstance] blueBackgroundYellowTextFilterValues]];
    UIImage *altered = [alterer imageByFilteringImage:image];
    UIImage *filteredImage = [filter imageByFilteringImage:altered];
    return filteredImage;
}

-(UIImage *)imageWithWhiteBackgroundBlueTextFilter:(UIImage *)image
{
    OmniFilter *filter = [[OmniFilter alloc] initWithRGBValues:[[FilterRGBValues sharedInstance] whiteBackgroundBlueTextFilterValues]];
    UIImage *altered = [alterer imageByFilteringImage:image];
    UIImage *filteredImage = [filter imageByFilteringImage:altered];
    return filteredImage;
}

-(UIImage *)imageWithBlueBackgroundWhiteTextFilter:(UIImage *)image
{
    OmniFilter *filter = [[OmniFilter alloc] initWithRGBValues:[[FilterRGBValues sharedInstance] blueBackgroundWhiteTextFilterValues]];
    UIImage *altered = [alterer imageByFilteringImage:image];
    UIImage *filteredImage = [filter imageByFilteringImage:altered];
    return filteredImage;
}

-(UIImage *)imageWithgreenBackgroundBlueTextFilter:(UIImage *)image
{
    OmniFilter *filter = [[OmniFilter alloc] initWithRGBValues:[[FilterRGBValues sharedInstance] greenBackgroundBlueTextFilterValues]];
    UIImage *altered = [alterer imageByFilteringImage:image];
    UIImage *filteredImage = [filter imageByFilteringImage:altered];
    return filteredImage;
}

-(UIImage *)imageWithblueBackgroundGreenTextFilter:(UIImage *)image
{
    OmniFilter *filter = [[OmniFilter alloc] initWithRGBValues:[[FilterRGBValues sharedInstance] blueBackgroundGreenTextFilterValues]];
    UIImage *altered = [alterer imageByFilteringImage:image];
    UIImage *filteredImage = [filter imageByFilteringImage:altered];
    return filteredImage;
}

-(UIImage *)imageWithBlackBackgroundPinkTextFilter:(UIImage *)image
{
    OmniFilter *filter = [[OmniFilter alloc] initWithRGBValues:[[FilterRGBValues sharedInstance] blackBackgroundPinkTextFilterValues]];
    UIImage *altered = [alterer imageByFilteringImage:image];
    UIImage *filteredImage = [filter imageByFilteringImage:altered];
    return filteredImage;
}

@end
