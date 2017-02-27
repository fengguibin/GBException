//
//  ViewController.m
//  GBException
//
//  Created by kitmb3 on 17/2/27.
//  Copyright © 2017年 Fengguibin. All rights reserved.
//

#import "ViewController.h"
#import "UIView+WLFrame.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavagation];
    
    // 测试崩溃按钮创建
    UIButton *testBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    testBtn.frame = CGRectMake((kScreenWidth - 100) / 2, 200, 100, 100);
    [testBtn setTitle:@"测试崩溃" forState:(UIControlStateNormal)];
    [testBtn setTitleColor:[UIColor purpleColor] forState:(UIControlStateNormal)];
    [testBtn setBackgroundColor:[UIColor orangeColor]];
    [testBtn addTarget:self action:@selector(actionTestBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:testBtn];
    
}

// 初始化导航栏
- (void)initNavagation {
    self.navigationItem.title = @"测试崩溃";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.149 green:0.643 blue:0.929 alpha:1.000];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage alloc]init] style:(UIBarButtonItemStylePlain) target:self action:nil];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19], NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

// 测试按钮响应方法
- (void)actionTestBtn:(UIButton *)testBtn {
    
    NSArray *array = [NSArray arrayWithObject:@"there is only one objective in this arary,call index one, app will crash and throw an exception!"];
    NSLog(@"%@", [array objectAtIndex:1]);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
