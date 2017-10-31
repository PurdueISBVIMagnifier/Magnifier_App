//
//  MagnifierPhotoPickerViewController.m
//  ISBVI Magnifier
//
//  Created by Manik Kalra on 2/4/16.
//  Copyright © 2016 Manik Kalra. All rights reserved.
//

#import "MagnifierPhotoPickerViewController.h"


#define LAST_FILTER_INDEX @"last_filter_index_photos"

@interface MagnifierPhotoPickerViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *buttonContainerView;
@property (weak, nonatomic) IBOutlet UIView *chooseImageButtonContainerView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) UIImage *originalImage;
@property (nonatomic) MagnifierFilters currentFilterindex;
@property (strong, nonatomic) MDButton *rotateButton;
@property (strong, nonatomic) MDButton *chooseImageButton;

@end

@implementation MagnifierPhotoPickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    self.chooseImageButton = [[MDButton alloc] initWithFrame:self.chooseImageButtonContainerView.bounds];
    self.chooseImageButton.backgroundColor = [UIColor colorWithRed:0.612 green:0.153 blue:0.69 alpha:1];
    self.chooseImageButton.mdButtonType = 2; // MDButtonTypeFloatingAction
    self.chooseImageButton.rippleColor = [UIColor whiteColor];
    [self.chooseImageButton addTarget:self action:@selector(chooseImage) forControlEvents:UIControlEventTouchUpInside];
    [self.chooseImageButton setImage:[UIImage imageNamed:@"photos"] forState:UIControlStateNormal];
    [self.chooseImageButtonContainerView addSubview:self.chooseImageButton];
    
    self.rotateButton = [[MDButton alloc] initWithFrame:self.buttonContainerView.bounds];
    self.rotateButton.backgroundColor = [UIColor colorWithRed:0.957 green:0.263 blue:0.212 alpha:1];
    self.rotateButton.mdButtonType = 2; // MDButtonTypeFloatingAction
    self.rotateButton.rippleColor = [UIColor whiteColor];
    [self.rotateButton addTarget:self action:@selector(rotateImage) forControlEvents:UIControlEventTouchUpInside];
    [self.rotateButton setImage:[UIImage imageNamed:@"rotate"] forState:UIControlStateNormal];
    [self.buttonContainerView addSubview:self.rotateButton];
    
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 10.0;
    
    // Set up gesture recognizers on the imageView to handle swiping and tapping for filters and full-screen mode
    self.imageView.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *gestureRecognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandler:)];
    [gestureRecognizerRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [gestureRecognizerRight setNumberOfTouchesRequired:1];
    [self.imageView addGestureRecognizer:gestureRecognizerRight];
    
    UISwipeGestureRecognizer *gestureRecognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandler:)];
    [gestureRecognizerLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [gestureRecognizerLeft setNumberOfTouchesRequired:1];
    [self.imageView addGestureRecognizer:gestureRecognizerLeft];
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapHandler:)];
    tapGesture1.numberOfTapsRequired = 1;
    [self.imageView addGestureRecognizer:tapGesture1];
    
    if([[NSUserDefaults standardUserDefaults] integerForKey:LAST_FILTER_INDEX])
        self.currentFilterindex = [[NSUserDefaults standardUserDefaults] integerForKey:LAST_FILTER_INDEX];
    else
        self.currentFilterindex = MagnifierFilterNone;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.scrollView.contentSize = self.imageView.frame.size;
}

#pragma mark - Swipe and Tap Handling Methods

-(void)rightSwipeHandler:(UISwipeGestureRecognizer *)recognizer
{
    self.currentFilterindex--;
    
    if(self.currentFilterindex < 0)
        self.currentFilterindex = MagnifierFilterCount - 1;
    
    self.imageView.image = [[MagnifierImageFilters sharedInstance] getFilteredImageForFilterIndex:self.currentFilterindex andImage:self.originalImage];
    
    [[NSUserDefaults standardUserDefaults] setInteger:self.currentFilterindex forKey:LAST_FILTER_INDEX];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)leftSwipeHandler:(UISwipeGestureRecognizer *)recognizer
{
    self.currentFilterindex++;
    
    if(self.currentFilterindex == MagnifierFilterCount)
        self.currentFilterindex = 0;
    
    self.imageView.image = [[MagnifierImageFilters sharedInstance] getFilteredImageForFilterIndex:self.currentFilterindex andImage:self.originalImage];
    
    [[NSUserDefaults standardUserDefaults] setInteger:self.currentFilterindex forKey:LAST_FILTER_INDEX];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//This will handle a tap on the still image put it on full-screen mode using JTSImageViewCOntroller
-(void)tapHandler:(UISwipeGestureRecognizer *)recognizer
{
    if(self.imageView.image)
    {
        JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
        imageInfo.image = self.imageView.image;
        imageInfo.referenceRect = self.imageView.frame;
        imageInfo.referenceView = self.imageView.superview;
        [self.delegate showFullScreenImageWithInfo:imageInfo];
    }
}

#pragma mark - UiScrollViewDelegate Methods

//This is a function that will zoom in on an image
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

#pragma mark - Image Handling Methods

- (IBAction)chooseImageButtonPressed:(id)sender
{
    [self chooseImage];
}

-(void)chooseImage
{
    [self.delegate showPhotoPicker];
}

-(void)setImage:(UIImage *)image
{
    [self.activityIndicator stopAnimating];
    self.originalImage = image;
     self.imageView.image = [[MagnifierImageFilters sharedInstance] getFilteredImageForFilterIndex:self.currentFilterindex andImage:self.originalImage];
    self.scrollView.zoomScale = 1.0;
}

-(void)rotateImage
{
    self.originalImage = [self rotateUIImage:self.originalImage clockwise:YES];
    self.imageView.image = [self rotateUIImage:self.imageView.image clockwise:YES];
}

//This function will rotate an image
- (UIImage*)rotateUIImage:(UIImage*)sourceImage clockwise:(BOOL)clockwise
{
    CGSize size = sourceImage.size;
    UIGraphicsBeginImageContext(CGSizeMake(size.height, size.width));
    [[UIImage imageWithCGImage:[sourceImage CGImage] scale:1.0 orientation:clockwise ? UIImageOrientationRight : UIImageOrientationLeft] drawInRect:CGRectMake(0,0,size.height ,size.width)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(void)showActivityIndicator
{
    self.imageView.image = nil;
    [self.activityIndicator startAnimating];
}

@end
