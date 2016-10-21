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

@end

@interface UIViewController(Transitions)

@property(nonatomic, strong, nullable) BaseTransition *transition;

@end

@interface UINavigationController(StackTransitions)

@property(nonatomic, strong, nullable) BaseTransition *stackTransition;

@end
