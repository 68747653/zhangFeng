//
//  RuleInfo.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/9.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RuleInfo : NSObject

/**
 规则ID
 */
@property (nonatomic, assign) NSInteger ruleID;

/**
 规则名
 */
@property (nonatomic, copy) NSString *ruleName;

/**
 积分
 */
@property (nonatomic, assign) NSInteger rulePoints;

@end
