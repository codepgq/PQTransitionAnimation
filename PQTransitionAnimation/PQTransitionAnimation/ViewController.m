//
//  ViewController.m
//  PQTransitionAnimation
//
//  Created by ios on 16/8/5.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation ViewController{
    NSArray * _array;
    NSArray * _classArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _array = @[@"push",@"prsent",@"other",@"没想好",@"不知道"];
    _classArray = @[@"PushOneViewController",@"PresentOneViewController",@" ",@" ",@" "];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _array[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Class cls = NSClassFromString(_classArray[indexPath.row]);
    if (cls) {
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[[cls alloc] init] animated:YES];
        }
        if (indexPath.row == 1) {
            [self presentViewController:[[cls alloc] init] animated:YES completion:nil];
        }
    }
}

@end
