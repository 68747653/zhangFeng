//
//  AccountChangeInfo.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AccountChangeInfo : NSObject

/**
 变动id
 */
@property (nonatomic, assign) NSInteger accountChangeID;

/**
 变动金额
 */
@property (nonatomic, assign) CGFloat accountChangeAmount;

/**
 当前余额
 */
@property (nonatomic, assign) CGFloat accountChangeFees;

/**
 变动标题
 */
@property (nonatomic, copy) NSString *accountChangeTitle;

/**
 变动类型【0：支出 1：收入】 充值类型【1支付宝，2：微信,3:充值卡】
 */
@property (nonatomic, assign) NSInteger accountChangeType;

/**
 变动简介
 */
@property (nonatomic, copy) NSString *accountChangeDesc;

/**
 添加时间
 */
@property (nonatomic, copy) NSString *accountChangeTime;

@end
