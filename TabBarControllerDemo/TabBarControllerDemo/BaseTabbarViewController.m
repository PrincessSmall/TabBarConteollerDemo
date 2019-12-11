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

@end

@implementation BaseTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildVC];
    [self setUpFirstCoverButtonShow:YES];
    ;
    
    // Do any additional setup after loading the view.
}

- (void)setupChildVC {
    
    AViewController *avc = [[AViewController alloc]init];
    [self setupTabbarItem:avc.tabBarItem title:@"首页" titleSize:12 titleFontName:@"HeiTi SC" normalTitleColor:[UIColor grayColor] selectedTitleColor:[UIColor purpleColor] normalImage:@"tabbar_about_normal" selectedImage:@"tabbar_about_select"];
    
    BViewController *bvc = [[BViewController alloc]init];
    [self setupTabbarItem:bvc.tabBarItem title:@"订单" titleSize:12 titleFontName:@"HeiTi SC" normalTitleColor:[UIColor grayColor] selectedTitleColor:[UIColor purpleColor] normalImage:@"tabbar_order_normal" selectedImage:@"tabbar_order_select"];
    
    CViewController *cvc = [[CViewController alloc]init];
    [self setupTabbarItem:cvc.tabBarItem title:@"我的" titleSize:12 titleFontName:@"HeiTi SC" normalTitleColor:[UIColor grayColor] selectedTitleColor:[UIColor purpleColor] normalImage:@"tabbar_user_normal" selectedImage:@"tabbar_user_select"];
    
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
    [self animationWithIndex:index];
    if (index == 0) {
        [self setUpFirstCoverButtonShow:YES];
    }else {
        [self setUpFirstCoverButtonShow:NO];
    }
}

- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray *tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];//设定动画的速度变化 ，kCAMediaTimingFunctionEaseInEaseOut先加速后减速
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
