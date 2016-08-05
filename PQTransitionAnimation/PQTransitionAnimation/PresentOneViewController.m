//
//  PresentOneViewController.m
//  PQTransitionAnimation
//
//  Created by ios on 16/8/5.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "PresentOneViewController.h"
#import "PQPresentTransitionAnimation.h"
#import "PresentTwoViewController.h"
#import "PQInteractiveTransitionAnimation.h"
@interface PresentOneViewController ()
@property (nonatomic,strong) PQInteractiveTransitionAnimation * interactive;

@property (nonatomic,strong) PQInteractiveTransitionAnimation *dismissInteractive;

@end

@implementation PresentOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"弹性present";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我或者向上滑动present" forState:UIControlStateNormal];
    [self.view addSubview:button];
    button.frame = CGRectMake(0, 0, 130, 30);
    button.center = self.view.center;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"dismiss" forState:UIControlStateNormal];
    [self.view addSubview:button1];
    button1.frame = CGRectMake(0, 0, 103, 30);
    button1.center = CGPointMake(self.view.center.x, self.view.center.y + 40);
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    _interactive = [PQInteractiveTransitionAnimation interactiveTransitionWithGestureDirectionType:PQInteractiveTransitionGestureDirectionLeft transitionType:PQInteractiveTransitionTypePresent];
    typeof (self) weakSelf = self;
    _interactive.presentConfigBlock = ^(){
        [weakSelf present];
    };
    [_interactive addViewControllerPanGesture:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)present{
    PresentTwoViewController * two = [[PresentTwoViewController alloc]init];
    [self presentViewController:two animated:YES completion:nil];
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _interactive.isGesture ? _interactive : nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
