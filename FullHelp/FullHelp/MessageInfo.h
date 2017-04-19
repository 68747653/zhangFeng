//
//  MessageInfo.h
//  FullHelp
//
//  Created by hhsoft on 17/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageInfo : NSObject
/**
 *  详情地址
 */
@property (nonatomic,copy) NSString *messageInfoURL;
/**
 *  时间
 */
@property (nonatomic,copy) NSString *messageAddTime;
/**
 *  内容
 */
@property (nonatomic,copy) NSString *messageContent;
/**
 *  标题
 */
@property (nonatomic,copy) NSString *messageTitle;
/**
 *  类型 0：系统 1：新闻  2:组图新闻  3：视频新闻  4：打赏申请推送
 */
@property (nonatomic,assign) NSInteger messageType;

/**
 消息类型string
 */
@property (nonatomic,copy) NSString *messageTypeStr;
/**
 *  信息ID
 */
@property (nonatomic,assign) NSInteger messageID;
/**
 *  唯一标示ID
 */
@property (nonatomic,assign) NSInteger messageLogoID;

/**
 *  0:未处理 1：已推送 2：已读
 */
@property (nonatomic,assign) NSInteger messageState;
@end
