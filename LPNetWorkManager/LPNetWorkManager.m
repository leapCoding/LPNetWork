//
//  LPNetWorkManager.m
//  LPNetWork
//
//  Created by lipeng on 17/3/24.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import "LPNetWorkManager.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface LPNetWorkManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;   //通用会话管理器

@end

@implementation LPNetWorkManager

static NSMutableArray *requestTasks;
+ (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (requestTasks == nil) {
            requestTasks = [[NSMutableArray alloc] init];
        }
    });
    return requestTasks;
}

/**
 *  创建及获取单例对象的方法
 *
 *  @return 管理请求的单例对象
 */
+ (instancetype)sharedManager
{
    static LPNetWorkManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LPNetWorkManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self initSessionManager];
    }
    return self;
}

- (void)initSessionManager {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    // 设置全局会话管理实例
    _sessionManager = [AFHTTPSessionManager manager];
    
    // 设置请求序列化器
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    requestSerializer.timeoutInterval = kNetworkingTimeoutSeconds;
    _sessionManager.requestSerializer = requestSerializer;
    
    // 设置请求头
    NSDictionary *headers = @{@"X-Message-Sender":@"Afc-Web-API",@"Terminal":@"1",@"AppVersion":@"1"};
    [headers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj) {
            [_sessionManager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
    }];
    
    // 设置响应序列化器，解析Json对象
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    responseSerializer.removesKeysWithNullValues = YES; // 清除返回数据的 NSNull
    responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                      @"text/html",
                                                                      @"text/json",
                                                                      @"text/plain",
                                                                      @"text/javascript",
                                                                      @"text/xml",
                                                                      @"image/*"]]; // 设置接受数据的格式
    _sessionManager.responseSerializer = responseSerializer;
    // 设置安全策略
    self.sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];;
}

- (NSURLSessionDataTask *)callApiWithUrl:(NSString *)url params:(NSDictionary *)params requestType:(LPApiRequestType)requestType callBack:(LPCallback)callback {
    // url长度为0时，返回错误
    if (!url || url.length == 0)
    {
        if (callback) {
            callback(nil,LPApiErrorTypeFail);
        }
        return nil;
    }
    // 会话管理对象为空时
    if (!_sessionManager)
    {
        [self initSessionManager];
    }
    
    // 请求成功时的回调
    void (^successWrap)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        if (!responseObject || (![responseObject isKindOfClass:[NSDictionary class]] && ![responseObject isKindOfClass:[NSArray class]])) // 若解析数据格式异常，返回错误
        {
            if (callback)
            {
                callback(nil,LPApiErrorTypeFail);
            }
        }
        else // 若解析数据正常，判断API返回的code，
        {
            if (callback) {
                callback(responseObject,LPApiErrorTypeSuccess);
            }
        }
    };
    
    // 请求失败时的回调
    void (^failureWrap)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        if (callback) {
            callback(nil,LPApiErrorTypeFail);
        }
    };

    
    // 检查url
    if (![NSURL URLWithString:url]) {
        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    
    __block NSURLSessionDataTask * urlSessionDataTask;
    if (requestType == LPApiRequestTypeGet) {
        urlSessionDataTask = [_sessionManager GET:url parameters:params progress:nil success:successWrap failure:failureWrap];
    }else if (requestType == LPApiRequestTypePost) {
        urlSessionDataTask = [_sessionManager POST:url parameters:params progress:nil success:successWrap failure:failureWrap];
    }
    
    return urlSessionDataTask;
}

#pragma mark --取消当前所有网络请求
- (void)cancelAllRequest {
    [self.sessionManager.operationQueue cancelAllOperations];
}

@end
