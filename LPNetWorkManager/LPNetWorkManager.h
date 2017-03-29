//
//  LPNetWorkManager.h
//  LPNetWork
//
//  Created by lipeng on 17/3/24.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#ifndef ASLog
#if DEBUG
#define ASLog(fmt, ...) NSLog((@"%s [Line %d] " fmt),__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define ASLog(fmt, ...)
#endif
#endif

#import <Foundation/Foundation.h>

static NSTimeInterval kNetworkingTimeoutSeconds = 10.0f; //请求超时设置（单位：秒）

//网络请求类型
typedef NS_ENUM(NSUInteger, LPApiRequestType) {
    LPApiRequestTypeGet = 0,    //Get 请求
    LPApiRequestTypePost,       //Post 请求
};

typedef NS_ENUM(NSUInteger, LPApiCacheType) {
    LPApiCacheTypeNetworkOnly = 0, //只加载网络数据
    LPApiCacheTypeCacheNetwork    //先加载缓存,然后加载网络
};

//网络请求错误类型
typedef NS_ENUM(NSUInteger, LPApiErrorType) {
    LPApiErrorTypeDefault = 0,
    LPApiErrorTypeSuccess,           //API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。
    LPApiErrorTypeFail,              //请求失败
    LPApiErrorTypeCancelled,         //取消网络请求
};

typedef void(^LPCallback)(id responseObject, LPApiErrorType errorType);

@interface LPNetWorkManager : NSObject

+ (NSMutableArray *)allTasks;

+ (instancetype)sharedManager;

- (NSURLSessionDataTask *)callApiWithUrl:(NSString *)url params:(NSDictionary *)params requestType:(LPApiRequestType)requestType callBack:(LPCallback)callback;

- (void)cancelAllRequest;

///////////////////////////////缓存方法////////////////////////////////////

/**
 异步缓存网络数据，根据请求的URL与parameters做KEY存储数据, 缓存多级页面的数据
 
 @param responseObject 服务器返回的数据
 @param URL 请求的URL地址
 @param parameters 请求的参数
 */
- (void)setCache:(NSDictionary *)responseObject URL:(NSString *)URL parameters:(NSDictionary *)parameters;

/**
 根据请求的URL与parameters 取出缓存数据
 
 @param URL 请求的URL地址
 @param parameters 请求的参数
 @return 缓存的服务器数据
 */
- (NSDictionary *)cacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters;

/**
 获取网络缓存的总大小 动态单位(GB,MB,KB,B)
 
 @return 网络缓存的总大小
 */
- (NSString *)cacheSize;

/**
 清除网络缓存
 */
- (void)clearCache;

@end
