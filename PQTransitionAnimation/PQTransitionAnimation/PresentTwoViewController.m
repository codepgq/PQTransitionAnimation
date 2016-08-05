//
//  PresentTwoViewController.m
//  PQTransitionAnimation
//
//  Created by ios on 16/8/5.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "PresentTwoViewController.h"
#import "PQPresentTransitionAnimation.h"
#import "PQInteractiveTransitionAnimation.h"
@interface PresentTwoViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic,strong)PQInteractiveTransitionAnimation * interactiveDismiss;
@end

@implementation PresentTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.view.backgroundColor = [UIColor orangeColor];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"dismiss" forState:UIControlStateNormal];
    [self.view addSubview:button1];
    button1.frame = CGRectMake(0, 0, 100, 30);
    button1.center = CGPointMake(self.view.center.x, self.view.center.y - 40);
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    self.interactiveDismiss = [PQInteractiveTransitionAnimation interactiveTransitionWithGestureDirectionType:PQInteractiveTransitionGestureDirectionRight transitionType:PQInteractiveTransitionTypeDismiss];
    [self.interactiveDismiss addViewControllerPanGesture:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [PQPresentTransitionAnimation presentTransitionAnimationWithDuration:0.4f Type:PQPresentTransitionAnimationTypePresent TransitionAnimationType:TransitionAnimationFromLeft];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [PQPresentTransitionAnimation presentTransitionAnimationWithDuration:0.5f Type:PQPresentTransitionAnimationTypeDismiss TransitionAnimationType:TransitionAnimationFromLeft];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _interactiveDismiss.isGesture ? _interactiveDismiss : nil;
}

@end
