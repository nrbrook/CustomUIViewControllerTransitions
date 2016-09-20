//
//  FadeTransition.m
//  CustomUIViewControllerTransitions
//
//  Created by Nick Brook on 20/09/2016.
//  Copyright © 2016 NickBrook. All rights reserved.
//

#import "FadeTransition.h"

@implementation FadeTransition

- (void)setStartingPropertiesUnwinding:(BOOL)unwinding fromView:(UIView *)fromView toView:(UIView *)toView {
    if(unwinding) {
        fromView.alpha = 1;
    } else {
        toView.alpha = 0;
    }
}

- (void)setAnimationPropertiesUnwinding:(BOOL)unwinding fromView:(UIView *)fromView toView:(UIView *)toView {
    if(unwinding) {
        fromView.alpha = 0;
    } else {
        toView.alpha = 1;
    }
}

- (void)setCompletePropertiesUnwinding:(BOOL)unwinding fromView:(UIView *)fromView toView:(UIView *)toView finished:(BOOL)finished {
    
}

@end
