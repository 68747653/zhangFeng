//
//  PayHelper.h
//  HHChat
//
//  Created by hhsoft on 16/6/24.
//  Copyright © 2016年 luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

typedef NS_ENUM(NSInteger, PayWayType) {//接口需要，不可以更改
    PayWayTypeNone      =-1,//无
    PayWayTypeAliPay    =1,//支付宝
    PayWayTypeWXPay     =2,//微信
};

@interface PayHelper : NSObject
    //处理支付宝支付的结果
+(void)handParsePay:(NSURL *)url type:(PayWayType)type application:(UIApplication *)application;
//微信支付成功后的处理
+(void)wxPaySuccessWithOnResp:(BaseResp *)resp;
@end
