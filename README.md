# TabBarConteollerDemo
练习UITabBarController和UINavigationController

## 想解决的问题
* 1. UITabBarController，UINavigationController是什么？
* 2. 怎么用？（市场上项目时常如何使用）
* 3. 尝试使用之后遇到的问题。

## 一、UITabBarController，UINavigationController是什么？
* 都是UIViewController的子类，用来管理其他控制器的两个特殊控制器。

## 二、如何使用？

### 1. 底部导航栏的设计模式

> 现在绝大部分APP都采用TabBarController和NavigationController相结合的设计模式，也是iOS一种很经典的框架设计模式.

* 方案一：使用navigationController作为根控制器rootViewController，每个navigationController再对应多个tabbarController，这种设计模式tabbar底部不会和NavigationController的Title相对应，所以不推荐这种设计模式。
* 方案二：使用TabbarController做为根控制器，结合添加多个navigationCOntroller子控制器，每个界面都有自己的导航控制器,界面跳转也都有自己的栈,会更加灵活。

#### 方案二的实现代码

> UIWindow是一种特殊的UIView，通常在一个应用中只会有一个UIWindow。在iOS程序启动完成后，建立的第一个视图控件就是UIWindow，接着创建一个控制器的View，最后将控制器的View添加到UIWindow上，于是控制器的View就是显示到屏幕上了。一个iOS程序之所以能显示在屏幕上，完全是因为它有UIWindow，也就是说没有UIWindow就看不到任何UI界面。


* 1> 在didFinishLaunchingWithOptions中设置window的rootViewController
```
// 程序启动完成调用
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 创建Window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // 设置Window的背景颜色
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 设置根控制器
    BaseTabBarViewController *vc = [[BaseTabBarViewController alloc] init];
    self.window.rootViewController = vc;
    // 设置并显示主窗口
    [self.window makeKeyAndVisible];
    return YES;
}
```

* 获取rootViewController
```
//第一种方法：
UIWindow *window = [UIApplication sharedApplication].keyWindow;
UIViewController *rootViewController = window.rootViewController;

//第二种方法：
AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
UIViewController *rootViewController = appdelegate.window.rootViewController;
```

* 2> 设置BaseTabBarViewController继承UITabBarController，在.m中设置相应的viewControllers
```
// 添加子控制器viewControllers
- (void)setupChildVC {
    
    AViewController *avc = [[AViewController alloc]init];
    [self setupTabbarItem:avc.tabBarItem title:@"首页" titleSize:12 titleFontName:@"HeiTi SC" normalTitleColor:[UIColor grayColor] selectedTitleColor:[UIColor purpleColor] normalImage:@"tabbar_about_normal" selectedImage:@"tabbar_about_select"];
    
    BViewController *bvc = [[BViewController alloc]init];
    [self setupTabbarItem:bvc.tabBarItem title:@"订单" titleSize:12 titleFontName:@"HeiTi SC" normalTitleColor:[UIColor grayColor] selectedTitleColor:[UIColor purpleColor] normalImage:@"tabbar_order_normal" selectedImage:@"tabbar_order_select"];
    
    BaseNavigationController *navA = [[BaseNavigationController alloc]initWithRootViewController:avc];//这里的BaseNavigationController是继承UINavigationController的子类
    BaseNavigationController *navB = [[BaseNavigationController alloc]initWithRootViewController:bvc];
    
    self.viewControllers = @[navA,navB];
}

// 封装一个方法，设置子控制器的tabbarItem数据
- (void)setupTabbarItem:(UITabBarItem *)tabbarItem title:(NSString *)title titleSize:(CGFloat)size titleFontName:(NSString *)fontName normalTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage {
    
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
}

```
* 3> 创建BaseNavigationController继承于UINavigationController，用于封装一些公用的属性和方法

```
/**
 能拦截所有push进来的子控制器,这一方法用于隐藏底部的tabbar栏
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"%@ %lu",viewController,(unsigned long)self.viewControllers.count);
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
```

### 2. 导航栏样式设置

> 设置导航栏的样式可分为全局设置与局部设置；

#### 1> 全局设置
* 全局设置一般的都是在AppDelegate中设置，这样整个app都会生效，相关的代码与效果图如下：

```
    // 1.设置导航栏默认的背景颜色
    [[UINavigationBar appearance] setBarTintColor:kPrimaryColor];
    
    // 2. 设置导航栏透明度
    [[UINavigationBar appearance] setTranslucent:NO];
    
    // 3. 设置导航栏分割线
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    // 4.设置导航栏背景图片
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    // 5. 设置导航栏所有按钮的默认颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    // 6. 设置导航栏标题默认字体大小 颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20], NSForegroundColorAttributeName:[UIColor whiteColor]}];
```

#### 2> 局部设置

* 全局设置后，如果只有其中几个页面导航栏样式不同，那么我们可以使用局部设置。

> tips : 
>* 注意1：局部设置与全局设置方法相同，但调用方法的对象变成了"self.navigationController.navigationBar"
>* 注意2：局部设置必须遵循一个原则："进入页面时修改，离开页面时还原”。

* 比如我们进入一个页面，需要设置当前导航栏的背景色为灰色，使用如下方法：
```
//进入页面时设置颜色：灰色
- (void)viewWillAppear:(BOOL)animated{
 [super viewWillAppear:animated];
 [self.navigationController.navigationBar setBarTintColor:[UIColor grayColor]];
}
 
//离开页面时还原为全局设置：橙色
- (void)viewWillDisappear:(BOOL)animated{
 [super viewWillDisappear:animated];
 [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
}
```

### 3. 修改返回按钮

#### 1> 修改按钮图片
* 直接在相应控制器的ViewDidLoad中修改
```
UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
leftBtn.frame = CGRectMake(0, 0, 25,25);
[leftBtn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
[leftBtn addTarget:self action:@selector(leftBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
}
- (void)leftBarBtnClicked:(UIButton *)btn
{
 [self.navigationController popViewControllerAnimated:YES];
}
```

#### 2> 修改返回按钮位置
* 如果我们想调整按钮的位置该怎么做呢？设置Frame显然是行不通的，因为导航栏的NavigationItem是个比较特殊的View，我们无法通过简单的调整Frame来的调整左右按钮的位置。但是在苹果提供的UIButtonBarItem 中有个叫做UIBarButtonSystemItemFixedSpace的控件，利用它，我们就可以轻松调整返回按钮的位置。具体使用方法如下
```
//创建返回按钮
UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
leftBtn.frame = CGRectMake(0, 0, 25,25);
[leftBtn setBackgroundImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
[leftBtn addTarget:self action:@selector(leftBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
UIBarButtonItem * leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];;
//创建UIBarButtonSystemItemFixedSpace
UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//将宽度设为负值
spaceItem.width = -15;
//将两个BarButtonItem都返回给NavigationItem
self.navigationItem.leftBarButtonItems = @[spaceItem,leftBarBtn];

```

## 三、使用中常遇到的问题

### 1. 有的页面需要隐藏底部tabbar
* 问题：可以在push的时候隐藏tabbar，但是如果每个页面都写一遍viewController.hidesBottomBarWhenPushed = YES;过于繁琐。
* 解决：
  * BaseNavigationController中重写pushViewController:方法，在push时hidesBottomBarWhenPushed；
  * 并且为了避免一级页面刚进去就没有tabbar，加上判断当栈内的viewcontrollers的数量大于0时才隐藏tabbar；
  * 具体代码见下面；
```
/**
 能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"%@ %lu",viewController,(unsigned long)self.viewControllers.count);
    if (self.viewControllers.count > 0) {//一级页面出现的时候栈内viewControllers为0，所以可以使用这个判断当>0时不是一级页面
        viewController.hidesBottomBarWhenPushed = YES;//隐藏底部的tabbar栏
    }
    [super pushViewController:viewController animated:animated];
}
```

### 2. 不同页面的navigationBar的barTintColor颜色不一样（这个可以参考上面的全局设置和局部设置）
* 解决：局部设置部分导航栏样式不一样的页面，遵循上面说的页面进来时设置，页面消失时还原。因为项目中有多处使用相同代码，所以在基类BaseViewController中写了一个方法供子类调用。

```
//1. 控制器基类BaseViewController中提供这一个方法，用于在子类中调用
- (void)changeNavigationBarAppearanceWithMode:(BOOL)simpleModel {
    if (simpleModel) {
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:18],NSForegroundColorAttributeName:HexColor(@"#262626")}];
        [self.navigationController.navigationBar setTintColor:HexColor(@"#000000")];
        // 状态栏字体为黑色，状态栏和导航栏背景为白色
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        
    }else {
        self.navigationController.navigationBar.barTintColor = kPrimaryColor;
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:HexColor(@"#ffffff")}];
        [self.navigationController.navigationBar setTintColor:HexColor(@"#ffffff")];
        
        // // 状态栏字体为白色，状态栏和导航栏背景为黑色
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
}

// 2. 需要改变成特殊颜色的控制器中设置
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self changeNavigationBarAppearanceWithMode:YES];//设置为这个页面需要的颜色
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self changeNavigationBarAppearanceWithMode:NO];//在页面将要消失的时候将颜色重新设置回来
}

```

### 3. 改变导航栏返回按钮的图标
* 以下代码写在自定义的导航控制器中，这个方式可以，但是我更喜欢上文中的方法。
```
// 1. 替换系统默认返回图片
 - (void)viewDidLoad {
    [super viewDidLoad];
 
    // 自定义返回图片(在返回按钮旁边) 这个效果由navigationBar控制
    [self.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"n_back"]];
    [self.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"n_back"]];
}

// 2. 去掉文字
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
    
    // 去掉系统backBarButtonItem的默认显示效果
   // 这个效果由控制器控制(A push B 则在A中设置)
   /***
    1、如果B视图有一个自定义的左侧按钮（leftBarButtonItem），则会显示这个自定义按钮；
    2、如果B没有自定义按钮，但是A视图的backBarButtonItem属性有自定义项，则显示这个自定义项；
    3、如果前2条都没有，则默认显示一个后退按钮，后退按钮的标题是A视图的标题。
*/
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:NULL];
        viewController.navigationItem.backBarButtonItem = item;
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

```

### 4. 解决自定义导航栏返回按钮后侧滑不可用问题
* iOS导航栏自带的返回按钮形式单一，所以大多情况下，我们都需要自定义导航栏返回按钮。但是此时我们却发现页面的侧滑返回功能不可用了。为了解决这个问题，我们需要在App中使用我们自定义的导航控制控制器，示例代码如下：

```
#import “BaseNavigationController.h"
//第一步：设置自定义导航控制器使用UIGestureRecognizerDelegate
@interface BaseNavigationController ()<UIGestureRecognizerDelegate>
@end
 
@implementation BaseNavigationController
- (void)viewDidLoad {
 [super viewDidLoad];
 //第二步：设置自定义导航控制器的侧滑手势的代理
 self.interactivePopGestureRecognizer.delegate = self;
}
  
//第三步：实现代理方法
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
 if (self.childViewControllers.count == 1) {
 // 表示用户在根控制器界面，就不需要触发滑动手势，
 return NO;
 }
 return YES;
}
@end
```

### 5. 导航栏引起的布局问题

**1. 内容偏移属性：automaticallyAdjustsScrollViewInsets**
* automaticallyAdjustsScrollViewInsets是视图控制器的一个属性，默认为YES，用于优化滑动类视图(继承于UIScrollView的视图)在视图控制里的显示：
* iOS系统的导航栏UINavigationBar与标签栏UITabBar默认都是半透明模糊效果，在这种情况下系统会对视图控制器的UI布局进行优化：视图控制器里面第一个被添加进去的视图是滑动类视图，并且其Frame是整个屏幕大小时，系统会自动调整其contenInset，以保证滑动视图里的内容不被UINavigationBar与UITabBar遮挡。
* 但是对于普通的视图，此时我们仍然需要注意：非滑动视图的布局仍然要考虑导航栏和标签栏高度，注意不被遮挡，比如布局的时候加上导航栏高度，以免内容被导航栏遮挡。
* 在控制器中增加滚动视图之后。cell的展示会被优化到导航栏下方，但是普通view会被遮挡。可以使用如下代码测试一下
```
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"C页面";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.listTableview];
    [self.view addSubview:self.backView];
}
- (UITableView *)listTableview {
    if (!_listTableview) {
        _listTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _listTableview.backgroundColor = [UIColor grayColor];
        _listTableview.delegate = self;
        _listTableview.dataSource =self;
    }
    return _listTableview;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 0, [UIScreen mainScreen].bounds.size.width/2, 100)];
        _backView.backgroundColor = [UIColor redColor];
    }
    return _backView;
}
//打印视图的frame信息，占据全屏的tableview视图打印出来的结果
<UITableView: 0x7fef3c83fc00; frame = (0 0; 187.5 812); clipsToBounds = YES; gestureRecognizers = <NSArray: 0x6000001e6a30>; layer = <CALayer: 0x600000fe3a60>; contentOffset: {0, -88}; contentSize: {187.5, 970}; adjustedContentInset: {88, 0, 34, 0}>

* tableview高度已经占据整个屏幕的高度，其顶部已经延伸到导航栏下。但是cell内容部分却自动向下偏移，没有被导航栏遮挡。这是因为系统自动优化调整了其内边距；
* backView因为是非滑动视图，已经被导航栏遮挡。
```
* 其实，这种系统的优化也是可以控制关闭的，关闭优化之后，滑动视图就会和普通视图一样，如果还设置其布局的原点是(0,0),其内容就会被导航栏所覆盖，关键代码如下：
```
//automaticallyAdjustsScrollViewInsets在11.0后失效，所以需要判断
if (@available(iOS 11.0,*)) {
 scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
}else{
 //automaticallyAdjustsScrollViewIn，关闭自动偏移的系统优化
 self.automaticallyAdjustsScrollViewInsets = NO;
}

//关闭优化之后打印tableview的frame信息如下
UITableView: 0x7ffa0c046a00; frame = (0 0; 187.5 812); clipsToBounds = YES; gestureRecognizers = <NSArray: 0x60000032e880>; layer = <CALayer: 0x600000d08780>; contentOffset: {0, 0}; contentSize: {187.5, 928}; adjustedContentInset: {0, 0, 0, 0}>

```

**2. 边缘延伸属性：edgesForExtendedLayout**
* edgesForExtendedLayout也是视图控制器的布局属性，默认值是UIRectEdgeAll，即：当前视图控制器里各种UI控件会忽略导航栏和标签的存在，布局时若设置其原点设置为(0,0)，视图会延伸显示到导航栏的下面被覆盖。但是当设置self.edgesForExtendedLayout=UIRectEdgeNone之后，此时视图控制器里内容就会避开导航栏和标签栏了，和automaticallyAdjustsScrollViewInsets的区别是，整个tableview都会移到导航栏下方。
```
//还是上面那个例子，打印出来的tableView的frame信息
<UITableView: 0x7fc3590a4000; frame = (0 0; 187.5 812); clipsToBounds = YES; gestureRecognizers = <NSArray: 0x60000176bab0>; layer = <CALayer: 0x600001962fe0>; contentOffset: {0, 0}; contentSize: {187.5, 928}; adjustedContentInset: {0, 0, 34, 0}>

```
**3.导航栏透明属性translucent**
* 上述两种属性都是在解决导航栏半透明情况下的布局问题，但是如果我们的需求就是导航栏不透明，那么视图控制器里的控件就会默认从(0,64)开始布局了，设置导航栏不透明的方法如下:
```
self.navigationController.navigationBar.translucent= NO;

// 添加了这句代码之后tableView以及view效果和方法2 一样。下面是frame描述
<UITableView: 0x7fbdd704f200; frame = (0 0; 187.5 812); clipsToBounds = YES; gestureRecognizers = <NSArray: 0x6000025bf1e0>; layer = <CALayer: 0x600002bbe280>; contentOffset: {0, 0}; contentSize: {187.5, 928}; adjustedContentInset: {0, 0, 34, 0}>
<UIView: 0x7fbdd691a6c0; frame = (187.5 0; 187.5 100); layer = <CALayer: 0x600002bbea80>>
(lldb) 
```

## 参考文章：
* [IOS 学习笔记之基于 UITabBarController 的主流 APP 底部导航栏实现](http://www.cocoachina.com/articles/20094)
* [iOS设置自定义BackBarButtonItem](https://www.jianshu.com/p/f9f65f6d878f)
* [iOS中导航栏的基本使用汇总](https://www.jb51.net/article/144208.htm)
* [【iOS】让我们一次性解决导航栏的所有问题](https://www.jianshu.com/p/31f177158c9e)

试一下
