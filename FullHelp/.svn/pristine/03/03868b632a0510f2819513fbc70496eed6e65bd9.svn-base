//
//  CheckSoftVersionNetWorkEngine.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/14.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftNetWorkEngine.h>

@class SoftVersionInfo;

//检查版本更新
typedef void(^CheckSoftVersionSuccessed)(NSInteger code, SoftVersionInfo *softVersionInfo);

typedef void(^GetDataFailed)(NSError *responseError);

@interface CheckSoftVersionNetWorkEngine : HHSoftNetWorkEngine

/**
 检查版本更新

 @param successed 成功
 @param failed    失败

 @return NSURLSessionTask
 */
- (NSURLSessionTask *)checkSoftVersionInfoSuccessed:(CheckSoftVersionSuccessed)successed failed:(GetDataFailed)failed;

@end
