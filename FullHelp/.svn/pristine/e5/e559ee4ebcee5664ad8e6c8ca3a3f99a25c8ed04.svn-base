//
//  CheckSoftVersionNetWorkEngine.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/14.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "CheckSoftVersionNetWorkEngine.h"
#import <HHSoftFrameWorkKit/HHSoftJSONKit.h>
#import "SoftVersionInfo.h"
#import "GlobalFile.h"

@implementation CheckSoftVersionNetWorkEngine

/**
 检查版本更新
 
 @param successed 成功
 @param failed    失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)checkSoftVersionInfoSuccessed:(CheckSoftVersionSuccessed)successed failed:(GetDataFailed)failed {
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile uploadSoftVersion] parmarDic:nil method:HttpPost paraMethod:ParaNormal returnValueMethod:ReturnNormal onCompletionHandler:^(NSString *responseString) {
        SoftVersionInfo *softVersionInfo;
        NSInteger code = [self parseCheckSoftVersionInfoWithjsonString:responseString softVersionInfo:&softVersionInfo];
        successed(code, softVersionInfo);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger)parseCheckSoftVersionInfoWithjsonString:(NSString *)jsonStr softVersionInfo:(SoftVersionInfo **)softVersionInfo {
    jsonStr = [jsonStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];//返回的字符串有前面有很多换行符，需要去除一下
    NSDictionary *dictLoginReuslt = [jsonStr objectFromJSONString];
    NSInteger code = -1;
    if ([dictLoginReuslt[@"resultCount"] integerValue]) {
        code = 0;
        SoftVersionInfo  *versionInfo = [[SoftVersionInfo alloc] init];
        NSDictionary *infoDic = [dictLoginReuslt[@"results"] lastObject];
        versionInfo.versionNum = infoDic[@"version"];
        versionInfo.versionUpdateContent = infoDic[@"releaseNotes"];
        *softVersionInfo = versionInfo;
    } else {
        code=1;
    }
    return code;
}

@end
