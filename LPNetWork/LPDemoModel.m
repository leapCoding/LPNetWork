//
//  LPDemoModel.m
//  LPNetWork
//
//  Created by Leap on 2017/3/25.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import "LPDemoModel.h"
#import "LPApiManager.h"

@implementation LPDemoModel

+ (void)loadDataWithParams:(NSDictionary *)dic {
    [LPApiManager getUrl:@"http://webapi.airfortune.cn/api/Project/QueryProjectList" parameters:dic className:self responseBlock:^(LPNetWorkResponse *response) {
        
    }];
}

@end
