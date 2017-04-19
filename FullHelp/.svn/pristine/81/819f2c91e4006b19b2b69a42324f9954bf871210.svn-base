//
//  WKWebViewController.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftBaseViewController.h>

typedef NS_ENUM(NSInteger,WKWebType) {
    WKWebTypeWithAdvertType     ,//广告
    WKWebTypeWithMessage        ,//消息
    WKWebTypeWithAboutOur       ,//关于我们
    WKWebTypeWithRegist       ,//注册协议
    WKWebTypeWithHelp       ,//使用帮助
    WKWebTypeWithLevel       ,//等级规则
};

typedef void(^GetMessageDetailSuccessed)(NSInteger messageID);

@interface WKWebViewController : HHSoftBaseViewController
/*
 *  广告展示的URl，直接展示
 */
-(instancetype)initWithUrl:(NSString *)url WkWebType:(WKWebType)wkWebType MessageTitle:(NSString *)messageTitle;

/*
 *  系统消息根据ID获取消息详情
 */
-(instancetype)initWithMessageID:(NSInteger)messageID WkWebType:(WKWebType)wkWebType MessageTitle:(NSString *)messageTitle successed:(GetMessageDetailSuccessed)successed;

@end
