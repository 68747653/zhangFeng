//
//  AttentionNetWorkEngine.h
//  FullHelp
//
//  Created by hhsoft on 17/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftNetWorkEngine.h>

//我的关注广告列表
typedef void(^GetCollectAdvertListSuccessed)(NSInteger code,NSMutableArray *arrAdvertList);
//我的关注资讯列表
typedef void(^GetCollectNewsListSuccessed)(NSInteger code,NSMutableArray *arrNewsList);
//我的关注需求公示公告列表
typedef void(^GetCollectDemandNoticeListSuccessed)(NSInteger code,NSMutableArray *arrDemandNoticeList);
//我的关注批量删除
typedef void(^DeletaBatchCollectInfoSuccessed)(NSInteger code);

//收藏和取消收藏
typedef void(^AddCollectOrCancleSuccessed)(NSInteger code);

//获取数据失败
typedef void (^GetDataFailed)(NSError *error);

@interface AttentionNetWorkEngine : HHSoftNetWorkEngine

/**
 收藏和取消收藏
 
 @param userID      用户ID
 @param collectType 收藏类型1：需求，公示公告 2：资讯 3：广告
 @param keyID       对应的1：需求，公示公告 2：资讯 3：广告ID
 @param successed   成功
 @param failed      失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)addCollectOrCancelCollectWithUserID:(NSInteger)userID
                                              collectType:(NSInteger)collectType
                                                    keyID:(NSInteger)keyID
                                                successed:(AddCollectOrCancleSuccessed)successed
                                                   failed:(GetDataFailed)failed;

/**
 我的关注广告列表

 @param pageIndex 第几页
 @param pageSize  每页显示几条数据
 @param userID    用户ID
 @param succeed   succeed
 @param failed    failed

 @return value
 */
-(NSURLSessionTask *)getCollectAdvertListWithPageIndex:(NSInteger)pageIndex
                                              PageSize:(NSInteger)pageSize
                                                UserID:(NSInteger)userID
                                               Succeed:(GetCollectAdvertListSuccessed)succeed
                                                Failed:(GetDataFailed)failed;

/**
 我的关注资讯列表
 
 @param pageIndex 第几页
 @param pageSize  每页显示几条数据
 @param userID    用户ID
 @param succeed   succeed
 @param failed    failed
 
 @return value
 */
-(NSURLSessionTask *)getCollectNewsListWithPageIndex:(NSInteger)pageIndex
                                            PageSize:(NSInteger)pageSize
                                              UserID:(NSInteger)userID
                                             Succeed:(GetCollectNewsListSuccessed)succeed
                                              Failed:(GetDataFailed)failed;

/**
 我的关注需求公示公告列表

 @param pageIndex 第几页
 @param pageSize  每页显示几条数据
 @param userID    用户ID
 @param demandNoticeType 类型：1:需求,2:公示公告
 @param succeed   succeed
 @param failed    failed
 
 @return value
 */
-(NSURLSessionTask *)getCollectDemandNoticeListWithPageIndex:(NSInteger)pageIndex
                                                    PageSize:(NSInteger)pageSize
                                                      UserID:(NSInteger)userID
                                            DemandNoticeType:(NSInteger)demandNoticeType
                                                     Succeed:(GetCollectDemandNoticeListSuccessed)succeed
                                                      Failed:(GetDataFailed)failed;

/**
 我的关注批量删除

 @param userID       用户ID
 @param collectIDStr 收藏ID拼接（用逗号分割
 @param succeed   succeed
 @param failed    failed
 
 @return value
 */
-(NSURLSessionTask *)deletaBatchCollectInfoWithUserID:(NSInteger)userID
                                         CollectIDStr:(NSString *)collectIDStr
                                              Succeed:(DeletaBatchCollectInfoSuccessed)succeed
                                               Failed:(GetDataFailed)failed;
@end
