//
//  CustomServicerInfo.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/9.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomServicerInfo : NSObject

/**
 客服ID
 */
@property (nonatomic, assign) NSInteger customID;

/**
 客服名
 */
@property (nonatomic, copy) NSString *customName;

/**
 电话
 */
@property (nonatomic, copy) NSString *customTel;

/**
 地址
 */
@property (nonatomic, copy) NSString *customAddress;

/**
 QQ
 */
@property (nonatomic, copy) NSString *customQQ;

/**
 微信
 */
@property (nonatomic, copy) NSString *customWeChat;

/**
 新浪微博
 */
@property (nonatomic, copy) NSString *customSinaWeiBo;

@end
