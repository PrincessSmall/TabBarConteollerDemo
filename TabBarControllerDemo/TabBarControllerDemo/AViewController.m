//
//  ViewController.m
//  TabBarControllerDemo
//
//  Created by LiMin on 2019/10/28.
//  Copyright © 2019 LiMin. All rights reserved.
//

#import "AViewController.h"
#import "CViewController.h"

@interface AViewController ()

@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = @"A页面";
    [self.view addSubview:self.nextButton];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.navigationItem.title = @"A页面";
    NSLog(@"AViewController viewDidLoad");
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"A页面 viewDidAppear topViewController = %@ ,  visibleViewController = %@",self.navigationController.topViewController,self.navigationController.visibleViewController);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}

- (void)selectNextButtonAction {
    CViewController *vc = [[CViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)closeAction {
    NSLog(@"closeAction");
}

- (UIButton *)nextButton {
    if (!_nextButton) {
        _nextButton = [[UIButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-150)/2, 250, 150, 80)];
        [_nextButton setTitle:@"进入C页面" forState:UIControlStateNormal];
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_nextButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_nextButton setBackgroundColor:[UIColor blueColor]];
        [_nextButton addTarget:self action:@selector(selectNextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}


@end
