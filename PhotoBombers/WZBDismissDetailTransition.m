//
//  WZBDismissDetailTransition.m
//  PhotoBombers
//
//  Created by wuzhengbin on 14-4-2.
//  Copyright (c) 2014年 wzb. All rights reserved.
//

#import "WZBDismissDetailTransition.h"

@implementation WZBDismissDetailTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *detail = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [UIView animateWithDuration:0.3 animations:^{
        detail.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [detail.view removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

@end
