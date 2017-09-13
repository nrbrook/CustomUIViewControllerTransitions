//
//  UIViewPropertyTransition.m
//  CustomUIViewControllerTransitions
//
//  Created by Nick Brook on 20/09/2016.
//  Copyright © 2016 NickBrook. All rights reserved.
//

#import "UIViewPropertyTransition.h"

@interface UIViewPropertyTransition()

@property(nonatomic, strong, nullable) NSMapTable<id<UIViewControllerContextTransitioning>, UIViewPropertyAnimator *> *animators;

@end

@implementation UIViewPropertyTransition

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.animators = [NSMapTable strongToStrongObjectsMapTable];
    }
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    BOOL unwinding = toVC.presentedViewController == fromVC;
    // workaround for bug where using viewForKey method returns nil
    UIView *from = fromVC.view;
    UIView *to = toVC.view;
    UIView *container = [transitionContext containerView];
    
    to.frame = from.frame;
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [toVC beginAppearanceTransition:YES animated:duration > 0];
    [fromVC beginAppearanceTransition:NO animated:duration > 0];
    
    if(!unwinding) {
        [container insertSubview:to aboveSubview:from];
    }
    
    [self setStartingPropertiesUnwinding:unwinding fromView:from toView:to];
    
    void(^animations)(void) = ^() {
        [self setAnimationPropertiesUnwinding:unwinding fromView:from toView:to];
    };
    
    void(^completion)(void) = ^() {
        BOOL cancelled = [transitionContext transitionWasCancelled];
        [self setCompletePropertiesUnwinding:unwinding fromView:from toView:to finished:!cancelled];
        [toVC endAppearanceTransition];
        [fromVC endAppearanceTransition];
        [transitionContext completeTransition:!cancelled];
    };
    
    if([UIViewPropertyAnimator class]) {
        // only available iOS 10
        UIViewPropertyAnimator *animator = [UIViewPropertyAnimator runningPropertyAnimatorWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:animations completion:^(UIViewAnimatingPosition finalPosition) {
            completion();
            [self.animators removeObjectForKey:transitionContext];
        }];
        
        [self.animators setObject:animator forKey:transitionContext];
    } else {
        [UIView animateWithDuration:duration animations:animations completion:^(BOOL finished) {
            completion();
        }];
    }
}

// Only available iOS 10
- (id<UIViewImplicitlyAnimating>)interruptibleAnimatorForTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewPropertyAnimator *animator = [self.animators objectForKey:transitionContext];
    if(animator == nil) {
        return [UIViewPropertyAnimator runningPropertyAnimatorWithDuration:0 delay:0 options:0 animations:^{
            
        } completion:nil];
    }
    return animator;
}

- (void)setStartingPropertiesUnwinding:(BOOL)unwinding fromView:(UIView *)fromView toView:(UIView *)toView {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (void)setAnimationPropertiesUnwinding:(BOOL)unwinding fromView:(UIView *)fromView toView:(UIView *)toView {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (void)setCompletePropertiesUnwinding:(BOOL)unwinding  fromView:(UIView *)fromView toView:(UIView *)toView finished:(BOOL)finished {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end
