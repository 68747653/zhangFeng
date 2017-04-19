//
//  NewsInfo.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ImageInfo;

@interface NewsInfo : NSObject

/**
 资讯ID
 */
@property (nonatomic, assign) NSInteger newsID;

/**
 新闻类型【1：视频、2：图文, 3：图片新闻，4：外部链接】
 */
@property (nonatomic, assign) NSInteger newsType;

/**
 资讯标题
 */
@property (nonatomic, copy) NSString *newsTitle;

/**
 发布时间（几分钟前）
 */
@property (nonatomic, copy) NSString *newsPublishTime;

/**
 浏览数量
 */
@property (nonatomic, assign) NSInteger newsVisitCount;

/**
 收藏数量
 */
@property (nonatomic, assign) NSInteger newsCollectCount;

/**
 缩略图
 */
@property (nonatomic, copy) NSString *newsImage;

/**
 链接
 */
@property (nonatomic, copy) NSString *newsLinkUrl;

/**
 是否收藏1：收藏0未收藏
 */
@property (nonatomic, assign) NSInteger newsIsCollect;

/**
 资讯内容
 */
@property (nonatomic, copy) NSString *newsContent;

/**
 资讯类别ID
 */
@property (nonatomic, assign) NSInteger newsClassID;

/**
 资讯类别
 */
@property (nonatomic, copy) NSString *newsClassName;

/**
 资讯图集
 */
@property (nonatomic, strong) ImageInfo *newsImageInfo;

/**
 资讯图集
 */
@property (nonatomic, strong) NSMutableArray *newsArrImageInfo;

@end
