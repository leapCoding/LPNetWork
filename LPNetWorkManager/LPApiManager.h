//
//  LPApiManager.h
//  LPNetWork
//
//  Created by lipeng on 17/3/24.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPNetWorkManager.h"
#import "YYKit.h"
@class LPNetWorkResponse;
@interface LPApiManager : NSObject

typedef void (^ResponseBlock)(LPNetWorkResponse *response);

/** 网络请求requestUrl*/
@property (nonatomic, copy) NSString *requestUrl;

/** 网络请求类型*/
@property (nonatomic, assign) LPApiRequestType requestType;

/** 请求参数*/
@property (nonatomic, strong) NSDictionary *params;

/** 需要模型转换的类名*/
@property (nonatomic, strong) Class modelClass;

+ (instancetype)getUrl:(NSString *)url
    parameters:(NSDictionary *)parameters
     className:(Class)className
 responseBlock:(ResponseBlock)responseBlock;

+ (instancetype)postUrl:(NSString *)url
            parameters:(NSDictionary *)parameters
             className:(Class)className
         responseBlock:(ResponseBlock)responseBlock;

+ (void)cancelAllRequest;

+ (void)cancelRequestWithURL:(NSString *)url;

@end

//接口返回数据对象
@interface LPNetWorkResponse : NSObject

@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, assign) NSInteger code;
/** 解析后的对象/数组 */
@property (nonatomic, strong) id result;

- (instancetype)initWithResult:(NSDictionary *)result className:(Class)className;

@end
