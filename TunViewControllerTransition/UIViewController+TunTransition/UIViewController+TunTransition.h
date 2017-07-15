//
//  UIViewController+TunTransition.h
//  TunViewControllerTransition
//
//  Created by 涂育旺 on 2017/7/15.
//  Copyright © 2017年 Qianhai Jiutong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TunTransition)<UIViewControllerAnimatedTransitioning,UINavigationControllerDelegate>
/**
 *  @brief 设置正向转场动画
 *  @param view 发生转场的原视图
 *  @param toViewKeyPath 转场后的目标视图的keyPath（为toVC的属性）
 */
- (void)animateTransitionFromView:(UIView *)view toView:(NSString *)toViewKeyPath;

/// 逆向转场动画
- (void)animateInverseTransition;

@end
