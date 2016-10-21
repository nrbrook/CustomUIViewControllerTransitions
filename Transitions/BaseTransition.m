//
//  BaseTransition.m
//  CustomUIViewControllerTransitions
//
//  Created by Nick Brook on 20/09/2016.
//  Copyright © 2016 NickBrook. All rights reserved.
//

#import "BaseTransition.h"
#import <objc/runtime.h>

NSTimeInterval TransitionDefaultDuration = 0.35;

@implementation BaseTransition

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.duration = TransitionDefaultDuration;
    }
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    return self;
}

@end

static void *TransitionKey;

@implementation UIViewController(Transitions)

- (BaseTransition *)transition {
    return objc_getAssociatedObject(self, &TransitionKey);
}

- (void)setTransition:(BaseTransition *)transition {
    self.modalPresentationStyle = transition == nil ? UIModalPresentationNone : UIModalPresentationCustom;
    self.transitioningDelegate = transition;
    objc_setAssociatedObject(self, &TransitionKey, transition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

static void *StackTransitionKey;

@implementation UINavigationController(StackTransitions)

- (BaseTransition *)stackTransition {
    return objc_getAssociatedObject(self, &StackTransitionKey);
}

- (void)setStackTransition:(BaseTransition *)transition {
    self.delegate = transition;
    objc_setAssociatedObject(self, &StackTransitionKey, transition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
