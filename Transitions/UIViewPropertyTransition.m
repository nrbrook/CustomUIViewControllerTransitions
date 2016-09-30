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
    UIView *to = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *container = [transitionContext containerView];
    
    to.frame = from.frame;
    
    if(unwinding) {
        [container insertSubview:to belowSubview:from];
    } else {
        [container insertSubview:to aboveSubview:from];
    }
    
    [self setStartingPropertiesUnwinding:unwinding fromView:from toView:to];
    
    void(^animations)() = ^() {
        [self setAnimationPropertiesUnwinding:unwinding fromView:from toView:to];
    };
    
    void(^completion)() = ^() {
        BOOL cancelled = [transitionContext transitionWasCancelled];
        [self setCompletePropertiesUnwinding:unwinding fromView:from toView:to finished:!cancelled];
        [transitionContext completeTransition:!cancelled];
    };
    
    if([UIViewPropertyAnimator class]) {
        // only available iOS 10
        UIViewPropertyAnimator *animator = [UIViewPropertyAnimator runningPropertyAnimatorWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:animations completion:^(UIViewAnimatingPosition finalPosition) {
            completion();
            [self.animators removeObjectForKey:transitionContext];
        }];
        
        [self.animators setObject:animator forKey:transitionContext];
    } else {
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:animations completion:^(BOOL finished) {
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
