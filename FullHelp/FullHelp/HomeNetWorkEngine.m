//
//  HomeNetWorkEngine.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "HomeNetWorkEngine.h"
#import "HomeInfo.h"
#import "GlobalFile.h"
#import <HHSoftFrameWorkKit/HHSoftJSONKit.h>
#import "NewsInfo.h"
#import <HHSoftFrameWorkKit/NSString+HHSoftEncode.h>
#import "ImageInfo.h"
#import "UserInfo.h"
#import "IndustryInfo.h"
#import "AdvertInfo.h"
#import "RedPacketInfo.h"
#import "ActivityInfo.h"
#import "NewsInfo.h"
#import "ImageInfo.h"

@implementation HomeNetWorkEngine

/**
 获取启动页
 
 @param type       启动页类型【0：android ，1：IOS5 2 ：iOS 6/7 ，3：iOS 6plus/7plus
 @param successed  successed
 @param failed     failed
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getStartPageImageWithType:(NSInteger)type
                                      successed:(GetStartPageImageSuccessed)successed
                                         failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(type) stringValue], @"type", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getStartPageImage] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        ImageInfo *imageInfo;
        NSInteger code = [self parseGetStartPageImageResultToImageInfoModel:&imageInfo jsonStr:responseString];
        successed(code, imageInfo);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger)parseGetStartPageImageResultToImageInfoModel:(ImageInfo **)imageInfoModel jsonStr:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSDictionary *resultDict = jsonDict[@"result"];
        
        ImageInfo *imageInfo = [[ImageInfo alloc]init];
        imageInfo.imageID = [[resultDict[@"id"] base64DecodedString] integerValue];
        imageInfo.imageBig = [resultDict[@"big_img"] base64DecodedString];
        imageInfo.imageSource = [resultDict[@"source_img"] base64DecodedString];
        
        *imageInfoModel = imageInfo;
    }
    return code;
}

/**
 首页
 
 @param userID 用户ID
 @param industryID 行业ID
 */
- (NSURLSessionTask *)getHomeDataWithUserID:(NSInteger)userID
                                 industryID:(NSInteger)industryID
                                  successed:(GetHomeDataSuccessed)successed
                                     failed:(GetDataFailed)failed {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    [@(userID) stringValue],@"user_id",
                                    [@(industryID) stringValue],@"industry_id",
                                    nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getHomeInfo] parmarDic:postDic method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        HomeInfo *homeInfo;
        NSInteger code = [self getHomeDataWithJsonStr:responseString homeInfo:&homeInfo];
        successed(code,homeInfo);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger ) getHomeDataWithJsonStr:(NSString *)json homeInfo:(HomeInfo **)hHomeInfo{
    NSDictionary *dictJson=[json objectFromJSONString];
    NSInteger code = [[dictJson objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSDictionary *dicResult = dictJson[@"result"];
        HomeInfo *homeInfo = [[HomeInfo alloc] init];
        
        //行业信息
        NSDictionary *dicIndustry = dicResult[@"dustry_info"];
        IndustryInfo *industryInfo = [[IndustryInfo alloc] init];
        industryInfo.industryID = [[dicIndustry[@"industry_id"]base64DecodedString]integerValue];
        industryInfo.industryName = [dicIndustry[@"industry_name"]base64DecodedString];
        homeInfo.industryInfo = industryInfo;
        
        
        //顶部广告
        NSArray *arrTopAdvert = dicResult[@"advert_list"];
        for (NSDictionary *dic in arrTopAdvert) {
            AdvertInfo *advertInfo = [[AdvertInfo alloc] init];
            advertInfo.advertID = [[dic[@"advert_id"]base64DecodedString]integerValue];
            advertInfo.advertTitle = [dic[@"advert_title"]base64DecodedString];
            advertInfo.advertImg = [dic[@"big_img"]base64DecodedString];
            advertInfo.advertType = [[dic[@"advert_type"]base64DecodedString]integerValue];
            advertInfo.keyID = [[dic[@"key_id"]base64DecodedString]integerValue];
            advertInfo.linkUrl = [dic[@"link_url"]base64DecodedString];
            [homeInfo.arrAdvert addObject:advertInfo];
        }
        //红包类别
        NSArray *arrRedPacketClass = dicResult[@"red_class_list"];
        for (NSDictionary *dic in arrRedPacketClass) {
            RedPacketInfo *redPacketInfo = [[RedPacketInfo alloc] init];
            redPacketInfo.redPacketID = [[dic[@"red_class_id"]base64DecodedString]integerValue];
            redPacketInfo.redPacketClassName = [dic[@"red_class_name"]base64DecodedString];
            redPacketInfo.redPacketImg = [dic[@"class_img"]base64DecodedString];
            [homeInfo.arrRedClass addObject:redPacketInfo];
        }
        //新闻
        NSArray *arrNews = dicResult[@"news_list"];
        for (NSDictionary *dic in arrNews) {
            NewsInfo *newsInfo = [[NewsInfo alloc] init];
            newsInfo.newsID = [[dic[@"news_id"]base64DecodedString] integerValue];
            newsInfo.newsType = [[dic[@"news_id"]base64DecodedString] integerValue];
            newsInfo.newsTitle = [dic[@"news_title"]base64DecodedString];
            newsInfo.newsLinkUrl = [dic[@"link_url"]base64DecodedString];
            [homeInfo.arrNews addObject:newsInfo];
        }
        
        //活动
        NSArray *arrActivity = dicResult[@"activity_photo_list"];
        for (NSDictionary *dic in arrActivity) {
            ActivityInfo *activityInfo = [[ActivityInfo alloc] init];
            activityInfo.activityID = [[dic[@"activity_photo_id"]base64DecodedString] integerValue];
            activityInfo.activityType = [[dic[@"activity_photo_type"]base64DecodedString] integerValue];
            activityInfo.countDown = [[dic[@"count_down"]base64DecodedString] integerValue];
            activityInfo.activityTitle = [dic[@"activity_photo_title"]base64DecodedString];
            activityInfo.activityImg = [dic[@"big_img"]base64DecodedString];
            [homeInfo.arrActivity addObject:activityInfo];
        }
        //红包广告
        NSArray *arrRedAdvert = dicResult[@"red_advert_list"];
        NSMutableArray *tempArray = nil;
        for (NSInteger i=0; i<arrRedAdvert.count; i++) {
            NSDictionary *dic = arrRedAdvert[i];
            AdvertInfo *advertInfo = [[AdvertInfo alloc] init];
            advertInfo.advertID = [[dic[@"red_advert_id"]base64DecodedString]integerValue];
            advertInfo.advertTitle = [dic[@"red_advert_title"]base64DecodedString];
            advertInfo.advertImg = [dic[@"index_big_img"]base64DecodedString];
            advertInfo.advertAmount = [dic[@"apply_red_amount"]base64DecodedString];
            advertInfo.advertPraiseCount = [dic[@"count_praise"]base64DecodedString];
            advertInfo.advertCollectCount = [dic[@"count_collect"]base64DecodedString];
            advertInfo.advertApplyCount = [dic[@"count_apply_red"]base64DecodedString];
            advertInfo.merchantName = [dic[@"merchant_name"]base64DecodedString];
            advertInfo.level = [dic[@"level_value"]base64DecodedString];
            advertInfo.isCert = [[dic[@"is_cert"]base64DecodedString]boolValue];
            advertInfo.redAdvertType = [[dic[@"red_advert_type"]base64DecodedString]integerValue];
            
            if (i%5==2) {
                tempArray = [NSMutableArray array];
                [tempArray addObject:advertInfo];
            }
            else if (i%5==3) {
                [tempArray addObject:advertInfo];
                [homeInfo.arrRedAdvert addObject:tempArray];
            }
            else {
                [homeInfo.arrRedAdvert addObject:advertInfo];
            }
        }
    
        *hHomeInfo = homeInfo;
    }
    return code;
}

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
                                          failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(newsClassID) stringValue], @"news_class_id",
                                      [@(pageIndex) stringValue], @"page",
                                      [@(pageSize) stringValue], @"page_size", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getNewsListUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrNewsClass = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arrTopNews = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arrNews = [NSMutableArray arrayWithCapacity:0];
        NSInteger code = [self parseGetNewsListResultToArrNewsClass:&arrNewsClass arrTopNews:&arrTopNews arrNews:&arrNews jsonStr:responseString];
        successed(code, arrNewsClass, arrTopNews, arrNews);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger)parseGetNewsListResultToArrNewsClass:(NSMutableArray **)arrNewsClassList arrTopNews:(NSMutableArray **)arrTopNewsList arrNews:(NSMutableArray **)arrNewsList jsonStr:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSDictionary *resultDict = jsonDict[@"result"];
        
        NSArray *arrNewsClass = resultDict[@"news_class_list"];
        if (arrNewsClass.count) {
            for (NSDictionary *dict in arrNewsClass) {
                NewsInfo *newsInfo = [[NewsInfo alloc] init];
                newsInfo.newsClassID = [[dict[@"news_class_id"] base64DecodedString] integerValue];
                newsInfo.newsClassName = [dict[@"news_class_name"] base64DecodedString];
                [*arrNewsClassList addObject:newsInfo];
            }
        }
        
        NSArray *arrTopNews = resultDict[@"top_news_list"];
        if (arrTopNews.count) {
            for (NSDictionary *dict in arrTopNews) {
                NewsInfo *newsInfo = [[NewsInfo alloc] init];
                newsInfo.newsID = [[dict[@"news_id"] base64DecodedString] integerValue];
                newsInfo.newsType = [[dict[@"news_type"] base64DecodedString] integerValue];
                newsInfo.newsImageInfo.imageBig = [dict[@"big_img"] base64DecodedString];
                [*arrTopNewsList addObject:newsInfo];
            }
        }
        
        NSArray *arrNews = resultDict[@"news_list"];
        if (arrNews.count) {
            for (NSDictionary *dict in arrNews) {
                NewsInfo *newsInfo = [[NewsInfo alloc] init];
                newsInfo.newsID = [[dict[@"news_id"] base64DecodedString] integerValue];
                newsInfo.newsCollectCount = [[dict[@"collect_count"] base64DecodedString] integerValue];
                newsInfo.newsVisitCount = [[dict[@"visit_count"] base64DecodedString] integerValue];
                newsInfo.newsImageInfo.imageThumb = [dict[@"thumb_img"] base64DecodedString];
                newsInfo.newsPublishTime = [dict[@"publish_time"] base64DecodedString];
                newsInfo.newsTitle = [dict[@"news_title"] base64DecodedString];
                newsInfo.newsType = [[dict[@"news_type"] base64DecodedString] integerValue];
                [*arrNewsList addObject:newsInfo];
            }
        }
    }
    return code;
}

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
                                     failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      [@(newsID) stringValue], @"news_id",
                                      [@(infoID) stringValue], @"info_id", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getNewsInfoUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NewsInfo *newsInfo;
        NSInteger code = [self parseGetNewsInfoResultToNewsInfoModel:&newsInfo jsonStr:responseString];
        successed(code, newsInfo);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger)parseGetNewsInfoResultToNewsInfoModel:(NewsInfo **)newsInfoModel jsonStr:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSDictionary *resultDict = jsonDict[@"result"];
        
        NewsInfo *newsInfo = [[NewsInfo alloc] init];
        newsInfo.newsID = [[resultDict[@"news_id"] base64DecodedString] integerValue];
        newsInfo.newsType = [[resultDict[@"news_type"] base64DecodedString] integerValue];
        newsInfo.newsPublishTime = [resultDict[@"publish_time"] base64DecodedString];
        newsInfo.newsContent = [resultDict[@"news_content"] base64DecodedString];
        newsInfo.newsLinkUrl = [resultDict[@"link_url"] base64DecodedString];
        newsInfo.newsIsCollect = [[resultDict[@"is_collect"] base64DecodedString] integerValue];
        
        NSArray *arrNewsImg = resultDict[@"news_gallery_list"];
        if (arrNewsImg.count) {
            for (NSDictionary *dict in arrNewsImg) {
                ImageInfo *imageInfo = [[ImageInfo alloc] init];
                imageInfo.imageID = [[dict[@"news_gallery_id"] base64DecodedString] integerValue];
                imageInfo.imageSource = [dict[@"source_img"] base64DecodedString];
                imageInfo.imageBig = [dict[@"big_img"] base64DecodedString];
                imageInfo.imageThumb = [dict[@"thumb_img"] base64DecodedString];
                imageInfo.imageDesc = [dict[@"img_desc"] base64DecodedString];
                [newsInfo.newsArrImageInfo addObject:newsInfo];
            }
        }
        
        *newsInfoModel = newsInfo;
    }
    return code;
}

@end
