//
//  AdvertInfo.h
//  SuanCai
//
//  Created by hhsoft on 16/8/19.
//  Copyright © 2016年 www.huahansoft.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ImageInfo,AddressInfo,UserInfo;
@interface AdvertInfo : NSObject
/**
 *  广告ID
 */
@property (nonatomic,assign) NSInteger advertID;
/**
 *  广告标题
 */
@property (nonatomic, copy) NSString *advertTitle;
/**
 *  广告类型（ 0：无动作，1：图文广告，2：外部链接 3：现金红包详情 ）//类型（1：现金红包 2：专场红包）
 */
@property (nonatomic,assign) NSInteger advertType;
/**
 *  广告图
 */
@property (nonatomic,copy) NSString *advertImg;

/**
 广告开始时间
 */
@property (nonatomic,copy) NSString *advertBeginTime;

/**
 广告结束时间
 */
@property (nonatomic,copy) NSString *advertEndTime;

/**
 红包赏金
 */
@property (nonatomic, copy) NSString *advertAmount;

/**
 点赞数量
 */
@property (nonatomic, copy) NSString *advertPraiseCount;

/**
 收藏数量
 */
@property (nonatomic, copy) NSString *advertCollectCount;

/**
 已打赏数量
 */
@property (nonatomic, copy) NSString *advertApplyCount;

/**
 已领取人数【专场红包】
 */
@property (nonatomic, copy) NSString *advertSpecialCount;
/**
 商家名称
 */
@property (nonatomic, copy) NSString *merchantName;

/**
 供货商简介URL
 */
@property (nonatomic,copy) NSString *merchantURL;
/**
 等级
 */
@property (nonatomic, copy) NSString *level;

/**
 等级值
 */
@property (nonatomic, assign) NSInteger levelValue;
/**
 是否认证[0:否,1:是]
 */
@property (nonatomic, assign) NSInteger isCert;

/**
 是否开通红包申请打赏
 */
@property (nonatomic, assign) NSInteger isOpenApplyRed;

/**
 是否点赞[0:否,1:是]
 */
@property (nonatomic, assign) NSInteger isPraise;

/**
 是否申请[0:否,1:是]
 */
@property (nonatomic, assign) NSInteger isApply;

/**
 是否领取[0:否,1:是]
 */
@property (nonatomic, assign) NSInteger isReceive;

/**
 是否收藏[0:否,1:是]
 */
@property (nonatomic, assign) NSInteger isCollect;
/**
 总评论数
 */
@property (nonatomic, assign) NSInteger advertCommentCount;

/**
 浏览时长【秒】
 */
@property (nonatomic, assign) NSInteger advertBrowseTime;
/**
 倒计时[小于0的时候显示距离开奖还剩多少时间,等于0是不展示,大于0时显示还剩多少时间结束]
 */
@property (nonatomic, assign) NSInteger countDown;
/**
 广告类型【类型（1：现金红包 2：专场红包）】
 */
@property (nonatomic, assign) NSInteger redAdvertType;
/**
 *  AdvertType=1时，link_url为图文广告详情链接地址；AdvertType=2时，link_url为外部链接地址
 */
@property (nonatomic, copy) NSString *linkUrl;
/**
 *  AdvertType<=0时keyID=0；AdvertType>2时，keyID为相关信息的ID(红包ID等)
 */
@property (nonatomic, assign) NSInteger keyID;

/**
 供应商电话列表
 */
@property (nonatomic,strong) NSMutableArray *arrMerchantTelList;

/**
 评论列表
 */
@property (nonatomic,strong) NSMutableArray *arrCommentList;

/**
 供货商印象列表
 */
@property (nonatomic,strong) NSMutableArray *arrImpressList;

/**
 标签列表
 */
@property (nonatomic,strong) NSMutableArray *arrRedAdvertLabelList;

/**
 广告图集列表
 */
@property (nonatomic,strong) NSMutableArray *arrRedAdvertGalleryList;

/**
 地址
 */
@property (nonatomic,strong) AddressInfo *addressInfo;

/**
 用户信息
 */
@property (nonatomic,strong) UserInfo *userInfo;

@end
