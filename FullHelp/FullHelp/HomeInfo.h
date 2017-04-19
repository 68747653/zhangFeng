//
//  HomeInfo.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IndustryInfo;
@interface HomeInfo : NSObject

/**
 广告
 */
@property (nonatomic, strong) NSMutableArray *arrAdvert;

/**
 红包类别
 */
@property (nonatomic, strong) NSMutableArray *arrRedClass;

/**
 新闻类别
 */
@property (nonatomic, strong) NSMutableArray *arrNews;

/**
 活动
 */
@property (nonatomic, strong) NSMutableArray *arrActivity;

/**
 红包广告
 */
@property (nonatomic, strong) NSMutableArray *arrRedAdvert;

/**
 行业信息
 */
@property (nonatomic, strong) IndustryInfo *industryInfo;

@end
