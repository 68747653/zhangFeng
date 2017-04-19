//
//  UncaughtExceptionHandler.m
//  FoxHome
//
//  Created by hhsoft on 16/7/18.
//  Copyright © 2016年 zhengzhou. All rights reserved.
//

#import "UncaughtExceptionHandler.h"
#import <UIKit/UIKit.h>


NSString *UncaughtExceptionInfoKey=@"UncaughtExceptionInfo";

NSString* getAppInfo();

void HHSoftUncaughtExceptionHandler(NSException *exception) {
    
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
        //NSString *namess=getAppInfos();
    NSString *url = [NSString stringWithFormat:@"=============异常崩溃报告=============\n%@\nname:\n%@\nreason:\n%@\ncallStackSymbols:\n%@",
                     getAppInfo(),
                     name,reason,[arr componentsJoinedByString:@"\n"]];
    NSLog(@"%@",url);
        //先存储崩溃日志
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:url forKey:UncaughtExceptionInfoKey];
    [defaults synchronize];
}

NSString* getAppInfo(){
    NSString *appInfo = [NSString stringWithFormat:@"App : %@ %@(%@)\nDevice : %@\nOS Version : %@ %@\n",
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"],
                         [UIDevice currentDevice].model,
                         [UIDevice currentDevice].systemName,
                         [UIDevice currentDevice].systemVersion];
    return appInfo;
}

@implementation UncaughtExceptionHandler
+ (void)setDefaultHandler
{
    NSSetUncaughtExceptionHandler (&HHSoftUncaughtExceptionHandler);
}

+ (NSUncaughtExceptionHandler*)getHandler
{
    return NSGetUncaughtExceptionHandler();
}
+ (NSString *)getUncaughtExceptionInfo{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *exceptionInfo=[defaults objectForKey:UncaughtExceptionInfoKey];
    return exceptionInfo;
}
+ (void)handleSuccess{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:UncaughtExceptionInfoKey];
    [defaults synchronize];
}
@end
