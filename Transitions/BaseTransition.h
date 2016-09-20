//
//  BaseTransition.h
//  CustomUIViewControllerTransitions
//
//  Created by Nick Brook on 20/09/2016.
//  Copyright © 2016 NickBrook. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSTimeInterval TransitionDefaultDuration;

@interface BaseTransition : NSObject <UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@property(nonatomic, assign) NSTimeInterval duration;


/**
 Sets the view controller's transitionDelegate to this object to return itself in the delegate methods -animationControllerForPresentedController:presentingController:sourceController: and -animationControllerForDismissedController:

 @param viewController The view controller to set this transition on
 */
- (void)setAsTransitionForViewController:(UIViewController *)viewController;


/**
 Sets the navigation controller's delegate to this object to return itself in the delegate method -navigationController:animationControllerForOperation:fromViewController:toViewController:

 @param navigationController The navigation controller to set this transition on
 */
- (void)setAsTransitionForNavigationController:(UINavigationController *)navigationController;

@end
