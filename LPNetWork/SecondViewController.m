//
//  SecondViewController.m
//  LPNetWork
//
//  Created by Leap on 2017/3/25.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import "SecondViewController.h"
#import "LPApiManager.h"
#import "LPDemoModel.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)dealloc {
    ASLog(@"-------dealloc:%@",self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, 100, 40)];
    [button1 setTitle:@"请求数据" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(requestData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(120, 100, 100, 40)];
    [button2 setTitle:@"返回" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc]initWithFrame:CGRectMake(120, 200, 100, 40)];
    [button3 setTitle:@"下一界面" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(nextVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
}
- (void)nextVC {
    [self presentViewController:[SecondViewController new] animated:YES completion:nil];
}

- (void)requestData {
    [LPDemoModel loadDataWithParams:@{@"MemberId":@"",@"Category":@"",@"Status":@"",@"PageSize":@"10",@"PageIndex":@"1"}];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
