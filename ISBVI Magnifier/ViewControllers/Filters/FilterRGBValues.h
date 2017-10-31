//
//  FilterRGBValues.h
//  ISBVI Magnifier
//
//  Created by Manik Kalra on 2/25/16.
//  Copyright © 2016 Manik Kalra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef struct
{
    CGFloat backgroundRed;
    CGFloat backgroundGreen;
    CGFloat backgroundBlue;
    CGFloat textRed;
    CGFloat textGreen;
    CGFloat textBlue;
} filterRGBValues;

@interface FilterRGBValues : NSObject

+(instancetype)sharedInstance;

-(filterRGBValues)inversionFilterValues;
-(filterRGBValues)greenBackgroundBlueTextFilterValues;
-(filterRGBValues)blueBackgroundGreenTextFilterValues;
-(filterRGBValues)blackBackgroundYellowTextFilterValues;
-(filterRGBValues)yellowBackgroundBlackTextFilterValues;
-(filterRGBValues)orangeBackgroundBlackTextFilterValues;
-(filterRGBValues)blackBackgroundOrangeTextFilterValues;
-(filterRGBValues)yellowBackgroundBlueTextFilterValues;
-(filterRGBValues)blueBackgroundYellowTextFilterValues;
-(filterRGBValues)whiteBackgroundBlueTextFilterValues;
-(filterRGBValues)blueBackgroundWhiteTextFilterValues;
-(filterRGBValues)blackBackgroundPinkTextFilterValues;

@end
