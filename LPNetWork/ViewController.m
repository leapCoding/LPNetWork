//
//  ViewController.m
//  LPNetWork
//
//  Created by lipeng on 17/3/24.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import "ViewController.h"
#import "LPApiManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, 100, 40)];
    [button1 setTitle:@"请求数据" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(requestData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(120, 100, 100, 40)];
    [button2 setTitle:@"取消请求" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(cancellRequestData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
}

- (void)requestData {
    [LPApiManager getUrl:@"http://webapi.airfortune.cn/api/Project/QueryProjectList" parameters:@{@"MemberId":@"",@"Category":@"",@"Status":@"",@"PageSize":@"100",@"PageIndex":@"1"} className:nil responseBlock:^(LPNetWorkResponse *response) {
        
    }];
    [self cancellRequestData];
}

- (void)cancellRequestData {
    [LPApiManager cancelRequestWithURL:@"http://webapi.airfortune.cn/api/Project/QueryProjectList"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
