//
//  RedPacketAdvertNetWorkEngine.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftNetWorkEngine.h>
@class AdvertInfo,CommentInfo;
@class DemandNoticeInfo;
/**
 热门项目推荐
 */
typedef void (^GetHotRedPacketListSuccessed)(NSInteger code,NSMutableArray *arrTopAdvert,NSMutableArray *arrData);
/**
 热门项目推荐
 */
typedef void (^GetGrabRedPacketListSuccessed)(NSInteger code,NSInteger endSecond,NSMutableArray *arrData);
/**
 现金红包和最新活动列表
 */
typedef void (^OpenRedPacketSuccessed)(NSInteger code,NSString *amount);
/**
 现金红包和最新活动列表
 */
typedef void (^GetNewRedPacketListSuccessed)(NSInteger code,NSMutableArray *arrData);
/**
 红包广告详情
 */
typedef void (^GetRedPacketAdvertInfoSuccessed)(NSInteger code,AdvertInfo *advertInfoModel);
/**
 发布需求公示公告信息
 */
typedef void (^PublishDemandSuccessed)(NSInteger code,NSString *demandID,NSString *weekCount,NSString *leaveCount);
/**
 获取需求和公示公告详情
 */
typedef void (^GetDemandInfoSuccessed)(NSInteger code,DemandNoticeInfo *demandInfo);
/**
 获取code
 */
typedef void (^GetCodeSuccessed)(NSInteger code);
/**
 印象点评
 */
typedef void (^AddImpressCommentInfoSuccessed)(NSInteger code);
/**
 评价列表
 */
typedef void (^GetCommentListSuccessed)(NSInteger code,NSMutableArray *arrData);
/**
 点赞和取消点赞
 */
typedef void (^AddPraiseInfoSuccessed)(NSInteger code);
/**
 拆专场红包
 */
typedef void (^OpenRedAdvertInfoSuccessed)(NSInteger code,NSString *redAmount);
/**
 申请红包打赏
 */
typedef void (^AddApplyRedInfoSuccessed)(NSInteger code);
/**
 添加评论
 */
typedef void (^AddCommentInfoSuccessed)(NSInteger code,CommentInfo *commentInfoModel);
/**
 电话咨询
 */
typedef void (^AddConsultRecordInfoSuccessed)(NSInteger code,NSInteger isRedRecord);
/**
 拆电话红包
 */
typedef void (^OpenTelRedAdvertInfoSuccessed)(NSInteger code,NSString *redAmount);

/**
 预报红包
 */
typedef void (^GetPredictRedListSuccessed)(NSInteger code, NSMutableArray *arrActivityTime, NSMutableArray *arrActivityRed);

/**
 验证红包口令
 */
typedef void (^CheckPassword)(NSInteger code,NSInteger packetID);

/**
 获取数据失败
 */
typedef void (^GetDataFailed)(NSError *error);

@interface RedPacketAdvertNetWorkEngine : HHSoftNetWorkEngine
    /**
     编辑需求
     @param demandType 发布类型1：需求 2：公示公告
     @param deleteImgIDs 删除图集图片的ID拼接的字符串（用逗号分隔）
     @param demandInfo 需求信息
     */
- (NSURLSessionTask *)editDemandWithUserID:(NSInteger)userID
                                demandType:(NSInteger)demandType
                              deleteImgIDs:(NSString *)deleteImgIDs
                                demandInfo:(DemandNoticeInfo *)demandInfo
                                 successed:(GetCodeSuccessed)successed
                                    failed:(GetDataFailed)failed;
    /**
     获取场景红包列表
     
     @param industryID 行业ID
     */
- (NSURLSessionTask *)getSceneRedPacketListWithIndustryID:(NSInteger)industryID
                                                     page:(NSInteger)page
                                                 pageSize:(NSInteger)pageSize
                                                successed:(GetNewRedPacketListSuccessed)successed
                                                   failed:(GetDataFailed)failed;
    /**
     拆场景红包
     
     @param userID      用户ID
     @param redAdvertID 红包广告ID
     @param succeed     succeed
     @param failed      failed
     
     @return value
     */
-(NSURLSessionTask *)openSceneRedAdvertInfoWithUserID:(NSInteger)userID
                                          RedAdvertID:(NSInteger)redAdvertID
                                              Succeed:(OpenRedAdvertInfoSuccessed)succeed
                                               Failed:(GetDataFailed)failed;
/**
 验证口令

 @param userID 登录用户ID
 @param password 口令红包的口令
 */
-(NSURLSessionTask *)checkPasswordWithUserID:(NSInteger)userID
                                    password:(NSString *)password
                                     Succeed:(CheckPassword)succeed
                                      Failed:(GetDataFailed)failed;
    
/**
 拆游戏红包
 
 @param userID      用户ID
 @param redAdvertID 红包广告ID
 @param succeed     succeed
 @param failed      failed
 
 @return value
 */
-(NSURLSessionTask *)openGameRedAdvertInfoWithUserID:(NSInteger)userID
                                         RedAdvertID:(NSInteger)redAdvertID
                                             Succeed:(OpenRedAdvertInfoSuccessed)succeed
                                              Failed:(GetDataFailed)failed;


/**
 预报红包列表

 @param industryID 行业ID
 @param page       页数
 @param pageSize   每页条数
 @param time       活动时间：首次进入页面是传空，进入页面之后传时间
 @param successed  成功
 @param failed     失败

 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getPredictRedPacketListWithIndustryID:(NSInteger)industryID
                                                       page:(NSInteger)page
                                                   pageSize:(NSInteger)pageSize
                                                       time:(NSString *)time
                                                  successed:(GetPredictRedListSuccessed)successed
                                                     failed:(GetDataFailed)failed;
    

/**
 专场红包列表
 @param industryID 行业ID
 */
- (NSURLSessionTask *)getGameListWithIndustryID:(NSInteger)industryID
                                         userID:(NSInteger)userID
                                           page:(NSInteger)page
                                       pageSize:(NSInteger)pageSize
                                      successed:(GetNewRedPacketListSuccessed)successed
                                         failed:(GetDataFailed)failed;
/**
 专场红包列表
 
 @param industryID 行业ID
 @param userID  	userID
 */
- (NSURLSessionTask *)getSpecialRedPacketListWithIndustryID:(NSInteger)industryID
                                                     userID:(NSInteger)userID
                                                       page:(NSInteger)page
                                                   pageSize:(NSInteger)pageSize
                                                  successed:(GetNewRedPacketListSuccessed)successed
                                                     failed:(GetDataFailed)failed;
    
/**
 拆今日红包
 
 @param userID      用户ID
 @param redAdvertID 红包广告ID
 @param succeed     succeed
 @param failed      failed
 
 @return value
 */
-(NSURLSessionTask *)openTodayInfoWithUserID:(NSInteger)userID
                                 RedAdvertID:(NSInteger)redAdvertID
                                     Succeed:(OpenRedAdvertInfoSuccessed)succeed
                                      Failed:(GetDataFailed)failed;
/**
 今日红包列表
 
 @param industryID 行业ID
 @param userID userID
 */
- (NSURLSessionTask *)getTodayListWithIndustryID:(NSInteger)industryID
                                          userID:(NSInteger)userID
                                            page:(NSInteger)page
                                        pageSize:(NSInteger)pageSize
                                       successed:(GetNewRedPacketListSuccessed)successed
                                          failed:(GetDataFailed)failed;

/**
 拆需求红包
 */
- (NSURLSessionTask *)openNeedsRedPacketWithUserID:(NSInteger )userID
                                          demandID:(NSInteger)demandID
                                    successed:(OpenRedPacketSuccessed)successed
                                       failed:(GetDataFailed)failed;
/**
 获取需求/公示公告列表

 @param industryID 行业ID
 @param demandType  	类型1:需求 2:公示公告
 */
- (NSURLSessionTask *)getDemadListWithIndustryID:(NSInteger)industryID
                                      demandType:(NSInteger)demandType
                                                   page:(NSInteger)page
                                               pageSize:(NSInteger)pageSize
                                              successed:(GetNewRedPacketListSuccessed)successed
                                                 failed:(GetDataFailed)failed;
/**
 获取需求和公示公告详情
 @param userID 登录用户ID
 @param demandID 需求/公示公告ID
 */
- (NSURLSessionTask *)getDemandInfoWithUserID:(NSInteger)userID
                                   demandID:(NSInteger)demandID
                                    successed:(GetDemandInfoSuccessed)successed
                                       failed:(GetDataFailed)failed;
/**
 发布需求
 @param demandType 发布类型1：需求 2：公示公告
 @param demandInfo 需求信息
 */
- (NSURLSessionTask *)publishDemandWithUserID:(NSInteger)userID
                                   demandType:(NSInteger)demandType
                                   demandInfo:(DemandNoticeInfo *)demandInfo
                                    successed:(PublishDemandSuccessed)successed
                                       failed:(GetDataFailed)failed;


/**
 热门项目推荐
 @param industryID 行业ID
 */
- (NSURLSessionTask *)getHotRedPacketAdvertListWithIndustryID:(NSInteger)industryID
                                           page:(NSInteger)page
                                       pageSize:(NSInteger)pageSize
                                  successed:(GetHotRedPacketListSuccessed)successed
                                     failed:(GetDataFailed)failed;
/**
 限时抢购列表
 */
- (NSURLSessionTask *)getGrabRedPacketListWithIndustryID:(NSInteger)industryID
                                                    page:(NSInteger)page
                                                pageSize:(NSInteger)pageSize
                                               successed:(GetGrabRedPacketListSuccessed)successed
                                                  failed:(GetDataFailed)failed;

/**
 现金红包和最新活动列表

 @param industryID 行业ID
 @param mark 0：最新活动，1：现金红包
 @param keyWords  	搜索条件
 */
- (NSURLSessionTask *)getNewRedPacketListWithIndustryID:(NSInteger)industryID
                                                    page:(NSInteger)page
                                                pageSize:(NSInteger)pageSize
                                                    mark:(NSInteger)mark
                                               keyWordds:(NSString *)keyWords
                                               successed:(GetNewRedPacketListSuccessed)successed
                                                  failed:(GetDataFailed)failed;

/**
 红包广告详情

 @param redAdvertID 红包ID
 @param userID      用户ID
 @param succeed     succeed
 @param failed      failed

 @return value
 */
-(NSURLSessionTask *)getRedPacketAdvertInfoWithRedAdvertID:(NSInteger)redAdvertID
                                                    UserID:(NSInteger)userID
                                                   Succeed:(GetRedPacketAdvertInfoSuccessed)succeed
                                                    Failed:(GetDataFailed)failed;

/**
 拆红包
 */
- (NSURLSessionTask *)openRedPacketWithUserID:(NSInteger )userID
                                        successed:(OpenRedPacketSuccessed)successed
                                           failed:(GetDataFailed)failed;

/**
 供货商印象点评

 @param userID    登录用户ID
 @param impressID 印象ID
 @param succeed     succeed
 @param failed      failed
 
 @return value
 */
-(NSURLSessionTask *)addImpressCommentInfoWithUserID:(NSInteger )userID
                                           ImpressID:(NSInteger)impressID
                                             Succeed:(AddImpressCommentInfoSuccessed)succeed
                                              Failed:(GetDataFailed)failed;

/**
 评价列表

 @param pageIndex      第几页
 @param pageSize       每页显示几条数据
 @param merchantUserID 供货商ID
 @param succeed     succeed
 @param failed      failed
 
 @return value
 */
-(NSURLSessionTask *)getCommentListWithPageIndex:(NSInteger)pageIndex
                                        PageSize:(NSInteger)pageSize
                                  MerchantUserID:(NSInteger)merchantUserID
                                         Succeed:(GetCommentListSuccessed)succeed
                                          Failed:(GetDataFailed)failed;

/**
 点赞和取消点赞

 @param userID      用户ID
 @param redAdvertID 红包广告ID
 @param succeed     succeed
 @param failed      failed
 
 @return value
 */
-(NSURLSessionTask *)addPraiseAndCancelPraiseInfoWithUserID:(NSInteger)userID
                                                redAdvertID:(NSInteger)redAdvertID
                                                    Succeed:(AddPraiseInfoSuccessed)succeed
                                                     Failed:(GetDataFailed)failed;

/**
 拆专场红包

 @param userID      用户ID
 @param redAdvertID 红包广告ID
 @param succeed     succeed
 @param failed      failed
 
 @return value
 */
-(NSURLSessionTask *)openRedAdvertInfoWithUserID:(NSInteger)userID
                                     RedAdvertID:(NSInteger)redAdvertID
                                         Succeed:(OpenRedAdvertInfoSuccessed)succeed
                                          Failed:(GetDataFailed)failed;

/**
 申请红包打赏

 @param userID      用户ID
 @param redAdvertID 红包广告ID
 @param succeed     succeed
 @param failed      failed
 
 @return value
 */
-(NSURLSessionTask *)addApplyRedInfoWithUserID:(NSInteger)userID
                                   RedAdvertID:(NSInteger)redAdvertID
                                       Succeed:(AddApplyRedInfoSuccessed)succeed
                                        Failed:(GetDataFailed)failed;

/**
 添加评论

 @param userID         用户ID
 @param merchantUserID 供货商ID
 @param commentScore   评分
 @param commentContent 评论内容
 @param filePath       图片
 @param succeed     succeed
 @param failed      failed
 
 @return value
 */
-(NSURLSessionTask *)addCommentInfoWithUserID:(NSInteger)userID
                               MerchantUserID:(NSInteger)merchantUserID
                                 CommentScore:(CGFloat)commentScore
                               CommentContent:(NSString *)commentContent
                                     FilePath:(NSMutableArray *)filePath
                                      Succeed:(AddCommentInfoSuccessed)succeed
                                       Failed:(GetDataFailed)failed;

/**
 电话咨询

 @param userID         用户ID
 @param redAdvertID    红包广告ID
 @param browseTime     浏览时长
 @param telPhone       供货商电话
 @param succeed     succeed
 @param failed      failed
 
 @return value
 */
-(NSURLSessionTask *)addConsultRecordInfoWithUserID:(NSInteger)userID
                                        RedAdvertID:(NSInteger)redAdvertID
                                         BrowseTime:(NSInteger)browseTime
                                           TelPhone:(NSString *)telPhone
                                            Succeed:(AddConsultRecordInfoSuccessed)succeed
                                             Failed:(GetDataFailed)failed;

/**
 领取电话红包

 @param userID         用户ID
 @param redAdvertID    红包广告ID
 @param browseTime     浏览时长
 @param succeed     succeed
 @param failed      failed
 
 @return value
 */
-(NSURLSessionTask *)openTelRedAdvertInfoWithUserID:(NSInteger)userID
                                        RedAdvertID:(NSInteger)redAdvertID
                                         BrowseTime:(NSInteger)browseTime
                                            Succeed:(OpenTelRedAdvertInfoSuccessed)succeed
                                             Failed:(GetDataFailed)failed;
@end
