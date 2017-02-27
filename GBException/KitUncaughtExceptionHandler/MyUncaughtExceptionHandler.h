//
//  MyUncaughtExceptionHandler.h
//  YangChengPai
//
//  Created by fengguibin on 16/8/9.
//  Copyright © 2016年 gzkitmb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
// 崩溃日志
@interface MyUncaughtExceptionHandler : NSObject
{
     BOOL dismissed;
}

+ (void)setDefaultHandler;
+ (NSUncaughtExceptionHandler *)getHandler;

/**
 获取崩溃后的处理

 @param exception 崩溃信息
 */
- (void)takeException:(NSException *)exception;

@end
