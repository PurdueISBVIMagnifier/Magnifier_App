//
//  OmniFilter.m
//  ISBVI Magnifier
//
//  Created by Gregg Weaver on 2/25/16.
//  Copyright © 2016 Manik Kalra. All rights reserved.
//
// Omnifilter takes in 6 values: The RGB values of the target background color, and
// the RGB values of the target text color. Omnifilter then determines the whiteness of each
// pixel. White pixels become the target background color. Black pixels become the target text
// color. Pixels in between black and white are linear interpolated between white and black
// to an output color that is somewhere between white and black. This filter is applied pixel
// by pixel to the whole image.
//
// A colormatrix works by multiplying the input RGBA value of a pixel by a 4x4 matrix to
// determine an output RGBA value. This matrix multiplication is applied to every image.
// Omnifilter assumes that the alpha value is 1. The ouput alpha value is always 1.
// Addtionally, it is assumed that the background is white and text is black.
//
// For the filter, the numerical values for the matrix must be determined. The alpha
// column of the matrix contains the target text color so that if a pixel has a value of
// (0,0,0,1), it is a black pixel and becomes the target text color. (Observe that rBase,
// gBase, and bBase are converted from a scale of [0,255] to [0,1].) As the RGB values of
// the pixel increase they are multiplied by rScale, gScale, and bScale. These constants
// cause the output pixel to become more like the target background color and less like the
// target text color as the RGB values increase. (Observe that the scale values are divided
// by 255 to place them on a scale of [0,1] and then further divided by 3 so that the RGB
// channels are equally weighted with respect to each other. 255 * 3 = 765.) When the RGBA
// value is (255, 255, 255, 1), the negative term in the scale values exactly cancels out the
// base values and the output RGB values are the target background color.
#import "OmniFilter.h"

@implementation OmniFilter

-(instancetype)initWithRGBValues:(filterRGBValues)rgbValues
{
    if((self = [super init]))
    {
        CGFloat rBase = rgbValues.textRed / 255.0;
        CGFloat rScale = (rgbValues.backgroundRed - rgbValues.textRed) / 765.0;
        CGFloat gBase = rgbValues.textGreen / 255.0;
        CGFloat gScale = (rgbValues.backgroundGreen - rgbValues.textGreen) / 765.0;
        CGFloat bBase = rgbValues.textBlue / 255.0;
        CGFloat bScale = (rgbValues.backgroundBlue - rgbValues.textBlue) / 765.0;
    
        self.intensity = 1.0;
        self.colorMatrix = (GPUMatrix4x4)
        {
            {rScale, rScale, rScale, rBase},
            {gScale, gScale, gScale, gBase},
            {bScale, bScale, bScale, bBase},
            {0.0, 0.0, 0.0, 1.0}
        };
    }
    
    return self;
}

@end
