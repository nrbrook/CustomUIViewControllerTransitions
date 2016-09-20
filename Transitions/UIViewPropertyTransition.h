//
//  UIViewPropertyTransition.h
//  CustomUIViewControllerTransitions
//
//  Created by Nick Brook on 20/09/2016.
//  Copyright © 2016 NickBrook. All rights reserved.
//

#import "BaseTransition.h"

@protocol UIViewPropertyTransitionSubclass <NSObject>

@required

/**
 Method in which subclasses should set up the start state of the animation

 @param unwinding If YES, the animation is unwinding back to the presenting view controller
 @param fromView  The source view
 @param toView    The destination view
 */
- (void)setStartingPropertiesUnwinding:(BOOL)unwinding fromView:(UIView *)fromView toView:(UIView *)toView;


/**
 Method in which subclasses should set the animations to be performed

 @param unwinding If YES, the animation is unwinding back to the presenting view controller
 @param fromView  The source view
 @param toView    The destination view
 */
- (void)setAnimationPropertiesUnwinding:(BOOL)unwinding fromView:(UIView *)fromView toView:(UIView *)toView;


/**
 Method in which subclasses should set the end state of the views

 @param unwinding If YES, the animation is unwinding back to the presenting view controller
 @param fromView  The source view
 @param toView    The destination view
 @param finished  If YES, the animation finished before this method was called
 */
- (void)setCompletePropertiesUnwinding:(BOOL)unwinding fromView:(UIView *)fromView toView:(UIView *)toView finished:(BOOL)finished;

@end

@interface UIViewPropertyTransition : BaseTransition <UIViewPropertyTransitionSubclass>

@end
