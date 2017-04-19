//
//  DemandInfo.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/8.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AddressInfo;
@interface DemandInfo : NSObject
@property (nonatomic, assign) NSInteger demandID;

/**
 需求/公示公告标题
 */
@property (nonatomic, copy) NSString *demandName;

/**
 需求/公示公告内容
 */
@property (nonatomic, copy) NSString *demandContent;

/**
 地址信息
 */
@property (nonatomic, strong) AddressInfo *addressInfo;

/**
 添加时间
 */
@property (nonatomic, copy) NSString *addTime;

/**
 联系电话
 */
@property (nonatomic, copy) NSString *demandTel;

/**
 图片数组
 */
@property (nonatomic, strong) NSMutableArray *arrImg;
@end
