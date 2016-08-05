//
//  PQTransitionAnimation.m
//  PQTransitionAnimation
//
//  Created by ios on 16/8/5.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "PQPresentTransitionAnimation.h"

@implementation PQPresentTransitionAnimation{
    PQPresentTransitionAnimationType _transitiontype;
    PQTransitionAnimation _animationType;
    NSTimeInterval _duration;
    CGRect _animationFrame;
}
//动画时长
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    NSLog(@"duration");
    return _duration;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    NSLog(@"判断执行动画");
    
    //动画类型 分别处理
    switch (_transitiontype) {
        case PQPresentTransitionAnimationTypePresent:
            [self present:transitionContext];
            break;
        case PQPresentTransitionAnimationTypeDismiss:
            [self dismiss:transitionContext];
            break;
            
        default:
            break;
    }
}

- (void)present:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    NSLog(@"present");
    
    //获得当前VC和即将要跳转的VC
    /*
     //   UITransitionContextToViewControllerKey
     //   UITransitionContextFromViewControllerKey
     */
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //snapshotViewAfterScreenUpdates可以对某个视图截图，我们采用对这个截图做动画代替直接对vc1做动画，因为在手势过渡中直接使用vc1动画会和手势有冲突，如果不需要实现手势的话，就可以不是用截图视图了，大家可以自行尝试一下
    UIView * tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    //接下来要显示的应该是截图，所以view需要隐藏
    fromVC.view.hidden = YES;
    //如果需要做转场动画必须要加入containerView中
    UIView * container = [transitionContext containerView];
    //把截屏的View和要显示的View都加入到container中
    [container addSubview:tempView];
    [container addSubview:toVC.view];
    //下面可以设置toVC的大小和位置
    _animationFrame = [self animationFrame:container];
    toVC.view.frame = _animationFrame;
    
    /*
     UIViewAnimationOptionLayoutSubviews 提交动画是布局子控件，表示将子控件和父控件一同动画
     UIViewAnimationOptionAllowUserInteraction 动画时允许用户交互
     UIViewAnimationOptionBeginFromCurrentState 从当前状态开始动画
     UIViewAnimationOptionRepeat 动画无限重复
     UIViewAnimationOptionAutoreverse 执行动画回路，前提要设置动画无限重复
     UIViewAnimationOptionOverrideInheritedDuratio 忽略外层动画嵌套的执行时间
     UIViewAnimationOptionOverrideInheritedCurve 忽略外层动画嵌套的时间和变化曲线
     UIViewAnimationOptionAllowAnimatedContent 通过改变属性和重绘实现动画效果，如果key没提交动画将使用快照
     UIViewAnimationOptionShowHideTransitionViews 用显隐的方式替代添加移除图层的动画效果
     UIViewAnimationOptionOverrideInheritedOptions 忽略嵌套继承的选项
     //贝塞尔曲线
     UIViewAnimationOptionCurveEaseInOut 慢到快
     UIViewAnimationOptionCurveEaseIn 慢到特别快
     UIViewAnimationOptionCurveEaseOut 快到慢
     UIViewAnimationOptionCurveLinear 匀速
     //转场动画
     UIViewAnimationOptionTransitionNone 无转场动画
     UIViewAnimationOptionTransitionFlipFromLeft 从左翻转
     UIViewAnimationOptionTransitionFlipFromRight 从右翻转
     UIViewAnimationOptionTransitionCurlUp 上卷翻转
     UIViewAnimationOptionTransitionCurlDown 下卷翻转
     UIViewAnimationOptionTransitionCrossDissolve 转场交叉消失
     UIViewAnimationOptionTransitionFlipFromTop   转场从上翻转
     UIViewAnimationOptionTransitionFlipFromBottom 转场从下翻转
     */
    //使用动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext]animations:^{
        if (_animationType == TransitionAnimationFromHalfBottom) {
            //首先我们让vc2向上移动
            //首先我们让vc2向上移动
            toVC.view.transform = CGAffineTransformMakeTranslation(0, -(_animationFrame.size.height));
        }else
            toVC.view.frame = container.bounds;
        //这里写显示效果
        tempView.transform = CGAffineTransformMakeScale(0.85, 0.85);
        
        
    } completion:^(BOOL finished) {
        //这里处理如果没有转场成功
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            //如果转场取消了 显示当前页面 并且把截图移除掉
            fromVC.view.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
}

- (CGRect)animationFrame:(UIView * )container{
    CGRect frame = container.bounds;
    frame.size.width *= 0.85;
    frame.size.height *= 0.85;
    switch (_animationType) {
        case TransitionAnimationFromTop:
            frame.origin.y = - frame.size.height;
            break;
        case TransitionAnimationFromBottom:
            frame.origin.y =  frame.size.height;
            break;
        case TransitionAnimationFromLeft:
            frame.origin.x = - frame.size.width;
            break;
        case TransitionAnimationFromRight:
            frame.origin.x =  frame.size.width;
            break;
        case TransitionAnimationFromCenter:
            frame = CGRectMake(container.center.x, container.center.y, 0, 0);
            break;
        case TransitionAnimationFromHalfBottom:
            frame.size.height = container.frame.size.height;
            frame.size.width = container.frame.size.width;
            frame.origin.y = frame.size.height;
            frame.size.height /= 2.0;
//            CGRectMake(0, containerView.height, containerView.width, 400);
            break;
            
        default:
            break;
    }
    NSLog(@"计算frame");
    return frame;
}


- (void)dismiss:(id <UIViewControllerContextTransitioning>)transitionContext{
    //这里需要注意位置互换 fromvc 和 tovc
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //和present同理
    UIView * containerView = [transitionContext containerView];
    NSArray * subviewsArray = containerView.subviews;
    UIView * tempView = subviewsArray[MIN(subviewsArray.count, MAX(0, subviewsArray.count - 2))];
    _animationFrame = [self animationFrame:containerView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        //因为present的时候都是使用的transform，这里的动画只需要将transform恢复就可以了
        fromVC.view.frame = _animationFrame;
        tempView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        //被取消了 也就是失败了
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
}

/**
 *  传入动画的类型
 *
 *  @param type
 *
 *  @return
 */
+ (instancetype)presentTransitionAnimationWithDuration:(NSTimeInterval)duration  Type:(PQPresentTransitionAnimationType)type TransitionAnimationType:(PQTransitionAnimation)animationType;{
    return [[self alloc]initWithDuration:duration PresentTransitionAnimationType:type TransitionAnimationType:animationType];
}
/**
 *  传入动画的类型
 *
 *  @param type
 *
 *  @return
 */
- (instancetype)initWithDuration:(NSTimeInterval)duration  PresentTransitionAnimationType:(PQPresentTransitionAnimationType)type TransitionAnimationType:(PQTransitionAnimation)animationType;
{
    self = [super init];
    if (self) {
        _transitiontype = type;
        _animationType = animationType;
        //这里做处理，不让时长为 0
        if (duration <= 0) {
            _duration = 0.5f;
        }else
            _duration = duration;
    }
    return self;
}
@end
