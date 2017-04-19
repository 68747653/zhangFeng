//
//  RewardInfo.h
//  FullHelp
//
//  Created by hhsoft on 17/2/13.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class UserInfo;

@interface RewardInfo : NSObject

/**
 用户信息
 */
@property (nonatomic,strong) UserInfo *userInfo;

/**
 打赏id
 */
@property (nonatomic,assign) NSInteger rewardID;

/**
 红包广告id
 */
@property (nonatomic,assign) NSInteger rewardRedAdvertID;

/**
 打赏金额
 */
@property (nonatomic,assign) CGFloat rewardAmount;

/**
 状态（1：已申请 2：已同意 3：已拒绝）
 */
@property (nonatomic,assign) NSInteger rewardState;

/**
 打赏时间
 */
@property (nonatomic,copy) NSString *rewardAddTime;

/**
 状态string
 */
@property (nonatomic,copy) NSString *rewardStateStr;

/**
 未通过原因
 */
@property (nonatomic,copy) NSString *rewardNoPassReason;

@end
