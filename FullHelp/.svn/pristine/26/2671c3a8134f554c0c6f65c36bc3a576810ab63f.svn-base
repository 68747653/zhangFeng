//
//  UserInfo.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AddressInfo;

@interface UserInfo : NSObject

/**
 0：不推送，1：推送
 */
@property (nonatomic, assign) NSInteger userIsPush;

/**
 1：商家 2：供货商
 */
@property (nonatomic, assign) NSInteger userType;

/**
 用户ID
 */
@property (nonatomic, assign) NSInteger userID;

/**
 剩余红包数量 / 总红包数量（收到/发出）
 */
@property (nonatomic, assign) NSInteger userRedNum;

/**
 昵称
 */
@property (nonatomic, copy) NSString *userNickName;

/**
 真实姓名
 */
@property (nonatomic, copy) NSString *userRealName;

/**
 登录名
 */
@property (nonatomic, copy) NSString *userLoginName;

/**
 联系方式
 */
@property (nonatomic, copy) NSString *userTelPhone;

/**
 头像
 */
@property (nonatomic, copy) NSString *userHeadImg;

/**
 省ID
 */
@property (nonatomic, assign) NSInteger userProvinceID;

/**
 省名
 */
@property (nonatomic, copy) NSString *userProvinceName;

/**
 城市ID
 */
@property (nonatomic, assign) NSInteger userCityID;

/**
 城市名
 */
@property (nonatomic, copy) NSString *userCityName;

/**
 县区ID
 */
@property (nonatomic, assign) NSInteger userDistrictID;

/**
 县区名
 */
@property (nonatomic, copy) NSString *userDistrictName;

/**
 行业ID
 */
@property (nonatomic, assign) NSInteger userIndustryID;

/**
 行业名
 */
@property (nonatomic, copy) NSString *userIndustryName;

/**
 余额 / 总红包金额（收到/发出）
 */
@property (nonatomic, assign) CGFloat userFees;

/**
 积分
 */
@property (nonatomic, assign) NSInteger userPoints;

/**
 等级
 */
@property (nonatomic, assign) NSInteger userLevel;

/**
 是否认证【0：否 1：是】
 */
@property (nonatomic, assign) NSInteger userIsCert;

/**
 是否开通红包申请打赏【0：否 1：是】
 */
@property (nonatomic, assign) NSInteger userIsOpenRed;

/**
 现金红包总数
 */
@property (nonatomic, assign) NSInteger userCashRedNum;

/**
 现金红包单个金额
 */
@property (nonatomic, assign) CGFloat userCashAmount;

/**
 生日
 */
@property (nonatomic, copy) NSString *userBirthday;

/**
 店名
 */
@property (nonatomic, copy) NSString *userMerchantName;

/**
 店地址信息
 */
@property (nonatomic, strong) AddressInfo *userMerchantAddressInfo;

@property (nonatomic, strong) NSMutableArray *userArrRedRecord;

@end
