//
//  LPDemoModel.h
//  LPNetWork
//
//  Created by Leap on 2017/3/25.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPDemoModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *field;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *memberId;
@property (nonatomic, copy) NSString *modifyTime;

+ (void)loadDataWithParams:(NSDictionary *)dic;

@end
