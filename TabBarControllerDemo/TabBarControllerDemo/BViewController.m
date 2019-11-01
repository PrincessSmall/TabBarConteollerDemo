//
//  BViewController.m
//  TabBarControllerDemo
//
//  Created by LiMin on 2019/10/28.
//  Copyright © 2019 LiMin. All rights reserved.
//

#import "BViewController.h"
#import "DViewController.h"

@interface BViewController ()

@property (nonatomic, strong) UIButton *bButton;

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第二页";
    [self.view addSubview:self.bButton];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)clickbButtonAction {
    NSLog(@"clickbButtonAction");
    DViewController *dvc = [[DViewController alloc]init];
    [self.navigationController pushViewController:dvc animated:YES];
}

- (UIButton *)bButton {
    if (!_bButton) {
        _bButton = [[UIButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-200)/2, 200, 200, 60)];
        [_bButton setTitle:@"点击进入下一页" forState:UIControlStateNormal];
        [_bButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_bButton setBackgroundColor:[UIColor orangeColor]];
        _bButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_bButton addTarget:self action:@selector(clickbButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bButton;
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
