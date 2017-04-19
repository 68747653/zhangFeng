//
//  AttentionNetWorkEngine.m
//  FullHelp
//
//  Created by hhsoft on 17/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AttentionNetWorkEngine.h"
#import <HHSoftFrameWorkKit/HHSoftJSONKit.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftEncode.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "UserInfo.h"
#import "AttentionInfo.h"
#import "AdvertInfo.h"
#import "NewsInfo.h"
#import "DemandNoticeInfo.h"

@implementation AttentionNetWorkEngine

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
                                                   failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      [@(collectType) stringValue], @"collect_type",
                                      [@(keyID) stringValue], @"key_id", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile addCollectOrCancelCollectUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self parseDeletaBatchCollectInfoWithJsonStr:responseString];
        //100：收藏成功，101：收藏失败，102：参数错误，103：取消收藏成功，104：取消收藏失败，100001：网络接连异常
        successed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
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
                                                Failed:(GetDataFailed)failed{
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(pageIndex) stringValue],@"page",
                                     [@(pageSize) stringValue],@"page_size",
                                     [@(userID) stringValue],@"user_id",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getCollectAdvertList] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrAdvertList = [[NSMutableArray alloc] init];
        NSInteger code=[self getetCollectAdvertListWithjsonString:responseString arrAdvertList:&arrAdvertList];
        succeed(code,arrAdvertList);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
-(NSInteger)getetCollectAdvertListWithjsonString:(NSString *)jsonStr arrAdvertList:(NSMutableArray **)arrAdvertList{
    NSDictionary *dictReuslt = [jsonStr objectFromJSONString];
    NSInteger code = [[dictReuslt objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSArray *arrResult = [dictReuslt objectForKey:@"result"];
        for (NSDictionary *dictAttention in arrResult) {
            AttentionInfo *attentionInfo = [[AttentionInfo alloc] init];
            attentionInfo.attentionID = [[[dictAttention objectForKey:@"collect_id"] base64DecodedString] integerValue];
            attentionInfo.advertInfo.advertID = [[[dictAttention objectForKey:@"red_advert_id"] base64DecodedString] integerValue];
            attentionInfo.advertInfo.advertPraiseCount = [[dictAttention objectForKey:@"praise_count"] base64DecodedString];
            attentionInfo.advertInfo.advertCollectCount = [[dictAttention objectForKey:@"collect_count"] base64DecodedString];
            attentionInfo.advertInfo.advertImg = [[dictAttention objectForKey:@"thumb_img"] base64DecodedString];
            attentionInfo.advertInfo.merchantName = [[dictAttention objectForKey:@"merchant_name"] base64DecodedString];
            [*arrAdvertList addObject:attentionInfo];
        }
    }
    return code;
}
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
                                              Failed:(GetDataFailed)failed{
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(pageIndex) stringValue],@"page",
                                     [@(pageSize) stringValue],@"page_size",
                                     [@(userID) stringValue],@"user_id",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getCollectNewsList] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrNewsList = [[NSMutableArray alloc] init];
        NSInteger code=[self getetCollectNewsListWithjsonString:responseString arrNewsList:&arrNewsList];
        succeed(code,arrNewsList);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
-(NSInteger)getetCollectNewsListWithjsonString:(NSString *)jsonStr arrNewsList:(NSMutableArray **)arrNewsList{
    NSDictionary *dictReuslt = [jsonStr objectFromJSONString];
    NSInteger code = [[dictReuslt objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSArray *arrResult = [dictReuslt objectForKey:@"result"];
        for (NSDictionary *dictAttention in arrResult) {
            AttentionInfo *attentionInfo = [[AttentionInfo alloc] init];
            attentionInfo.attentionID = [[[dictAttention objectForKey:@"collect_id"] base64DecodedString] integerValue];
            attentionInfo.newsInfo.newsID = [[[dictAttention objectForKey:@"news_id"] base64DecodedString] integerValue];
            attentionInfo.newsInfo.newsType = [[[dictAttention objectForKey:@"news_type"] base64DecodedString] integerValue];
            attentionInfo.newsInfo.newsPublishTime = [[dictAttention objectForKey:@"publish_time"] base64DecodedString];
            attentionInfo.newsInfo.newsVisitCount = [[[dictAttention objectForKey:@"visit_count"] base64DecodedString] integerValue];
            attentionInfo.newsInfo.newsCollectCount = [[[dictAttention objectForKey:@"collect_count"] base64DecodedString] integerValue];
            attentionInfo.newsInfo.newsImage = [[dictAttention objectForKey:@"thumb_img"] base64DecodedString];
            attentionInfo.newsInfo.newsTitle = [[dictAttention objectForKey:@"news_title"] base64DecodedString];
            [*arrNewsList addObject:attentionInfo];
        }
    }
    return code;
}
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
                                                      Failed:(GetDataFailed)failed{
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(pageIndex) stringValue],@"page",
                                     [@(pageSize) stringValue],@"page_size",
                                     [@(userID) stringValue],@"user_id",
                                     [@(demandNoticeType) stringValue],@"demand_notice_type",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getCollectDemandNoticeList] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrDemandNoticeList = [[NSMutableArray alloc] init];
        NSInteger code=[self getetCollectDemandNoticeListWithjsonString:responseString arrDemandNoticeList:&arrDemandNoticeList];
        succeed(code,arrDemandNoticeList);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
-(NSInteger)getetCollectDemandNoticeListWithjsonString:(NSString *)jsonStr arrDemandNoticeList:(NSMutableArray **)arrDemandNoticeList{
    NSDictionary *dictReuslt = [jsonStr objectFromJSONString];
    NSInteger code = [[dictReuslt objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSArray *arrResult = [dictReuslt objectForKey:@"result"];
        for (NSDictionary *dictAttention in arrResult) {
            AttentionInfo *attentionInfo = [[AttentionInfo alloc] init];
            attentionInfo.attentionID = [[[dictAttention objectForKey:@"collect_id"] base64DecodedString] integerValue];
            attentionInfo.demandNoticeInfo.demandNoticeID = [[[dictAttention objectForKey:@"demand_notice_id"] base64DecodedString] integerValue];
            attentionInfo.demandNoticeInfo.demandNoticeCollectCount = [[[dictAttention objectForKey:@"collect_count"] base64DecodedString] integerValue];
            attentionInfo.demandNoticeInfo.demandNoticeAddTime = [[dictAttention objectForKey:@"add_time"] base64DecodedString];
            attentionInfo.demandNoticeInfo.demandNoticeThumbImg = [[dictAttention objectForKey:@"thumb_img"] base64DecodedString];
            attentionInfo.demandNoticeInfo.demandNoticeName = [[dictAttention objectForKey:@"demand_notice_name"] base64DecodedString];
            [*arrDemandNoticeList addObject:attentionInfo];
        }
    }
    return code;
}
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
                                               Failed:(GetDataFailed)failed{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      collectIDStr, @"collect_id_str",nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile deleteBatchCollectInfo] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self parseDeletaBatchCollectInfoWithJsonStr:responseString];
        succeed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger)parseDeletaBatchCollectInfoWithJsonStr:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    return code;
}

@end
