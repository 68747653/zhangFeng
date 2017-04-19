//
//  DemandNoticeInfo.h
//  FullHelp
//
//  Created by hhsoft on 17/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class AddressInfo;
@class UserInfo;
@interface DemandNoticeInfo : NSObject

/**
 需求公示公告ID
 */
@property (nonatomic,assign) NSInteger demandNoticeID;

/**
 时间
 */
@property (nonatomic,copy) NSString *demandNoticeAddTime;

/**
 缩略图
 */
@property (nonatomic,copy) NSString *demandNoticeThumbImg;

/**
 需求/公示公告名称
 */
@property (nonatomic,copy) NSString *demandNoticeName;
@property (nonatomic, strong) UIFont *nameFont;
@property (nonatomic, assign) CGSize nameSize;

/**
 收藏数量
 */
@property (nonatomic,assign) NSInteger demandNoticeCollectCount;

/**
 需求/公示公告内容
 */
@property (nonatomic, copy) NSString *demandContent;
@property (nonatomic, strong) UIFont *contentFont;
@property (nonatomic, assign) CGSize contentSize;


/**
 地址信息
 */
@property (nonatomic, strong) AddressInfo *addressInfo;
/**
 是否收藏
 */
@property (nonatomic, assign) BOOL isCollect;
/**
 发布和编辑使用的数组
 */
@property (nonatomic, strong) NSMutableArray *arrImg;

/**
 详情展示的图片数组
 */
@property (nonatomic, strong) NSMutableArray *arrShowImg;
@property (nonatomic, strong) UserInfo *userInfo;
@end
