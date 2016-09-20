//
//  FadePopTransition.h
//  CustomUIViewControllerTransitions
//
//  Created by Nick Brook on 20/09/2016.
//  Copyright © 2016 NickBrook. All rights reserved.
//

#import "FadeTransition.h"

extern CGFloat FadePopDefaultScale;

extern NSTimeInterval FadePopDefaultDuration;

@interface FadePopTransition : FadeTransition

@property(nonatomic, assign) CGFloat scale;

@end
