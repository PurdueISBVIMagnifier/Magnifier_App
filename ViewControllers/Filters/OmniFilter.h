//
//  OmniFilter.h
//  ISBVI Magnifier
//
//  Created by Gregg Weaver on 2/25/16.
//  Copyright © 2016 Manik Kalra. All rights reserved.
//
#import <GPUImage/GPUImage.h>
#import "FilterRGBValues.h"

@interface OmniFilter : GPUImageColorMatrixFilter

-(instancetype)initWithRGBValues:(filterRGBValues)rgbValues;

@end
