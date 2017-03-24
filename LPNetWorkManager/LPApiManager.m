//
//  LPApiManager.m
//  LPNetWork
//
//  Created by lipeng on 17/3/24.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import "LPApiManager.h"

@interface LPApiManager ()

@property (nonatomic, strong) NSURLSessionDataTask *task;

@end

@implementation LPApiManager

+ (instancetype)getUrl:(NSString *)url
            parameters:(NSDictionary *)parameters
             className:(Class)className
         responseBlock:(ResponseBlock)responseBlock {
    LPApiManager *apiManager = [[LPApiManager alloc]initWithUrl:url params:parameters className:className rquestType:LPApiRequestTypeGet];
    return apiManager;
}

- (instancetype)initWithUrl:(NSString *)url params:(NSDictionary *)params className:(Class)className rquestType:(LPApiRequestType)requestType {
    if (self = [super init]) {
        [self loadDataWithUrl:url params:params className:className rquestType:requestType];
    }
    return self;
}

- (void)loadDataWithUrl:(NSString *)url params:(NSDictionary *)params className:(Class)className rquestType:(LPApiRequestType)requestType {
    __weak __typeof(self)weakSelf = self;
    self.task = [[LPNetWorkManager sharedManager] callApiWithUrl:url params:params requestType:requestType callBack:^(id responseObject, LPApiErrorType errorType) {
        ASLog(@"\nURL:%@\nparameters:%@\nResult:%@\n", url, params, errorType == LPApiErrorTypeSuccess ? responseObject : @"fali");
        [[LPNetWorkManager allTasks] removeObject:weakSelf.task];
    }];
    [self.task resume];
    if (self.task) {
        [[LPNetWorkManager allTasks] addObject:self.task];
        ASLog(@"1---------%@,%@",self.task,[LPNetWorkManager allTasks]);
    }
}

+ (void)cancelAllRequest {
    @synchronized(self) {
        ASLog(@"%@",[LPNetWorkManager allTasks]);
        [[LPNetWorkManager allTasks] enumerateObjectsUsingBlock:^(NSURLSessionDataTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[NSURLSessionDataTask class]]) {
                [task cancel];
            }
        }];
        [[LPNetWorkManager allTasks] removeAllObjects];
    };
}

+ (void)cancelRequestWithURL:(NSString *)url {
//    [[LPNetWorkManager sharedManager]cancelAllRequest];
    @synchronized(self) {
        [[LPNetWorkManager allTasks] enumerateObjectsUsingBlock:^(NSURLSessionDataTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            ASLog(@"2-----%@",task.currentRequest.URL.absoluteString);
            if ([task isKindOfClass:[NSURLSessionDataTask class]]
                && [task.currentRequest.URL.absoluteString hasSuffix:url]) {
                
                [task cancel];
                [[LPNetWorkManager allTasks] removeObject:task];
                return;
            }
        }];
    };
}

@end
