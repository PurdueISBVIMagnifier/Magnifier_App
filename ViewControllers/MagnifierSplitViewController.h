//
//  MagnifierSplitViewController.h
//  ISBVI Magnifier
//
//  Created by Manik Kalra on 2/4/16.
//  Copyright © 2016 Manik Kalra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MaterialControls/MDButton.h>

@interface MagnifierSplitViewController : UIViewController

@property (nonatomic, copy) void (^loadCompletionBlock)(void);

-(void)setPrimaryViewController:(UIViewController *)viewController;
-(void)setSecondaryViewController:(UIViewController *)viewController;
-(void)hideSecondaryView;
-(void)showSecondaryView;
-(void)toggleSplitView;

@end
