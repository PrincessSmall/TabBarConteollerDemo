//
//  BaseNavigationController.m
//  TabBarControllerDemo
//
//  Created by LiMin on 2019/10/29.
//  Copyright © 2019 LiMin. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"BaseNavigationController viewDidLoad");
    
    self.interactivePopGestureRecognizer.delegate = self;
    
    // Do any additional setup after loading the view.
}

/**
 能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"pushViewController %@ %lu",viewController,(unsigned long)self.viewControllers.count);//在c控制器ViewDidload之前拦截
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

/**
 拦截左滑手势：一级页面的childViewControllers为1，所以以此作为判断
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"gestureRecognizerShouldBegin childViewControllerds = %@, viewControllers = %@",self.childViewControllers,self.viewControllers);
    if (self.childViewControllers.count == 1) {//这个childViewControllers和那个viewControllers什么区别(都是子控制器，是一样的)
        return NO;
    }else {
        return YES;
    }
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
