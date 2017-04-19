//
//  AttentionInfo.h
//  FullHelp
//
//  Created by hhsoft on 17/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AdvertInfo,NewsInfo,DemandNoticeInfo;
@interface AttentionInfo : NSObject

/**
 收藏ID
 */
@property (nonatomic,assign) NSInteger attentionID;

/**
 广告
 */
@property (nonatomic,strong) AdvertInfo *advertInfo;

/**
 资讯
 */
@property (nonatomic,strong) NewsInfo *newsInfo;

/**
 需求/公示公告
 */
@property (nonatomic,strong) DemandNoticeInfo *demandNoticeInfo;

@end
