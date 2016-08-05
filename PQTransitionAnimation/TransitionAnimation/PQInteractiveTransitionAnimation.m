//
//  PQInteractiveTransitionAnimation.m
//  PQTransitionAnimation
//
//  Created by ios on 16/8/5.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "PQInteractiveTransitionAnimation.h"

@implementation PQInteractiveTransitionAnimation
{
    PQInteractiveTransitionGestureDirection _directionType;
    PQInteractiveTransitionType _transitionType;
    UIViewController * _myViewcontroller;
}

+ (instancetype)interactiveTransitionWithGestureDirectionType:(PQInteractiveTransitionGestureDirection)directionType transitionType:(PQInteractiveTransitionType)transitionType{
    return [[self alloc]initWithInteractiveTransitionGestureDirectionType:directionType transitionType:transitionType];
}
- (instancetype)initWithInteractiveTransitionGestureDirectionType:(PQInteractiveTransitionGestureDirection)directionType transitionType:(PQInteractiveTransitionType)transitionType{
    self = [super init];
    if (self) {
        _directionType = directionType;
        _transitionType = transitionType;
    }
    return self;
}

- (void)addViewControllerPanGesture:(UIViewController *)viewcontroller{
    [self setUpGesture:viewcontroller];
}

- (void)setUpGesture:(UIViewController *)viewcontroller{
    if (viewcontroller) {
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pq_handleGesture:)];
        _myViewcontroller = viewcontroller;
        [_myViewcontroller.view addGestureRecognizer:pan];
    }
    
}

- (void)pq_handleGesture:(UIPanGestureRecognizer *)panGesture{
    CGFloat percent = 0;
    switch (_directionType) {
        case PQInteractiveTransitionGestureDirectionUp:
        {
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            percent = transitionY / panGesture.view.frame.size.width;
        }
            break;
        case PQInteractiveTransitionGestureDirectionDown:
        {
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            percent = transitionY / (panGesture.view.frame.size.height);
        }
            break;
        case PQInteractiveTransitionGestureDirectionLeft:
        {
            CGFloat transitionX =  [panGesture translationInView:panGesture.view].x;
            percent = transitionX / (panGesture.view.frame.size.width);
        }
            break;
        case PQInteractiveTransitionGestureDirectionRight:
        {
            CGFloat transitionX =  -[panGesture translationInView:panGesture.view].x;
            percent = transitionX / (panGesture.view.frame.size.width);
        }
            break;
            
        default:
            break;
    }
    
    NSLog(@"%f",percent);
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            self.isGesture = YES;
            [self startGesture];
            break;
        case UIGestureRecognizerStateChanged:
            [self updateInteractiveTransition:percent];
            break;
        case UIGestureRecognizerStateEnded:
            self.isGesture = NO;
            if (percent > 0.4) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            break;
            
        default:
            break;
    }
}

- (void)startGesture{
    switch (_transitionType) {
        case PQInteractiveTransitionTypePresent:
            if (_presentConfigBlock) {
                NSLog(@"block ");
                _presentConfigBlock();
            }
            break;
        case PQInteractiveTransitionTypeDismiss:
            [_myViewcontroller dismissViewControllerAnimated:YES completion:nil];
            break;
        case PQInteractiveTransitionTypePush:
            if (_pushConfigBlock) {
                _pushConfigBlock();
            }
            break;
        case PQInteractiveTransitionTypePop:
            [_myViewcontroller.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            break;
    }
}

@end
