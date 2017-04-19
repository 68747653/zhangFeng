//
//  WithdrawalViewModel.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AccountInfo;

@interface WithdrawalViewModel : NSObject

/**
 用户余额，可提现金额
 */
@property(nonatomic, assign) CGFloat userFees;

/**
 提现手续费百分比[要除以100]
 */
@property(nonatomic, assign) CGFloat userRate;

/**
 用户电话
 */
@property(nonatomic, copy) NSString *userPhone;

/**
 是否设置提现密码【0：否，1;是】
 */
@property (nonatomic, assign) NSInteger isSetPayPassword;

@property(nonatomic, strong) AccountInfo *accountInfo;

@end
