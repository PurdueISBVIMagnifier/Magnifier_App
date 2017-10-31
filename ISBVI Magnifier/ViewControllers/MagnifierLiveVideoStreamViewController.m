//
//  MagnifierLiveVideoStreamViewController.m
//  ISBVI Magnifier
//
//  Created by Manik Kalra on 2/4/16.
//  Copyright © 2016 Manik Kalra. All rights reserved.
//

#import "MagnifierLiveVideoStreamViewController.h"

#define LAST_FILTER_INDEX @"last_filter_index_livevideo"

@interface MagnifierLiveVideoStreamViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *videoStreamImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *flickeringCoverView; // The Sony cocoapods library causes flickering on the bottom of the screen. This is simply a white rectangle that covers that flickering part.
@property (weak, nonatomic) IBOutlet UIView *buttonContainerView;
@property (weak, nonatomic) IBOutlet UIView *toggleSplitViewButtonContainerView;

@property (strong, nonatomic) MDButton *captureImagebutton;
@property (strong, nonatomic) MDButton *toggleSplitViewButton;
@property (strong, nonatomic) SonyCameraRemoteAPIClient *client;
@property (nonatomic) MagnifierFilters currentFilterindex;

@end

@implementation MagnifierLiveVideoStreamViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // A scroll view is put behind the videoStreamImageView as it can automatically handle pinch to zoom.==
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 10.0;
    
    self.client = [[SonyCameraRemoteAPIClient alloc] init];
    
    //capture image push button parameters
    self.captureImagebutton = [[MDButton alloc] initWithFrame:self.buttonContainerView.bounds];
    self.captureImagebutton.backgroundColor = [UIColor colorWithRed:0 green:0.588 blue:0.533 alpha:1];
    self.captureImagebutton.mdButtonType = 2; // MDButtonTypeFloatingAction
    self.captureImagebutton.rippleColor = [UIColor whiteColor];
    [self.captureImagebutton addTarget:self action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    [self.captureImagebutton setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    [self.buttonContainerView addSubview:self.captureImagebutton];
    
    //full screen button between split screen and full screen button
    self.toggleSplitViewButton = [[MDButton alloc] initWithFrame:self.buttonContainerView.bounds];
    self.toggleSplitViewButton.backgroundColor = [UIColor colorWithRed:0.247 green:0.318 blue:0.71 alpha:1];
    self.toggleSplitViewButton.mdButtonType = 2; // MDButtonTypeFloatingAction
    self.toggleSplitViewButton.rippleColor = [UIColor whiteColor];
    [self.toggleSplitViewButton addTarget:self action:@selector(toggleSplitView) forControlEvents:UIControlEventTouchUpInside];
    [self.toggleSplitViewButton setImage:[UIImage imageNamed:@"expand"] forState:UIControlStateNormal];
    [self.toggleSplitViewButtonContainerView addSubview:self.toggleSplitViewButton];

    // Set up gesture recognizers on the imageView to handle swiping for filters and physical zoom
    UISwipeGestureRecognizer *gestureRecognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandler:)];
    [gestureRecognizerRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [gestureRecognizerRight setNumberOfTouchesRequired:1];
    self.videoStreamImageView.userInteractionEnabled = YES;
    [self.videoStreamImageView addGestureRecognizer:gestureRecognizerRight];
    
    UISwipeGestureRecognizer *gestureRecognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandler:)];
    [gestureRecognizerLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [gestureRecognizerLeft setNumberOfTouchesRequired:1];
    [self.videoStreamImageView addGestureRecognizer:gestureRecognizerLeft];
    
    UISwipeGestureRecognizer *gestureRecognizerUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(upSwipeHandler:)];
    [gestureRecognizerUp setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [gestureRecognizerUp setNumberOfTouchesRequired:1];
    [self.videoStreamImageView addGestureRecognizer:gestureRecognizerUp];
    
    UISwipeGestureRecognizer *gestureRecognizerDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(downSwipeHandler:)];
    [gestureRecognizerDown setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [gestureRecognizerDown setNumberOfTouchesRequired:1];
    [self.videoStreamImageView addGestureRecognizer:gestureRecognizerDown];
    
    if([[NSUserDefaults standardUserDefaults] integerForKey:LAST_FILTER_INDEX])
        self.currentFilterindex = [[NSUserDefaults standardUserDefaults] integerForKey:LAST_FILTER_INDEX];
    else
        self.currentFilterindex = MagnifierFilterNone;
    
    [self captureLiveVideo];
}

-(void)viewDidLayoutSubviews
{
    self.scrollView.contentSize = self.videoStreamImageView.frame.size;
}

#pragma mark - UiScrollViewDelegate Methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.videoStreamImageView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    NSLog(@"STARTED");
    self.flickeringCoverView.hidden = YES;
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    if(scale <= 1.0)
    {
        self.flickeringCoverView.hidden = NO;
    }
    else
    {
        self.flickeringCoverView.hidden = YES;
    }
}

#pragma mark - Filtering Methods

//This function is a handler for right swipe on the videoStreamImageView. The functions below follow the same principle
-(void)rightSwipeHandler:(UISwipeGestureRecognizer *)recognizer
{
    self.currentFilterindex--;
    
    if(self.currentFilterindex < 0)
        self.currentFilterindex = MagnifierFilterCount - 1;
    
    [[NSUserDefaults standardUserDefaults] setInteger:self.currentFilterindex forKey:LAST_FILTER_INDEX];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


-(void)leftSwipeHandler:(UISwipeGestureRecognizer *)recognizer
{
    self.currentFilterindex++;
    
    if(self.currentFilterindex == MagnifierFilterCount)
        self.currentFilterindex = 0;
    
    [[NSUserDefaults standardUserDefaults] setInteger:self.currentFilterindex forKey:LAST_FILTER_INDEX];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


-(void)upSwipeHandler:(UISwipeGestureRecognizer *)recognizer
{
    [self.client request:@"camera" method:@"actZoom" params:@[@"in", @"1shot"] completion:^(NSDictionary *result, NSError *error) {
    }];
}


-(void)downSwipeHandler:(UISwipeGestureRecognizer *)recognizer
{
    [self.client request:@"camera" method:@"actZoom" params:@[@"out", @"1shot"] completion:^(NSDictionary *result, NSError *error) {
    }];
}
/////

-(UIImage *)getFilteredImageForImage:(UIImage *)image
{
    return [[MagnifierImageFilters sharedInstance] getFilteredImageForFilterIndex:self.currentFilterindex andImage:image];
}

#pragma mark - Live Video Sony API Methods

// This method uses the SonyCameraRemoteAPI fetched via Cocoapods to get live video from the Sony Camera
-(void)captureLiveVideo
{
    [self.client discoverDevices:^(NSDictionary * result, NSError *error)
     {
         if([result objectForKey:@"liveviewstream"])
         {
             [self.client captureLiveview:[result objectForKey:@"liveviewstream"] captured:^(NSData *result, NSError *error)
              {
                  if(!error)
                  {
                      UIImage *image = [UIImage imageWithData:result];
                      [self setImageForLiveVideo:image];
                  }
                  else
                  {
                      NSLog(@"CAPTURELIVEVIEW ERROR: %@", error.localizedDescription);
                  }
              }];
         }
         else
         {
             NSLog(@"NO KEY VALUE FOR LIVEVIDEOSTREAM :(");
         }
     }];
 
}

-(void)setImageForLiveVideo:(UIImage *)image
{
    if(image)
        image = [self getFilteredImageForImage:image];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.videoStreamImageView setImage:image];
        
    });
}

#pragma mark - Button press handling

// This function will allow you to take a picture from the live feed and save it into the camera roll for later use
-(void)takePicture
{
    [self.delegate pictureClickRequested];
    [self.client request:@"camera" method:@"actTakePicture" params:@[] completion:^(NSDictionary *result, NSError *error) {
        
        NSArray *urls = [result objectForKey:@"result"];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[urls objectAtIndex:0]objectAtIndex:0]]]];
        
        if(image)
            image = [self getFilteredImageForImage:image];
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        [self.delegate pictureClicked:image];
    }];
}

//This method will send a message to the delegate to toggle split view 
-(void)toggleSplitView
{
    [self.delegate toggleSplitView];
}

@end
