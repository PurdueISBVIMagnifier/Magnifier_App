//
//  FilterRGBValues.m
//  ISBVI Magnifier
//
//  Created by Manik Kalra on 2/25/16.
//  Copyright © 2016 Manik Kalra. All rights reserved.
//

#import "FilterRGBValues.h"

@implementation FilterRGBValues
{
    filterRGBValues inversionFilterValues;
    filterRGBValues greenBackgroundBlueTextFilterValues;
    filterRGBValues blueBackgroundGreenTextFilterValues;
    filterRGBValues blackBackgroundYellowTextFilterValues;
    filterRGBValues yellowBackgroundBlackTextFilterValues;
    filterRGBValues blackBackgroundOrangeTextFilterValues;
    filterRGBValues orangeBackgroundBlackTextFilterValues;
    filterRGBValues blueBackgroundYellowTextFilterValues;
    filterRGBValues yellowBackgroundBlueTextFilteValues;
    filterRGBValues blueBackgroundWhiteTextFilterValues;
    filterRGBValues whiteBackgroundBlueTextFilteValues;
    filterRGBValues blackBackgroundPinkTextFilterValues;
}

+(instancetype)sharedInstance
{
    static FilterRGBValues *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[FilterRGBValues alloc] init];
    });
    
    return sharedInstance;
}

-(instancetype)init
{
    if (self = [super init])
    {
        // Set up inversion filter
        inversionFilterValues.textRed = 255.0;
        inversionFilterValues.textGreen = 255.0;
        inversionFilterValues.textBlue = 255.0;
        inversionFilterValues.backgroundRed = 0.0;
        inversionFilterValues.backgroundGreen = 0.0;
        inversionFilterValues.backgroundBlue = 0.0;
        
        // Set up blue text and green background
        greenBackgroundBlueTextFilterValues.textRed = 0.0;
        greenBackgroundBlueTextFilterValues.textGreen = 0.0;
        greenBackgroundBlueTextFilterValues.textBlue = 127.0;
        greenBackgroundBlueTextFilterValues.backgroundRed = 0.0;
        greenBackgroundBlueTextFilterValues.backgroundGreen = 255.0;
        greenBackgroundBlueTextFilterValues.backgroundBlue = 0.0;
        
        // Set up green text and blue background
        blueBackgroundGreenTextFilterValues.textRed = 0.0;
        blueBackgroundGreenTextFilterValues.textGreen = 255.0;
        blueBackgroundGreenTextFilterValues.textBlue = 0.0;
        blueBackgroundGreenTextFilterValues.backgroundRed = 0.0;
        blueBackgroundGreenTextFilterValues.backgroundGreen = 0.0;
        blueBackgroundGreenTextFilterValues.backgroundBlue = 127.0;
        
        // Set up yellow text and black background
        blackBackgroundYellowTextFilterValues.textRed = 255.0;
        blackBackgroundYellowTextFilterValues.textGreen = 255.0;
        blackBackgroundYellowTextFilterValues.textBlue = 0.0;
        blackBackgroundYellowTextFilterValues.backgroundRed = 0.0;
        blackBackgroundYellowTextFilterValues.backgroundGreen = 0.0;
        blackBackgroundYellowTextFilterValues.backgroundBlue = 0.0;
        
        // Set up black text and yellow background
        yellowBackgroundBlackTextFilterValues.textRed = 0.0;
        yellowBackgroundBlackTextFilterValues.textGreen = 0.0;
        yellowBackgroundBlackTextFilterValues.textBlue = 0.0;
        yellowBackgroundBlackTextFilterValues.backgroundRed = 255.0;
        yellowBackgroundBlackTextFilterValues.backgroundGreen = 255.0;
        yellowBackgroundBlackTextFilterValues.backgroundBlue = 0;
        
        // Set up orange text and black background
        orangeBackgroundBlackTextFilterValues.textRed = 255.0;
        orangeBackgroundBlackTextFilterValues.textGreen = 165.0;
        orangeBackgroundBlackTextFilterValues.textBlue = 0.0;
        orangeBackgroundBlackTextFilterValues.backgroundRed = 0.0;
        orangeBackgroundBlackTextFilterValues.backgroundGreen = 0.0;
        orangeBackgroundBlackTextFilterValues.backgroundBlue = 0.0;
        
        // Set up black text and orange background
        blackBackgroundOrangeTextFilterValues.textRed = 0.0;
        blackBackgroundOrangeTextFilterValues.textGreen = 0.0;
        blackBackgroundOrangeTextFilterValues.textBlue = 0.0;
        blackBackgroundOrangeTextFilterValues.backgroundRed = 255.0;
        blackBackgroundOrangeTextFilterValues.backgroundGreen = 165.0;
        blackBackgroundOrangeTextFilterValues.backgroundBlue = 0.0;
        
        // Set up yellow text and blue background
        blueBackgroundYellowTextFilterValues.textRed = 255.0;
        blueBackgroundYellowTextFilterValues.textGreen = 255.0;
        blueBackgroundYellowTextFilterValues.textBlue = 0.0;
        blueBackgroundYellowTextFilterValues.backgroundRed = 0.0;
        blueBackgroundYellowTextFilterValues.backgroundGreen = 0.0;
        blueBackgroundYellowTextFilterValues.backgroundBlue = 127.0;
        
        // Set up blue text and yellow background
        yellowBackgroundBlueTextFilteValues.textRed = 0.0;
        yellowBackgroundBlueTextFilteValues.textGreen = 0.0;
        yellowBackgroundBlueTextFilteValues.textBlue = 127.0;
        yellowBackgroundBlueTextFilteValues.backgroundRed = 255.0;
        yellowBackgroundBlueTextFilteValues.backgroundGreen = 255.0;
        yellowBackgroundBlueTextFilteValues.backgroundBlue = 0.0;
        
        // Set up white text and blue background
        blueBackgroundWhiteTextFilterValues.textRed = 255.0;
        blueBackgroundWhiteTextFilterValues.textGreen = 255.0;
        blueBackgroundWhiteTextFilterValues.textBlue = 255.0;
        blueBackgroundWhiteTextFilterValues.backgroundRed = 0.0;
        blueBackgroundWhiteTextFilterValues.backgroundGreen = 0.0;
        blueBackgroundWhiteTextFilterValues.backgroundBlue = 127.0;
        
        // Set up blue text and white background
        whiteBackgroundBlueTextFilteValues.textRed = 0.0;
        whiteBackgroundBlueTextFilteValues.textGreen = 0.0;
        whiteBackgroundBlueTextFilteValues.textBlue = 127.0;
        whiteBackgroundBlueTextFilteValues.backgroundRed = 255.0;
        whiteBackgroundBlueTextFilteValues.backgroundGreen = 255.0;
        whiteBackgroundBlueTextFilteValues.backgroundBlue = 255.0;
        
        // Set up black text and pink background
        blackBackgroundPinkTextFilterValues.textRed = 0.0;
        blackBackgroundPinkTextFilterValues.textGreen = 0.0;
        blackBackgroundPinkTextFilterValues.textBlue = 0.0;
        blackBackgroundPinkTextFilterValues.backgroundRed = 255.0;
        blackBackgroundPinkTextFilterValues.backgroundGreen = 0.0;
        blackBackgroundPinkTextFilterValues.backgroundBlue = 128.0;
    }
    
    return self;
}

#pragma mark - Filter RGB Values 

-(filterRGBValues)inversionFilterValues
{
    return inversionFilterValues;
}

-(filterRGBValues)greenBackgroundBlueTextFilterValues
{
    return greenBackgroundBlueTextFilterValues;
}

-(filterRGBValues)blueBackgroundGreenTextFilterValues
{
    return blueBackgroundGreenTextFilterValues;
}

-(filterRGBValues)blackBackgroundYellowTextFilterValues
{
    return blackBackgroundYellowTextFilterValues;
}

-(filterRGBValues)yellowBackgroundBlackTextFilterValues
{
    return yellowBackgroundBlackTextFilterValues;
}

-(filterRGBValues)orangeBackgroundBlackTextFilterValues
{
    return orangeBackgroundBlackTextFilterValues;
}

-(filterRGBValues)blackBackgroundOrangeTextFilterValues
{
    return blackBackgroundOrangeTextFilterValues;
}

-(filterRGBValues)yellowBackgroundBlueTextFilterValues
{
    return yellowBackgroundBlueTextFilteValues;
}

-(filterRGBValues)blueBackgroundYellowTextFilterValues
{
    return blueBackgroundYellowTextFilterValues;
}

-(filterRGBValues)whiteBackgroundBlueTextFilterValues
{
    return whiteBackgroundBlueTextFilteValues;
}

-(filterRGBValues)blueBackgroundWhiteTextFilterValues
{
    return blueBackgroundWhiteTextFilterValues;
}

-(filterRGBValues)blackBackgroundPinkTextFilterValues
{
    return blackBackgroundPinkTextFilterValues;
}

@end
