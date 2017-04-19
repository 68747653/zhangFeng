//
//  RedPacketInfo.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserInfo;
@interface RedPacketInfo : NSObject

/**
 红包id
 */
@property (nonatomic, assign) NSInteger redPacketID;

/**
 红包广告id
 */
@property (nonatomic, assign) NSInteger redPacketAdvertID;
/**
 红包类别名称
 */
@property (nonatomic, copy) NSString *redPacketClassName;

/**
 红包标题
 */
@property (nonatomic, copy) NSString *redPacketTitle;
/**
 红包类别图片
 */
@property (nonatomic, copy) NSString *redPacketImg;

/**
 红包金额
 */
@property (nonatomic, copy) NSString *redPacketAmount;

/**
 附加信息
 */
@property (nonatomic, copy) NSString *redPacketMemo;

/**
 红包发送者信息
 */
@property (nonatomic, strong) UserInfo *sendUserInfo;

/**
 距离开始时间还有多少秒
 */
@property (nonatomic, assign) NSInteger startTime;

/**
 红包总数
 */
@property (nonatomic, assign) NSInteger redPacketCount;

/**
 发出红包数量
 */
@property (nonatomic, assign) NSInteger sendCount;

/**
 状态 0：未开始或疯抢中，1：已结束， 2：已领取 ，3：已抢光 4：未开始
 */
@property (nonatomic, assign) NSInteger state;

@end
