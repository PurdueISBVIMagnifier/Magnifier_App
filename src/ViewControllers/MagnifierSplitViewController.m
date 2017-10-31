//
//  MagnifierSplitViewController.m
//  ISBVI Magnifier
//
//  Created by Manik Kalra on 2/4/16.
//  Copyright © 2016 Manik Kalra. All rights reserved.
//

#import "MagnifierSplitViewController.h"

#define ANIMATION_DURATION 0.8

@interface MagnifierSplitViewController ()

//The split view controller is divided into 2 parts. The primary view and secondary view. The view of the MagnifierLiveVideoStreamViewController is put on primary view, and the view of the MagnifierPhotoPickerViewController is put on the secondary view.
@property (weak, nonatomic) IBOutlet UIView *primaryView;
@property (weak, nonatomic) IBOutlet UIView *secondaryView;

// Constraints
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *primaryViewWidthConstraint;

@property (nonatomic) BOOL secondaryViewHidden;

@end

@implementation MagnifierSplitViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.loadCompletionBlock();
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if(UIInterfaceOrientationIsPortrait(orientation))
    {
        [self setupViewsForPortraitModeWithSize:self.view.frame.size];
    }
    else
    {
        [self setupViewsForLandscapeModeWithSize:self.view.frame.size];
    }
}

//Methods to set the primary and secondary view given a generic viewcontroller
-(void)setPrimaryViewController:(UIViewController *)viewController
{
    viewController.view.frame = self.primaryView.bounds;
    [self.primaryView addSubview:viewController.view];
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

-(void)setSecondaryViewController:(UIViewController *)viewController
{
    viewController.view.frame = self.secondaryView.bounds;
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.secondaryView addSubview:viewController.view];
}
////

-(void)hideSecondaryView
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if(UIInterfaceOrientationIsPortrait(orientation))
    {
        [self.primaryView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    else
    {
        self.primaryViewWidthConstraint.constant = self.view.frame.size.width/2;
    }
    
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {

        self.secondaryView.hidden = YES;
    }];
    
    self.secondaryViewHidden = YES;
}

-(void)showSecondaryView
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if(UIInterfaceOrientationIsPortrait(orientation))
    {
        [self.primaryView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2)];
    }
    else
    {
        self.primaryViewWidthConstraint.constant = 0;
    }
    
    
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        
        // Make all constraint changes here
        [self.view layoutIfNeeded];
        self.secondaryView.hidden = NO;
        
    } completion:^(BOOL finished) {
        
    }];
    
    self.secondaryViewHidden = NO;
}

-(void)toggleSplitView
{
    if(self.secondaryViewHidden)
        [self showSecondaryView];
    else
        [self hideSecondaryView];
}

#pragma mark - Handle Orientation Changes

// This method will be called whenever the orientation of the iPad changes. It uses auto-layout to set the view when in landscape mode. It disables auto-layout and sets the view manually in portrait mode.  
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
        [self showSecondaryView];
        
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        
        if(UIInterfaceOrientationIsPortrait(orientation))
        {
            [self setupViewsForPortraitModeWithSize:size];
        }
        else
        {
            [self setupViewsForLandscapeModeWithSize:size];
        }

        [self.view layoutIfNeeded];
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

-(void)setupViewsForPortraitModeWithSize:(CGSize)size
{
    [NSLayoutConstraint deactivateConstraints:self.primaryView.constraints];
    [NSLayoutConstraint deactivateConstraints:self.secondaryView.constraints];
    
    [self.primaryView setFrame:CGRectMake(0, 0, size.width, size.height/2)];
    [self.secondaryView setFrame:CGRectMake(0, size.height/2, size.width, size.height/2)];
}

-(void)setupViewsForLandscapeModeWithSize:(CGSize)size
{
    [NSLayoutConstraint activateConstraints:self.primaryView.constraints];
    [NSLayoutConstraint activateConstraints:self.secondaryView.constraints];
}


@end
