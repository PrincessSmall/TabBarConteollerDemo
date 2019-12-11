//
//  CViewController.m
//  TabBarControllerDemo
//
//  Created by LiMin on 2019/10/28.
//  Copyright © 2019 LiMin. All rights reserved.
//

#import "CViewController.h"

@interface CViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *listTableview;
@property (nonatomic, strong) UIView *backView;

@end

@implementation CViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"C页面";
    self.navigationItem.title = @"C页面";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    NSLog(@"cViewController 的viewcontrollers = %@",viewControllers);
   
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"n_back"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction)];
//    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 10, 18);
    [backButton setBackgroundImage:[UIImage imageNamed:@"n_back"] forState:UIControlStateNormal];//自定义返回按钮
    [backButton addTarget:self action:@selector(returnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backitem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;//调整返回按钮的位置
    self.navigationItem.leftBarButtonItems = @[spaceItem,backitem];
    
//    if (@available(iOS 11.0,*)) {
//        self.listTableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }else{
//        //automaticallyAdjustsScrollViewIn，关闭自动偏移的系统优化
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
//    self.edgesForExtendedLayout = UIRectEdgeNone;//边缘延伸属性,避开导航栏
    
//    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.backView];
    [self.view addSubview:self.listTableview];
}

- (void)returnAction {
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"returnAction");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    NSLog(@"C页面 viewWillAppear topViewController = %@ ,  visibleViewController = %@",self.navigationController.topViewController,self.navigationController.visibleViewController);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"C页面 viewDidAppear topViewController = %@ ,  visibleViewController = %@",self.navigationController.topViewController,self.navigationController.visibleViewController);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSArray *viewControllers = self.navigationController.viewControllers;
    NSLog(@"viewDidDisappear cViewController 的viewcontrollers = %@",viewControllers);
}


#pragma mark --------UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}


#pragma mark --------lazy

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
