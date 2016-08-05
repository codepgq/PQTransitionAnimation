//
//  PQInteractiveTransitionAnimation.h
//  PQTransitionAnimation
//
//  Created by ios on 16/8/5.
//  Copyright © 2016年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PQGestureConfigBlock)();

typedef NS_ENUM(NSUInteger, PQInteractiveTransitionGestureDirection) {//手势的方向
    PQInteractiveTransitionGestureDirectionLeft = 0,
    PQInteractiveTransitionGestureDirectionRight,
    PQInteractiveTransitionGestureDirectionUp,
    PQInteractiveTransitionGestureDirectionDown
};

typedef NS_ENUM(NSUInteger, PQInteractiveTransitionType) {//手势控制哪种转场
    PQInteractiveTransitionTypePresent = 0,
    PQInteractiveTransitionTypeDismiss,
    PQInteractiveTransitionTypePush,
    PQInteractiveTransitionTypePop,
};

@interface PQInteractiveTransitionAnimation : UIPercentDrivenInteractiveTransition
/**
 *  动画是不是运行状态
 */
@property (assign,nonatomic,readonly) BOOL isEnable;
/**
 *  判断是不是手势
 */
@property (nonatomic,assign) BOOL isGesture;
/**
 *  block中初始化p控制器并push
 */
@property (nonatomic,copy) PQGestureConfigBlock pushConfigBlock;
/**
 *  block中初始化p控制器并present
 */
@property (nonatomic,copy) PQGestureConfigBlock presentConfigBlock;

+ (instancetype)interactiveTransitionWithGestureDirectionType:(PQInteractiveTransitionGestureDirection)directionType transitionType:(PQInteractiveTransitionType)transitionType;
- (instancetype)initWithInteractiveTransitionGestureDirectionType:(PQInteractiveTransitionGestureDirection)directionType transitionType:(PQInteractiveTransitionType)transitionType;
- (void)addViewControllerPanGesture:(UIViewController *)viewcontroller;
@end
