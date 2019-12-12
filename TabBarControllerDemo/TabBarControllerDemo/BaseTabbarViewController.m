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

#import "UITabBarItem+SubViews.h"


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface BaseTabbarViewController ()

@property (nonatomic, strong) UIButton *firstCoverButton;//第一个的选中button
@property (nonatomic,assign) NSInteger  indexFlag;//记录上一次点击tabbar，使用时，记得先在init或viewDidLoad里 初始化 = 0

@end

@implementation BaseTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.barTintColor = [UIColor whiteColor];//设置tabbar背景颜色
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -0.5, SCREEN_WIDTH, 1)];
//    view.backgroundColor = [UIColor colorWithRed:242 green:242 blue:243 alpha:1];
//    [[UITabBar appearance] insertSubview:view atIndex:0];
    
    [self setupChildVC];
    self.indexFlag = 0;
    [self upAnimationWithIndex:self.indexFlag];
//    [self setUpFirstCoverButtonShow:YES];
    ;
    
    // Do any additional setup after loading the view.
}

- (void)setupChildVC {
    
    AViewController *avc = [[AViewController alloc]init];
    [self setupTabbarItem:avc.tabBarItem title:@"首页" titleSize:12 titleFontName:@"HeiTi SC" normalTitleColor:[UIColor grayColor] selectedTitleColor:[UIColor purpleColor] normalImage:@"tabbar_about_normal" selectedImage:@"tabar_select2"];
    
    BViewController *bvc = [[BViewController alloc]init];
    [self setupTabbarItem:bvc.tabBarItem title:@"订单" titleSize:12 titleFontName:@"HeiTi SC" normalTitleColor:[UIColor grayColor] selectedTitleColor:[UIColor purpleColor] normalImage:@"tabbar_order_normal" selectedImage:@"tabar_select2"];
    
    CViewController *cvc = [[CViewController alloc]init];
    [self setupTabbarItem:cvc.tabBarItem title:@"我的" titleSize:12 titleFontName:@"HeiTi SC" normalTitleColor:[UIColor grayColor] selectedTitleColor:[UIColor purpleColor] normalImage:@"tabbar_user_normal" selectedImage:@"tabar_select2"];
    
    BaseNavigationController *navA = [[BaseNavigationController alloc]initWithRootViewController:avc];
    BaseNavigationController *navB = [[BaseNavigationController alloc]initWithRootViewController:bvc];
    BaseNavigationController *navC = [[BaseNavigationController alloc]initWithRootViewController:cvc];
    
    self.viewControllers = @[navA,navB,navC];
}

- (void)setupTabbarItem:(UITabBarItem *)tabbarItem title:(NSString *)title titleSize:(CGFloat)size titleFontName:(NSString *)fontName normalTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage {
    
    [tabbarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];//将tabbar的title上移，y为负时上移，y为正下移
    tabbarItem = [tabbarItem initWithTitle:title image:[[UIImage imageNamed:normalImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];//为了防止系统着色，使用UIImageRenderingModeAlwaysOriginal提供图像
    
    NSDictionary *attribuDic = @{
                                 NSForegroundColorAttributeName:normalTitleColor,
                                 NSFontAttributeName:[UIFont fontWithName:fontName size:size],
                                 };
    [[UITabBarItem appearance]setTitleTextAttributes:attribuDic forState:UIControlStateNormal];
    
    NSDictionary *attributSelDic = @{
                                     NSForegroundColorAttributeName:selectedTitleColor,
                                     NSFontAttributeName:[UIFont fontWithName:fontName size:size],
                                     };
    [[UITabBarItem appearance] setTitleTextAttributes:attributSelDic forState:UIControlStateSelected];
    
//    tabbarItem.badgeValue = @"10";
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    NSInteger index = [tabBar.items indexOfObject:item];
    
//    [self animationWithIndex:index];//调用缩放动画
    if (self.indexFlag != index) {

        [self downAnimationWithIndex:self.indexFlag];
        [self upAnimationWithIndex:index];
        self.indexFlag = index;
    }
    
//    if (index == 0) {
//        [self setUpFirstCoverButtonShow:YES];
//    }else {
//        [self setUpFirstCoverButtonShow:NO];
//    }
}

/// y轴移动动画，向上移动
/// @param index 选中的index
- (void)upAnimationWithIndex:(NSInteger)index {
    NSMutableArray *tabBarButtonImageArray = [NSMutableArray array];
    
    for (UIControl *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            for (UIView *imageView in tabBarButton.subviews) {
                if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                    //添加动画
                    [tabBarButtonImageArray addObject:imageView];
                    //---将下面的动画代码块拷贝到此并修改最后一行addAnimation的layer对象即可---
                }
            }
        }
    }
    
    //向上移动
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
//    //速度控制函数，控制动画运行的节奏
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//
//    animation.duration = 0.2;       //执行时间
//    animation.repeatCount = 1;      //执行次数
//    animation.removedOnCompletion = NO;
////    animation.autoreverses = YES;
//    animation.fillMode = kCAFillModeForwards;// 设置动画完成时，返回到原点
//    animation.fromValue = [NSNumber numberWithFloat:0];   //初始伸缩倍数
//    animation.toValue = [NSNumber numberWithFloat:-10];     //结束伸缩倍数
//    [[tabBarButtonImageArray[index] layer] addAnimation:animation forKey:nil];

    UIView *imageView = tabBarButtonImageArray[index];
    CASpringAnimation *animaton = [CASpringAnimation animationWithKeyPath:@"position.y"];
    animaton.initialVelocity = 6.f;
    animaton.mass = 5;//质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大 Defaults to one
    animaton.stiffness = 200;//刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快 Defaults to 100
    animaton.damping = 10;//阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快 Defaults to 10
    animaton.duration = animaton.settlingDuration;
    animaton.fillMode = kCAFillModeForwards;//当动画结束后，layer会一直保持着动画最后的状态
//    animaton.autoreverses = NO;//默认是NO
    animaton.removedOnCompletion = NO;//默认为YES 。当设置为YES时，动画结束后，移除layer层的；当设置为NO时，保持动画结束时layer的状态；
    animaton.fromValue = @(imageView.layer.position.y);
    animaton.toValue = @(imageView.layer.position.y-6);
    animaton.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [[tabBarButtonImageArray[index] layer] addAnimation:animaton forKey:nil];
}


/// y轴移动动画，向下移动动画
/// @param index 上次选中item的index
- (void)downAnimationWithIndex:(NSInteger)index {
    NSMutableArray *tabBarButtonImageArray = [NSMutableArray array];
    
    for (UIControl *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            for (UIView *imageView in tabBarButton.subviews) {
                if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                    //添加动画
                    [tabBarButtonImageArray addObject:imageView];
                    //---将下面的动画代码块拷贝到此并修改最后一行addAnimation的layer对象即可---
                }
            }
        }
    }
    
    //向下移动
    UIView *imageView = tabBarButtonImageArray[index];
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
//    //速度控制函数，控制动画运行的节奏
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animation.duration = 0.2;       //执行时间
//    animation.repeatCount = 1;      //执行次数
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;// 设置动画完成时，返回到原点
//    animation.fromValue = @(imageView.layer.position.y-10);   //初始伸缩倍数
//    animation.toValue = @(imageView.layer.position.y);     //结束伸缩倍数
//    [[tabBarButtonImageArray[index] layer] addAnimation:animation forKey:nil];
    
    CASpringAnimation *animaton = [CASpringAnimation animationWithKeyPath:@"position.y"];
    animaton.initialVelocity = .4f;
    animaton.duration = animaton.settlingDuration;
    animaton.fillMode = kCAFillModeForwards;//
    animaton.autoreverses = NO;//默认是NO
    animaton.removedOnCompletion = NO;//默认为YES 。当设置为YES时，动画结束后，移除layer层的；当设置为NO时，保持动画结束时layer的状态；
    animaton.fromValue = @(imageView.layer.position.y-6);
    animaton.toValue = @(imageView.layer.position.y);
    animaton.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [[tabBarButtonImageArray[index] layer] addAnimation:animaton forKey:nil];
}

/// 缩放动画，实现点击闪烁效果
/// @param index 点击的item的index
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray *tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];//设定动画的速度变化 ，kCAMediaTimingFunctionEaseInEaseOut先加速后减速,效果为淡入淡出
    pulse.duration = 0.4;
    pulse.repeatCount = 1;
//    pulse.autoreverses = YES;//动画结束时是否执行逆动画
    pulse.fromValue = [NSNumber numberWithFloat:0.85];
    pulse.toValue = [NSNumber numberWithFloat:1.0];
    [[tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
}

- (void)setUpFirstCoverButtonShow:(BOOL)show {
    UITabBarItem *firstBarButtonItem = self.viewControllers[0].tabBarItem;
    UIControl *firstBarButton = firstBarButtonItem.tabBarButton;//这个写了一个分类取,需要好好看一看
    
    if (show && !_firstCoverButton) {
        UIImage *image = [UIImage imageNamed:@"tabbar_select_bg"];
        
        self.firstCoverButton.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        self.firstCoverButton.center = CGPointMake((SCREEN_WIDTH/6), firstBarButton.center.y);
        [firstBarButton addSubview:self.firstCoverButton];
        [firstBarButton bringSubviewToFront:self.firstCoverButton];
    }
    self.firstCoverButton.hidden = !show;
    firstBarButtonItem.tabBarButtonLabel.hidden = (show);
    firstBarButtonItem.tabBarButtonImageView.hidden = (show);
    self.firstCoverButton.selected = YES;
}

- (void)pressFirstCoverButton {
    self.firstCoverButton.selected = !self.firstCoverButton.isSelected;
}

- (UIButton *)firstCoverButton {
    if (!_firstCoverButton) {
        _firstCoverButton = [[UIButton alloc]init];
        [_firstCoverButton setBackgroundImage:[UIImage imageNamed:@"tabbar_select_bg"] forState:UIControlStateNormal];
        [_firstCoverButton setBackgroundImage:[UIImage imageNamed:@"tabbar_select_fill"] forState:UIControlStateSelected];
        [_firstCoverButton addTarget:self action:@selector(pressFirstCoverButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _firstCoverButton;
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
