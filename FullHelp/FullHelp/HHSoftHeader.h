//
//  HHSoftHeader.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#ifndef HHSoftHeader_h
#define HHSoftHeader_h
//是否重新打开app
static NSString *IsOpenAgin = @"IsOpenAgin";
//删除首页毛玻璃效果
static NSString *RemoveEffectViewNotification = @"RemoveEffectViewNotification";
//选择行业通知
static NSString *ChooseIndustryInfoNotification = @"ChooseIndustryInfoNotification";
//发布需求成功通知
static NSString *PublishDemandNotification = @"PublishDemandNotification";
//领取今日红包通知
static NSString *GetTodayRedpacketNotification = @"GetTodayRedpacketNotification";
//领取专场红包通知
static NSString *GetSpecialRedpacketNotification = @"GetSpecialRedpacketNotification";
//领取游戏红包通知
static NSString *GetGameRedpacketNotification = @"GetGameRedpacketNotification";
//地区和行业列表
typedef NS_ENUM(NSInteger, ViewType) {
    RegisterType,       //注册
    LinkUsType,         //联系我们
    BackHomeType,         //首页
};
//需求类型
typedef NS_ENUM(NSInteger ,NeedsType) {
    NeedsTypeMerchant =1,//商家需求
    NeedsTypeSupplier =2,//供货商需求
};
/**
 *  百度地图key
 */
static NSString *BaiduMapKey = @"nDmdetOcjR2FKweo7fHZ6cvP76plQLlP";

//获取启动页
#define HHHomeImageCachePath  [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"HomeImageCache"]

/**
 支付成功回调通知
 */
static NSString *PaySuccessHandNotification = @"PaySuccessHandNotification";
/**
 支付成功
 */
static NSString *PaySuccessNotification = @"PaySuccessNotification";

#endif /* HHSoftHeader_h */
