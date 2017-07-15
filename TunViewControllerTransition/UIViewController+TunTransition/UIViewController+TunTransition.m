//
//  UIViewController+TunTransition.m
//  TunViewControllerTransition
//
//  Created by 涂育旺 on 2017/7/15.
//  Copyright © 2017年 Qianhai Jiutong. All rights reserved.
//

#import "UIViewController+TunTransition.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, TunVCTransitionType)
{
    TunVCTransitionType_Transition,
    TunVCTransitionType_InverseTransition
};

@interface UIViewController ()

@property (nonatomic, copy) NSString *toViewKeyPath;

@property (nonatomic, strong) UIView *fromView;

@property (nonatomic, assign) TunVCTransitionType transitionType;

@end

@implementation UIViewController (TunTransition)

#pragma mark - init property

const NSString *typeKey = nil;
const NSString *fromViewKey = nil;
const NSString *toViewKey = nil;

// transitionType
- (void)setTransitionType:(TunVCTransitionType)transitionType
{
    objc_setAssociatedObject(self, &typeKey, @(transitionType), OBJC_ASSOCIATION_ASSIGN);
}

- (TunVCTransitionType)transitionType
{
    return [objc_getAssociatedObject(self, &typeKey) integerValue];
}

// fromView
- (void)setFromView:(UIView *)fromView
{
    objc_setAssociatedObject(self, &fromViewKey, fromView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)fromView
{
    return objc_getAssociatedObject(self, &fromViewKey);
}

// toView
- (void)setToViewKeyPath:(NSString *)toViewKeyPath
{
    objc_setAssociatedObject(self, &toViewKey, toViewKeyPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)toViewKeyPath
{
    return objc_getAssociatedObject(self, &toViewKey);
}

#pragma mark - public method

- (void)animateTransitionFromView:(UIView *)view toView:(NSString *)toViewKeyPath
{
    self.fromView = view;
    self.toViewKeyPath = toViewKeyPath;
    self.transitionType = TunVCTransitionType_Transition;
}

- (void)animateInverseTransition
{
    self.navigationController.delegate = self;
    self.transitionType = TunVCTransitionType_InverseTransition;
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.6f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (self.transitionType) {
            
        case TunVCTransitionType_Transition:
        {
            [self animateForTransition:transitionContext];
        }
            break;
        case TunVCTransitionType_InverseTransition:
        {
            [self animateForInverseTransition:transitionContext];
        }
            break;
            
        default:
            break;
    }
}

- (void)animateForTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *toView = [toVC valueForKeyPath:self.toViewKeyPath];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *snapShotView = [self.fromView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = [containerView convertRect:self.fromView.frame fromView:self.fromView.superview];
    self.fromView.hidden = YES;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toView.hidden = YES;
    
    toVC.fromView = self.fromView;
    toVC.toViewKeyPath = self.toViewKeyPath;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        [containerView layoutIfNeeded];
        toVC.view.alpha = 1.0f;
        snapShotView.frame = [containerView convertRect:toView.frame fromView:toView.superview];
        
    } completion:^(BOOL finished) {
        
        toView.hidden = NO;
        self.fromView.hidden = NO;
        [snapShotView removeFromSuperview];
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}

- (void)animateForInverseTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = [fromVC valueForKeyPath:self.toViewKeyPath];
    
    UIView *snapShotView = [fromView snapshotViewAfterScreenUpdates:NO];
    snapShotView.backgroundColor = [UIColor clearColor];
    snapShotView.frame = [containerView convertRect:fromView.frame fromView:fromView.superview];
    fromView.hidden = YES;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    
    UIView *originView = fromVC.fromView;
    originView.hidden = YES;
    
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    [containerView addSubview:snapShotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromVC.view.alpha = 0.0f;
        snapShotView.frame = [containerView convertRect:originView.frame fromView:originView.superview];
    } completion:^(BOOL finished) {
        [snapShotView removeFromSuperview];
        originView.hidden = NO;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
