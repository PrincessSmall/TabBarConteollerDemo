//
//  BaseTabbarViewController.m
//  TabBarControllerDemo
//
//  Created by LiMin on 2019/10/28.
//  Copyright © 2019 LiMin. All rights reserved.
//

#import "BaseTabbarViewController.h"

#import "BaseNavigationController.h"
#import "BViewController.h"
#import "AViewController.h"
#import "CViewController.h"

@interface BaseTabbarViewController ()

@end

@implementation BaseTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildVC];
    // Do any additional setup after loading the view.
}

- (void)setupChildVC {
    
    AViewController *avc = [[AViewController alloc]init];
    [self setupTabbarItem:avc.tabBarItem title:@"首页" titleSize:12 titleFontName:@"HeiTi SC" normalTitleColor:[UIColor grayColor] selectedTitleColor:[UIColor purpleColor] normalImage:@"tabbar_about_normal" selectedImage:@"tabbar_about_select"];
    
    BViewController *bvc = [[BViewController alloc]init];
    [self setupTabbarItem:bvc.tabBarItem title:@"订单" titleSize:12 titleFontName:@"HeiTi SC" normalTitleColor:[UIColor grayColor] selectedTitleColor:[UIColor purpleColor] normalImage:@"tabbar_order_normal" selectedImage:@"tabbar_order_select"];
    
    CViewController *cvc = [[CViewController alloc]init];
    [self setupTabbarItem:cvc.tabBarItem title:@"我的" titleSize:12 titleFontName:@"HeiTi SC" normalTitleColor:[UIColor grayColor] selectedTitleColor:[UIColor purpleColor] normalImage:@"tabbar_order_normal" selectedImage:@"tabbar_order_select"];
    
    BaseNavigationController *navA = [[BaseNavigationController alloc]initWithRootViewController:avc];
    BaseNavigationController *navB = [[BaseNavigationController alloc]initWithRootViewController:bvc];
    BaseNavigationController *navC = [[BaseNavigationController alloc]initWithRootViewController:cvc];
    
    self.viewControllers = @[navA,navB,navC];
}

- (void)setupTabbarItem:(UITabBarItem *)tabbarItem title:(NSString *)title titleSize:(CGFloat)size titleFontName:(NSString *)fontName normalTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage {
    
    tabbarItem = [tabbarItem initWithTitle:title image:[[UIImage imageNamed:normalImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];//为了防止系统着色，使用UIImageRenderingModeAlwaysOriginal提供图像
    
    NSDictionary *attribuDic = @{
                                 NSForegroundColorAttributeName:normalTitleColor,
                                 NSFontAttributeName:[UIFont fontWithName:fontName size:size],
                                 };
    [[UITabBarItem appearance]setTitleTextAttributes:attribuDic forState:UIControlStateNormal];//TODO appearance方法的使用不懂
    
    NSDictionary *attributSelDic = @{
                                     NSForegroundColorAttributeName:selectedTitleColor,
                                     NSFontAttributeName:[UIFont fontWithName:fontName size:size],
                                     };
    [[UITabBarItem appearance] setTitleTextAttributes:attributSelDic forState:UIControlStateSelected];
    
//    tabbarItem.badgeValue = @"10";
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
