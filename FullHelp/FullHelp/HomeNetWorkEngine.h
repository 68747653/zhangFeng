//
//  HomeNetWorkEngine.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftNetWorkEngine.h>

@class HomeInfo, NewsInfo, ImageInfo;

//获取启动页
typedef void(^GetStartPageImageSuccessed)(NSInteger code,ImageInfo *imageInfo);

/**
 获取首页数据
 */
typedef void (^GetHomeDataSuccessed)(NSInteger code, HomeInfo *homeInfo);

/**
 获取资讯列表
 */
typedef void (^GetNewsListSuccessed)(NSInteger code, NSMutableArray *arrNewsClass, NSMutableArray *arrTopNews, NSMutableArray *arrNews);

/**
 获取资讯详情
 */
typedef void (^GetNewsInfoSuccessed)(NSInteger code, NewsInfo *newsInfo);

/**
 获取数据失败
 */
typedef void (^GetDataFailed)(NSError *error);

@interface HomeNetWorkEngine : HHSoftNetWorkEngine

/**
 获取启动页
 
 @param type       启动页类型【0：android ，1：IOS5 2 ：iOS 6/7 ，3：iOS 6plus/7plus
 @param successed  successed
 @param failed     failed
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getStartPageImageWithType:(NSInteger)type
                                       successed:(GetStartPageImageSuccessed)successed
                                        failed:(GetDataFailed)failed;

/**
 首页

 @param userID 用户ID
 @param industryID 行业ID
 */
- (NSURLSessionTask *)getHomeDataWithUserID:(NSInteger)userID
                                 industryID:(NSInteger)industryID
                                  successed:(GetHomeDataSuccessed)successed
                                     failed:(GetDataFailed)failed;

/**
 获取资讯列表
 
 @param newsClassID    资讯类别ID
 @param pageIndex      页数
 @param pageSize       每页条数
 @param successed      成功
 @param failed         失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getNewsListWithNewsClassID:(NSInteger)newsClassID
                                       pageIndex:(NSInteger)pageIndex
                                        pageSize:(NSInteger)pageSize
                                       successed:(GetNewsListSuccessed)successed
                                          failed:(GetDataFailed)failed;

/**
 获取资讯详情
 
 @param userID    用户ID
 @param newsID    资讯ID
 @param infoID    消息ID 推送获取详情时传消息ID，其他传0
 @param successed 成功
 @param failed    失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getNewsInfoWithUserID:(NSInteger)userID
                                     newsID:(NSInteger)newsID
                                     infoID:(NSInteger)infoID
                                  successed:(GetNewsInfoSuccessed)successed
                                     failed:(GetDataFailed)failed;

@end
