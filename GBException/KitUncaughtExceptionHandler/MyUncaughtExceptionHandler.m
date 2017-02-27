//
//  MyUncaughtExceptionHandler.m
//  YangChengPai
//
//  Created by fengguibin on 16/8/9.
//  Copyright © 2016年 gzkitmb. All rights reserved.
//

#import "MyUncaughtExceptionHandler.h"


NSString * applicationDocumentsDirectory() {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

// 函数获取崩溃信息 
void UncaughtExceptionHandler(NSException * exception) {
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *url = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[arr componentsJoinedByString:@"\n"]];
    NSString *path = [applicationDocumentsDirectory() stringByAppendingPathComponent:@"Exception.txt"];
    [url writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    [[[MyUncaughtExceptionHandler alloc] init]
     performSelectorOnMainThread:@selector(takeException:)
     withObject:
     [NSException
      exceptionWithName:[exception name]
      reason:[exception reason]
      userInfo:[NSMutableDictionary dictionary]]
     waitUntilDone:YES];
}

void SignalHandler(int signal) {
    
    NSString *url = [NSString stringWithFormat:@"========异常错误报告========\nname:UncaughtExceptionHandlerSignalExceptionName\nreason:\n%@\ncallStackSymbols:\n%@",
                     [NSString stringWithFormat:
                      NSLocalizedString(@"Signal %d was raised.", nil),
                      signal],@"UncaughtExceptionHandlerSignalKey"];
    NSString *path = [applicationDocumentsDirectory() stringByAppendingPathComponent:@"Exception.txt"];
    [url writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    [[[MyUncaughtExceptionHandler alloc] init]
     performSelectorOnMainThread:@selector(takeException:)
     withObject:
     [NSException
      exceptionWithName:@"UncaughtExceptionHandlerSignalExceptionName"
      reason:
      [NSString stringWithFormat:
       NSLocalizedString(@"Signal %d was raised.", nil),
       signal]
      userInfo:
      [NSDictionary
       dictionaryWithObject:[NSNumber numberWithInt:signal]
       forKey:@"UncaughtExceptionHandlerSignalKey"]]
     waitUntilDone:YES];
}




@implementation MyUncaughtExceptionHandler
// 沙盒地址
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


+ (void)setDefaultHandler {
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}


+ (NSUncaughtExceptionHandler *)getHandler {
    return NSGetUncaughtExceptionHandler();
}


// 获取崩溃后的处理
- (void)takeException:(NSException *)exception {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"抱歉，程序出现了异常", nil)
                                                    message:[NSString stringWithFormat:NSLocalizedString(
    @"程序出现了问题，建议您点击退出按钮并重新打开,谢谢", nil)] delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"退出", nil)
                                          otherButtonTitles:nil, nil];
    [alert show];
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    // 通过runLoop 延迟当前线程
    while (!dismissed) {
        for (NSString *mode in (__bridge NSArray *)allModes) {
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
        }
    }
    
    CFRelease(allModes);
    
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    
    if ([[exception name] isEqual:@"UncaughtExceptionHandlerSignalExceptionName"]) {
        kill(getpid(), [[[exception userInfo] objectForKey:@"UncaughtExceptionHandlerSignalKey"] intValue]);
    } else {
        [exception raise];
    }

}

// alertView的点击
- (void)alertView:(UIAlertView *)anAlertView clickedButtonAtIndex:(NSInteger)anIndex {
    if (anIndex == 0) { // 不再阻止线程
        dismissed = YES;
    }
}



@end
