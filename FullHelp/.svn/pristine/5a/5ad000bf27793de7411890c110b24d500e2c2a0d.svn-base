//
//  UncaughtExceptionNetEngine.m
//  FoxHome
//
//  Created by hhsoft on 16/7/20.
//  Copyright © 2016年 zhengzhou. All rights reserved.
//

#import "UncaughtExceptionNetEngine.h"
#import "UncaughtExceptionHandler.h"
#import <HHSoftFrameWorkKit/HHSoftNetWorkEngine.h>
#import <HHSoftFrameWorkKit/HHSoftJSONKit.h>

NSString *const url=@"http://bbs.huahansoft.com/projectbugadd";
NSString *const hostName=@"bbs.huahansoft.com";
NSString *const urlPath=@"/projectbugadd";


@interface UncaughtExceptionNetEngine ()
/**
 *  发送崩溃日志
 */
-(void)sendUncaughtExceptionInfoWithError:(NSString *)error projectID:(NSInteger)projectID;

@end

@implementation UncaughtExceptionNetEngine

+(void)openSendBugToServiceWithProjectID:(NSInteger)projectID{
    [UncaughtExceptionHandler setDefaultHandler];
    NSString *errorInfo=[UncaughtExceptionHandler getUncaughtExceptionInfo];
    if (errorInfo) {
            //send
        [[[UncaughtExceptionNetEngine alloc] init] sendUncaughtExceptionInfoWithError:errorInfo projectID:projectID];
    }
}
-(void)sendUncaughtExceptionInfoWithError:(NSString *)error projectID:(NSInteger)projectID{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(projectID) stringValue], @"project_id",
                                      [UIDevice currentDevice].systemName, @"phone_makers",
                                      [[UIDevice currentDevice].model stringByAppendingString:[UIDevice currentDevice].systemVersion], @"phone_model",
                                      error, @"error", nil];
    [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:url parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSDictionary *dictJson=[responseString objectFromJSONString];
        NSInteger code = [[dictJson objectForKey:@"code"] integerValue];
        if (code==100) {
            [UncaughtExceptionHandler handleSuccess];
        }
    } onFailHandler:^(NSError *responseError) {
    }];
}
@end
