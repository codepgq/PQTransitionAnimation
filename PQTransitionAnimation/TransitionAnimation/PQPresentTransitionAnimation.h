//
//  PQTransitionAnimation.h
//  PQTransitionAnimation
//
//  Created by ios on 16/8/5.
//  Copyright © 2016年 ios. All rights reserved.
//

/*
 <1.>UIViewControllerAnimatedTransitioning   动画协议
 
 <2>.UIViewControllerInteractiveTransitioning  交互协议
 
 <3>.UIViewControllerContextTransitioning      上下文协议
 
 <4>.UIPercentDrivenInteractiveTransition         遵守<2>协议的一个官方类
 
 之所以官方给出的API是协议而不是类别，给出的说法是为了灵活性，你可以在ViewController里面直接写，也可以直接另写一个类封装起来。
 
 文／BradleyJohnson（简书作者）
 原文链接：http://www.jianshu.com/p/59224648828b
 著作权归作者所有，转载请联系作者获得授权，并标注“简书作者”。
 
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PQTransitionAnimation) {
    TransitionAnimationFromTop = 0,
    TransitionAnimationFromBottom,
    TransitionAnimationFromLeft,
    TransitionAnimationFromRight,
    TransitionAnimationFromCenter,
    TransitionAnimationFromHalfBottom,
};

typedef NS_ENUM(NSInteger,PQPresentTransitionAnimationType) {
    PQPresentTransitionAnimationTypePresent = 0,
    PQPresentTransitionAnimationTypeDismiss,
};

//继承动画协议
@interface PQPresentTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>

/**
 *  传入动画的类型
 *
 *  @param type
 *
 *  @return
 */
+ (instancetype)presentTransitionAnimationWithDuration:(NSTimeInterval)duration  Type:(PQPresentTransitionAnimationType)type TransitionAnimationType:(PQTransitionAnimation)animationType;
/**
 *  传入动画的类型
 *
 *  @param type
 *
 *  @return
 */
- (instancetype)initWithDuration:(NSTimeInterval)duration  PresentTransitionAnimationType:(PQPresentTransitionAnimationType)type TransitionAnimationType:(PQTransitionAnimation)animationType;

@end
