//
//  FadePopTransition.m
//  CustomUIViewControllerTransitions
//
//  Created by Nick Brook on 20/09/2016.
//  Copyright © 2016 NickBrook. All rights reserved.
//

#import "FadePopTransition.h"

CGFloat FadePopDefaultScale = 0.85;

NSTimeInterval FadePopDefaultDuration = 0.2;

@implementation FadePopTransition

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scale = FadePopDefaultScale;
        self.duration = FadePopDefaultDuration;
    }
    return self;
}

- (void)setStartingPropertiesUnwinding:(BOOL)unwinding fromView:(UIView *)fromView toView:(UIView *)toView {
    [super setStartingPropertiesUnwinding:unwinding fromView:fromView toView:toView];
    if(unwinding) {
        fromView.transform = CGAffineTransformIdentity;
    } else {
        toView.transform = CGAffineTransformMakeScale(self.scale, self.scale);
    }
}

- (void)setAnimationPropertiesUnwinding:(BOOL)unwinding fromView:(UIView *)fromView toView:(UIView *)toView {
    [super setAnimationPropertiesUnwinding:unwinding fromView:fromView toView:toView];
    if(unwinding) {
        fromView.transform = CGAffineTransformMakeScale(self.scale, self.scale);
    } else {
        toView.transform = CGAffineTransformIdentity;
    }
}

- (void)setCompletePropertiesUnwinding:(BOOL)unwinding fromView:(UIView *)fromView toView:(UIView *)toView finished:(BOOL)finished {
    
}

@end
