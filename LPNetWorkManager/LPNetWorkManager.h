//
//  LPNetWorkManager.h
//  LPNetWork
//
//  Created by lipeng on 17/3/24.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSTimeInterval kNetworkingTimeoutSeconds = 10.0f; //请求超时设置（单位：秒）

//网络请求类型
typedef NS_ENUM(NSUInteger, LPApiRequestType) {
    LPApiRequestTypeGet = 0,    //Get 请求
    LPApiRequestTypePost,       //Post 请求
};

//网络请求错误类型
typedef NS_ENUM(NSUInteger, LPApiErrorType) {
    LPApiErrorTypeDefault = 0,
    LPApiErrorTypeSuccess,           //API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。
    LPApiErrorTypeTimeout,           //请求超时。
    LPApiErrorTypeNoNetWork,         //网络不通。
    LPApiErrorTypeFail,              //请求失败
};

typedef void(^LPCallback)(id responseObject, LPApiErrorType errorType);

@interface LPNetWorkManager : NSObject

+ (NSMutableArray *)allTasks;

+ (instancetype)sharedManager;

- (NSURLSessionDataTask *)callApiWithUrl:(NSString *)url params:(NSDictionary *)params requestType:(LPApiRequestType)requestType callBack:(LPCallback)callback;

- (void)cancelAllRequest;

@end
