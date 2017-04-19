//
//  RedPacketAdvertNetWorkEngine.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "RedPacketAdvertNetWorkEngine.h"
#import "GlobalFile.h"
#import <HHSoftFrameWorkKit/HHSoftJSONKit.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftEncode.h>
#import "UserInfo.h"
#import "AdvertInfo.h"
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "AddressInfo.h"
#import "ImageInfo.h"
#import "RedPacketAdvertLabelInfo.h"
#import "ImpressInfo.h"
#import "CommentInfo.h"
#import "MerchantInfo.h"
#import "AddressInfo.h"
#import "DemandNoticeInfo.h"
#import "AddressInfo.h"
#import <HHSoftFrameWorkKit/HHSoftUploadImageInfo.h>
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import "RedPacketInfo.h"
#import "ActivityTimeInfo.h"
#import "GameInfo.h"

@implementation RedPacketAdvertNetWorkEngine
/**
 验证口令
 
 @param userID 登录用户ID
 @param password 口令红包的口令
 */
-(NSURLSessionTask *)checkPasswordWithUserID:(NSInteger)userID
                                    password:(NSString *)password
                                     Succeed:(CheckPassword)succeed
                                        Failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue],@"user_id",
                                      password,@"red_password",
                                      nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile checkPassword] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger redPacketID;
        NSInteger code = [self getCodeWithJsonStr:responseString redPacketID:&redPacketID];
        succeed(code,redPacketID);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger ) getCodeWithJsonStr:(NSString *)json redPacketID:(NSInteger *)redPacketID{
    NSDictionary *dictJson=[json objectFromJSONString];
    NSInteger code = [[dictJson objectForKey:@"code"] integerValue];
    if (code==100) {
        NSDictionary *dic = dictJson[@"result"];
        *redPacketID = [[dic[@"password_red_id"] base64DecodedString] integerValue];
    }
    return code;
}
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
                                                     failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(page) stringValue], @"page",
                                     [@(pageSize) stringValue], @"page_size",
                                     [@(industryID) stringValue], @"industry_id",
                                     time, @"activity_time", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getPredictRedListUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrActivityTime = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arrActivityRed = [NSMutableArray arrayWithCapacity:0];
        NSInteger code = [self parseGetPredictRedListResultToArrActivityTime:&arrActivityTime arrActivityRed:&arrActivityRed jsonStr:responseString];
        successed(code, arrActivityTime, arrActivityRed);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger)parseGetPredictRedListResultToArrActivityTime:(NSMutableArray **)arrActivityTime arrActivityRed:(NSMutableArray **)arrActivityRed jsonStr:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSDictionary *resultDict = jsonDict[@"result"];
        
        NSArray *arrTime = resultDict[@"activity_time_list"];
        if (arrTime.count) {
            for (NSDictionary *dict in arrTime) {
                ActivityTimeInfo *activityTimeInfo = [[ActivityTimeInfo alloc] init];
                activityTimeInfo.activityTimeID = [[dict[@"activity_time_id"] base64DecodedString] integerValue];
                activityTimeInfo.activityTime = [dict[@"activity_time"] base64DecodedString];
                
                [*arrActivityTime addObject:activityTimeInfo];
            }
        }
        
        NSArray *arrRed = resultDict[@"predict_red_list"];
        if (arrRed.count) {
            for (NSDictionary *dict in arrRed) {
                RedPacketInfo *redPacketInfo = [[RedPacketInfo alloc] init];
                redPacketInfo.redPacketID = [[dict[@"predict_red_id"] base64DecodedString] integerValue];
                redPacketInfo.redPacketCount = [[dict[@"red_num"] base64DecodedString] integerValue];
                redPacketInfo.redPacketAmount = [dict[@"total_red_amount"] base64DecodedString];
                redPacketInfo.redPacketMemo = [dict[@"activity_time"] base64DecodedString];
                redPacketInfo.sendUserInfo.userMerchantName = [dict[@"supplier_name"] base64DecodedString];
                
                [*arrActivityRed addObject:redPacketInfo];
            }
        }

    }
    return code;
}

/**
 游戏红包列表
 @param industryID 行业ID
 */
- (NSURLSessionTask *)getGameListWithIndustryID:(NSInteger)industryID
                                         userID:(NSInteger)userID
                                           page:(NSInteger)page
                                       pageSize:(NSInteger)pageSize
                                      successed:(GetNewRedPacketListSuccessed)successed
                                         failed:(GetDataFailed)failed {
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(page) stringValue],@"page",
                                     [@(pageSize) stringValue],@"page_size",
                                     [@(industryID) stringValue],@"industry_id",
                                     [@(userID) stringValue],@"user_id",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getGameList] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrData = [NSMutableArray array];
        NSInteger code = [self getGameListWithJsonStr:responseString arrData:&arrData];
        successed(code, arrData);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger ) getGameListWithJsonStr:(NSString *)json arrData:(NSMutableArray **)arrData{
    NSDictionary *dictJson=[json objectFromJSONString];
    NSInteger code = [[dictJson objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        NSMutableArray *arrResult = [dictJson objectForKey:@"result"];
        for (NSDictionary *dic in arrResult) {
            GameInfo *gameInfo = [[GameInfo alloc] init];
            gameInfo.gameID = [[dic[@"game_id"]base64DecodedString]integerValue];
            gameInfo.gameRedID = [[dic[@"game_red_id"]base64DecodedString]integerValue];
            gameInfo.gameBrowseTime = [[dic[@"browse_time"]base64DecodedString]integerValue];
            gameInfo.advertID = [[dic[@"red_advert_id"]base64DecodedString]integerValue];
            gameInfo.gameName = [dic[@"game_name"]base64DecodedString];
            gameInfo.gameUrl = [dic[@"game_url"]base64DecodedString];
            gameInfo.gameThumImg = [dic[@"thumb_img"]base64DecodedString];
            gameInfo.advertImg = [dic[@"big_img"]base64DecodedString];
            gameInfo.userInfo.userMerchantName = [dic[@"merchant_name"]base64DecodedString];
            gameInfo.userInfo.userHeadImg = [dic[@"head_image"]base64DecodedString];
            gameInfo.isReceive = [[dic[@"is_receive"]base64DecodedString]boolValue];
            [mutableArray addObject:gameInfo];
        }
        *arrData = mutableArray;
    }
    return code;
}
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
                                          failed:(GetDataFailed)failed {
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(page) stringValue],@"page",
                                     [@(pageSize) stringValue],@"page_size",
                                     [@(industryID) stringValue],@"industry_id",
                                     [@(userID) stringValue],@"user_id",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getSpecialRedPacketList] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrData = [NSMutableArray array];
        NSInteger code = [self getSpecialRedPacketListWithJsonStr:responseString arrData:&arrData];
        successed(code, arrData);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger ) getSpecialRedPacketListWithJsonStr:(NSString *)json arrData:(NSMutableArray **)arrData{
    NSDictionary *dictJson=[json objectFromJSONString];
    NSInteger code = [[dictJson objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        NSMutableArray *arrResult = [dictJson objectForKey:@"result"];
        for (NSDictionary *dic in arrResult) {
            RedPacketInfo *redPacketInfo = [[RedPacketInfo alloc] init];
            redPacketInfo.redPacketID = [[dic[@"red_advert_id"]base64DecodedString]integerValue];
            redPacketInfo.redPacketTitle = [dic[@"red_advert_title"]base64DecodedString];
            redPacketInfo.redPacketImg = [dic[@"big_img"]base64DecodedString];
            redPacketInfo.state = [[dic[@"state"]base64DecodedString]integerValue];
            redPacketInfo.redPacketCount = [[dic[@"special_red_num"]base64DecodedString]integerValue];
            redPacketInfo.sendCount = [[dic[@"special_send_red_num"]base64DecodedString]integerValue];
            redPacketInfo.startTime = [[dic[@"start_time"]base64DecodedString]integerValue];
            redPacketInfo.sendUserInfo.userIsCert = [[dic[@"is_cert"]base64DecodedString] boolValue];
            redPacketInfo.sendUserInfo.userLevel = [[dic[@"level"]base64DecodedString]integerValue];
            redPacketInfo.sendUserInfo.userHeadImg = [dic[@"head_image"]base64DecodedString];
            redPacketInfo.sendUserInfo.userNickName = [dic[@"merchant_name"]base64DecodedString];;
            redPacketInfo.redPacketMemo = @"专场红包";
            [mutableArray addObject:redPacketInfo];
        }
        *arrData = mutableArray;
    }
    return code;
}
/**
 今日红包列表
 
 @param industryID 行业ID
 @param userID  	userID
 */
- (NSURLSessionTask *)getTodayListWithIndustryID:(NSInteger)industryID
                                          userID:(NSInteger)userID
                                            page:(NSInteger)page
                                        pageSize:(NSInteger)pageSize
                                       successed:(GetNewRedPacketListSuccessed)successed
                                          failed:(GetDataFailed)failed {
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(page) stringValue],@"page",
                                     [@(pageSize) stringValue],@"page_size",
                                     [@(industryID) stringValue],@"industry_id",
                                     [@(userID) stringValue],@"user_id",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getTodayList] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrData = [NSMutableArray array];
        NSInteger code = [self getTodayListWithJsonStr:responseString arrData:&arrData];
        successed(code, arrData);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger ) getTodayListWithJsonStr:(NSString *)json arrData:(NSMutableArray **)arrData{
    NSDictionary *dictJson=[json objectFromJSONString];
    NSInteger code = [[dictJson objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        NSMutableArray *arrResult = [dictJson objectForKey:@"result"];
        for (NSDictionary *dic in arrResult) {
            RedPacketInfo *redPacketInfo = [[RedPacketInfo alloc] init];
            redPacketInfo.redPacketID = [[dic[@"today_red_id"]base64DecodedString]integerValue];
            redPacketInfo.redPacketAdvertID = [[dic[@"red_advert_id"]base64DecodedString]integerValue];
            redPacketInfo.state = [[dic[@"state"]base64DecodedString]integerValue];
            redPacketInfo.redPacketCount = [[dic[@"red_num"]base64DecodedString]integerValue];
            redPacketInfo.sendCount = [[dic[@"send_red_num"]base64DecodedString]integerValue];
            redPacketInfo.startTime = [[dic[@"distance_start_time"]base64DecodedString]integerValue];
            redPacketInfo.redPacketTitle = [dic[@"today_red_title"]base64DecodedString];
            redPacketInfo.redPacketImg = [dic[@"big_img"]base64DecodedString];
            redPacketInfo.sendUserInfo.userHeadImg = @"Icon.png";
            redPacketInfo.sendUserInfo.userNickName = [HHSoftAppInfo AppName];
            redPacketInfo.redPacketMemo = @"今日红包";
            [mutableArray addObject:redPacketInfo];
        }
        *arrData = mutableArray;
    }
    return code;
}
    /**
     获取场景红包列表
     
     @param industryID 行业ID
     */
- (NSURLSessionTask *)getSceneRedPacketListWithIndustryID:(NSInteger)industryID
                                            page:(NSInteger)page
                                        pageSize:(NSInteger)pageSize
                                       successed:(GetNewRedPacketListSuccessed)successed
                                          failed:(GetDataFailed)failed {
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(page) stringValue],@"page",
                                     [@(pageSize) stringValue],@"page_size",
                                     [@(industryID) stringValue],@"industry_id",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getSceneRedPacketList] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrData = [NSMutableArray array];
        NSInteger code = [self getSceneListWithJsonStr:responseString arrData:&arrData];
        successed(code, arrData);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger ) getSceneListWithJsonStr:(NSString *)json arrData:(NSMutableArray **)hArrData{
    NSDictionary *dictJson=[json objectFromJSONString];
    NSInteger code = [[dictJson objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        NSMutableArray *arrResult = [dictJson objectForKey:@"result"];
        for (NSDictionary *dic in arrResult) {
            AdvertInfo *advertInfo = [[AdvertInfo alloc] init];
            advertInfo.advertID = [[dic[@"red_advert_id"]base64DecodedString] integerValue];
            advertInfo.advertImg = [dic[@"big_img"]base64DecodedString];
            advertInfo.advertTitle = [dic[@"password_red_title"]base64DecodedString];
            [mutableArray addObject:advertInfo];
        }
        *hArrData = mutableArray;
    }
    return code;
}
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
                                          failed:(GetDataFailed)failed {
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(page) stringValue],@"page",
                                     [@(pageSize) stringValue],@"page_size",
                                     [@(industryID) stringValue],@"industry_id",
                                     [@(demandType) stringValue],@"demand_notice_type",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getDemandList] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrData = [NSMutableArray array];
        NSInteger code = [self getDemandListWithJsonStr:responseString arrData:&arrData];
        successed(code, arrData);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger ) getDemandListWithJsonStr:(NSString *)json arrData:(NSMutableArray **)arrData{
    NSDictionary *dictJson=[json objectFromJSONString];
    NSInteger code = [[dictJson objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        NSMutableArray *arrResult = [dictJson objectForKey:@"result"];
        for (NSDictionary *dic in arrResult) {
            DemandNoticeInfo *demandInfo = [[DemandNoticeInfo alloc] init];
            demandInfo.demandNoticeID = [[dic[@"demand_notice_id"]base64DecodedString]integerValue];
            demandInfo.demandNoticeName = [dic[@"demand_notice_name"]base64DecodedString];
            demandInfo.demandNoticeThumbImg = [dic[@"thumb_img"]base64DecodedString];
            demandInfo.demandNoticeAddTime = [dic[@"add_time"]base64DecodedString];
            demandInfo.userInfo.userID = [[dic[@"user_id"]base64DecodedString]integerValue];
            demandInfo.userInfo.userMerchantName = [dic[@"merchnat_name"]base64DecodedString];
            demandInfo.demandNoticeCollectCount = [[dic[@"total_collect"]base64DecodedString]integerValue];
            [mutableArray addObject:demandInfo];
    
        }
        *arrData = mutableArray;
    }
    return code;
}
/**
 获取需求和公示公告详情
 @param userID 登录用户ID
 @param demandID 需求/公示公告ID
 */
- (NSURLSessionTask *)getDemandInfoWithUserID:(NSInteger)userID
                                     demandID:(NSInteger)demandID
                                    successed:(GetDemandInfoSuccessed)successed
                                       failed:(GetDataFailed)failed {
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(userID) stringValue],@"user_id",
                                     [@(demandID) stringValue],@"demand_notice_id",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getDemandInfo] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        DemandNoticeInfo *demandInfo;
        NSInteger code = [self getDemandInfoWithJsonStr:responseString demandInfo:&demandInfo];
        successed(code,demandInfo);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger ) getDemandInfoWithJsonStr:(NSString *)json demandInfo:(DemandNoticeInfo **)hDemandInfo{
    NSDictionary *dictJson=[json objectFromJSONString];
    NSInteger code = [[dictJson objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSDictionary *dic = [dictJson objectForKey:@"result"];
        DemandNoticeInfo *demandInfo = [[DemandNoticeInfo alloc] init];
        demandInfo.demandNoticeID = [[dic[@"demand_notice_id"]base64DecodedString]integerValue];
        demandInfo.demandNoticeName = [dic[@"demand_notice_name"]base64DecodedString];
        demandInfo.nameFont = [UIFont systemFontOfSize:16];
        demandInfo.nameSize = [demandInfo.demandNoticeName boundingRectWithfont:demandInfo.nameFont maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-30, 1000)];
        
        
        demandInfo.demandContent = [dic[@"demand_notice_content"]base64DecodedString];
        demandInfo.contentFont = [UIFont systemFontOfSize:15];
        demandInfo.contentSize = [demandInfo.demandContent boundingRectWithfont:demandInfo.contentFont maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-30, 1000)];
        demandInfo.addressInfo.addressDetail = [dic[@"address_detail"]base64DecodedString];
        demandInfo.addressInfo.addressHouseNumber = [dic[@"house_number"]base64DecodedString];
        demandInfo.addressInfo.addressFont = [UIFont systemFontOfSize:14];
        NSString *address = [NSString stringWithFormat:@"%@%@",demandInfo.addressInfo.addressDetail,demandInfo.addressInfo.addressHouseNumber];
        demandInfo.addressInfo.address = address;
        demandInfo.addressInfo.addressSize = [address boundingRectWithfont:demandInfo.addressInfo.addressFont maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-40, 1000)];
        
        demandInfo.addressInfo.addressLatitude = [[dic[@"latitude"]base64DecodedString]floatValue];
        demandInfo.addressInfo.addressLongitude = [[dic[@"longitude"]base64DecodedString]floatValue];
        demandInfo.demandNoticeAddTime = [dic[@"add_time"]base64DecodedString];
        demandInfo.userInfo.userID = [[dic[@"user_id"]base64DecodedString]integerValue];
        demandInfo.userInfo.userMerchantName = [dic[@"merchant_name"]base64DecodedString];
        demandInfo.userInfo.userTelPhone = [dic[@"demand_notice_tel"]base64DecodedString];
        demandInfo.isCollect = [[dic[@"is_collect"]base64DecodedString] boolValue];
        NSArray *arrImg = dic[@"demand_notice_gallery"];
        
        for (NSDictionary *dic in arrImg) {
            ImageInfo *imageInfo = [[ImageInfo alloc] init];
            imageInfo.imageID = [dic[@"demand_notice_gallery_id"]base64DecodedString].integerValue;
            imageInfo.imageThumb = [dic[@"thumb_img"]base64DecodedString];
            imageInfo.imageBig = [dic[@"big_img"]base64DecodedString];
            NSRange range1 = [imageInfo.imageBig rangeOfString:@"_"];
            NSString *str1 = [imageInfo.imageBig substringFromIndex:range1.location+1];
            NSRange range2 = [str1 rangeOfString:@"." options:NSBackwardsSearch];
            NSString *str2 = [str1 substringToIndex:range2.location];
            NSRange range3 = [str2 rangeOfString:@"x"];
            CGFloat imgWidth = [[str2 substringToIndex:range3.location] floatValue];
            CGFloat imgHeight = [[str2 substringFromIndex:range3.location+1] floatValue];
            CGFloat ratio = imgWidth/imgHeight;
            CGFloat showImgWidth = [HHSoftAppInfo AppScreen].width-20;
            imgWidth = [HHSoftAppInfo AppScreen].width-20;
            imgHeight = showImgWidth/ratio;
            imageInfo.imageWidth = imgWidth;
            imageInfo.imageHeight = imgHeight;
            [demandInfo.arrShowImg addObject:imageInfo];
        }
        
        for (NSDictionary *dic in arrImg) {
            HHSoftUploadImageInfo *imageInfo = [[HHSoftUploadImageInfo alloc] init];
            imageInfo.uploadImageID = [[dic[@"demand_notice_gallery_id"]base64DecodedString]integerValue];
            imageInfo.compressImageFilePath = [dic[@"thumb_img"]base64DecodedString];
            imageInfo.sourceImageFilePath = [dic[@"big_img"]base64DecodedString];
            imageInfo.isWebImage = YES;
            [demandInfo.arrImg addObject:imageInfo];
        }
        *hDemandInfo = demandInfo;
    }
    return code;
}
- (NSInteger ) getCodeWithJsonStr:(NSString *)json {
    NSDictionary *dictJson=[json objectFromJSONString];
    NSInteger code = [[dictJson objectForKey:@"code"] integerValue];
    return code;
}
/**
 发布需求
 @param demandType 发布类型1：需求 2：公示公告
 @param demandInfo 需求信息
 */
- (NSURLSessionTask *)publishDemandWithUserID:(NSInteger)userID
                                   demandType:(NSInteger)demandType
                                   demandInfo:(DemandNoticeInfo *)demandInfo
                                    successed:(PublishDemandSuccessed)successed
                                       failed:(GetDataFailed)failed {
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(userID) stringValue],@"user_id",
                                     [@(demandType) stringValue],@"demand_notice_type",
                                     demandInfo.demandNoticeName,@"demand_notice_name",
                                     demandInfo.demandContent,@"demand_notice_content",
                                     demandInfo.addressInfo.addressDetail,@"address_detail",
                                     demandInfo.addressInfo.addressHouseNumber,@"house_number",
                                     [@(demandInfo.addressInfo.addressLatitude) stringValue],@"latitude",
                                     [@(demandInfo.addressInfo.addressLongitude) stringValue],@"longitude",
                                     [NSString stringByReplaceNullString:demandInfo.userInfo.userTelPhone],@"demand_notice_tel",
                                     nil];
    NSURLSessionTask *op =  [[HHSoftNetWorkEngine sharedHHNetWorkEngine] uploadBatchFileWithPath:[GlobalFile publishDemand] filePathArray:demandInfo.arrImg parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson key:@"key_name" onCompletionHandler:^(NSString *responseString) {
        NSString *weekCount;
        NSString *leaveCount;
        NSString *demandID;
        NSInteger code = [self publishDemandWithJsonStr:responseString weekCount:&weekCount leaveCount:&leaveCount demandID:&demandID];
        successed(code,demandID,weekCount,leaveCount);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger ) publishDemandWithJsonStr:(NSString *)json weekCount:(NSString **)weekCount leaveCount:(NSString **)leaveCount demandID:(NSString **)demandID{
    NSDictionary *dictJson=[json objectFromJSONString];
    NSInteger code = [[dictJson objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSDictionary *dicResult = [dictJson objectForKey:@"result"];
        *weekCount = [dicResult[@"week_count"]base64DecodedString];
        *leaveCount = [dicResult[@"day_leave_count"]base64DecodedString];
        *demandID = [dicResult[@"demand_notice_id"]base64DecodedString];

    }
    return code;
}
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
                                       failed:(GetDataFailed)failed {
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(userID) stringValue],@"user_id",
                                     [@(demandInfo.demandNoticeID) stringValue],@"demand_notice_id",
                                     demandInfo.demandNoticeName,@"demand_notice_name",
                                     demandInfo.demandContent,@"demand_notice_content",
                                     demandInfo.addressInfo.addressDetail,@"address_detail",
                                     demandInfo.addressInfo.addressHouseNumber,@"house_number",
                                     [@(demandInfo.addressInfo.addressLatitude) stringValue],@"latitude",
                                     [@(demandInfo.addressInfo.addressLongitude) stringValue],@"longitude",
                                     [NSString stringByReplaceNullString:demandInfo.userInfo.userTelPhone],@"demand_notice_tel",
                                     [NSString stringByReplaceNullString:deleteImgIDs],@"demand_notice_gallery_id_str",
                                     nil];
    NSURLSessionTask *op =  [[HHSoftNetWorkEngine sharedHHNetWorkEngine] uploadBatchFileWithPath:[GlobalFile editDemand] filePathArray:demandInfo.arrImg parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson key:@"key_name" onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self getCodeWithJsonStr:responseString];
        successed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

/**
 拆需求红包
 */
- (NSURLSessionTask *)openNeedsRedPacketWithUserID:(NSInteger )userID
                                          demandID:(NSInteger)demandID
                                         successed:(OpenRedPacketSuccessed)successed
                                            failed:(GetDataFailed)failed {
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(userID) stringValue],@"user_id",
                                     [@(demandID) stringValue],@"demand_notice_id",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile openNeedsRedPacket] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSString *amount;
        NSInteger code = [self getopenRedPacketAmountWithJsonStr:responseString amount:&amount];
        successed(code,amount);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
/**
 拆红包
 */
- (NSURLSessionTask *)openRedPacketWithUserID:(NSInteger )userID
                                        successed:(OpenRedPacketSuccessed)successed
                                           failed:(GetDataFailed)failed{
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(userID) stringValue],@"user_id",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile openRedPacket] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSString *amount;
        NSInteger code = [self getopenRedPacketAmountWithJsonStr:responseString amount:&amount];
        successed(code,amount);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger ) getopenRedPacketAmountWithJsonStr:(NSString *)json amount:(NSString **)amount{
    NSDictionary *dictJson=[json objectFromJSONString];
    NSInteger code = [[dictJson objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSDictionary *dicResult = [dictJson objectForKey:@"result"];
        *amount = [dicResult[@"red_amount"] base64DecodedString];
    }
    return code;
}
/**
 热门项目推荐
 @param industryID 行业ID
 */
- (NSURLSessionTask *)getHotRedPacketAdvertListWithIndustryID:(NSInteger)industryID
                                           page:(NSInteger)page
                                       pageSize:(NSInteger)pageSize
                                      successed:(GetHotRedPacketListSuccessed)successed
                                         failed:(GetDataFailed)failed {
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(page) stringValue],@"page",
                                     [@(pageSize) stringValue],@"page_size",
                                     [@(industryID) stringValue],@"industry_id",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getHotRedPacketAdvert] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrData = [NSMutableArray array];
        NSMutableArray *arrTopAdvert = [NSMutableArray array];
        NSInteger code = [self getHotRedPacketAdvertListWithJsonStr:responseString arrTopAdvert:&arrTopAdvert arrData:&arrData];
        successed(code,arrTopAdvert, arrData);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger ) getHotRedPacketAdvertListWithJsonStr:(NSString *)json arrTopAdvert:(NSMutableArray **)arrTopAdvert arrData:(NSMutableArray **)arrData{
    NSDictionary *dictJson=[json objectFromJSONString];
    NSInteger code = [[dictJson objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSDictionary *dicResult = [dictJson objectForKey:@"result"];
        //顶部广告
        NSArray *arrTempTopAdvert = dicResult[@"advert_list"];
        for (NSDictionary *dic in arrTempTopAdvert) {
            AdvertInfo *advertInfo = [[AdvertInfo alloc] init];
            advertInfo.advertID = [[dic[@"advert_id"]base64DecodedString]integerValue];
            advertInfo.advertTitle = [dic[@"advert_title"]base64DecodedString];
            advertInfo.advertImg = [dic[@"big_img"]base64DecodedString];
            advertInfo.advertType = [[dic[@"advert_type"]base64DecodedString]integerValue];
            advertInfo.keyID = [[dic[@"key_id"]base64DecodedString]integerValue];
            advertInfo.linkUrl = [dic[@"link_url"]base64DecodedString];
            [*arrTopAdvert addObject:advertInfo];
        }
        //红包广告
        NSArray *arrTempRedAdvert = dicResult[@"red_advert_list"];
        for (NSInteger i=0; i<arrTempRedAdvert.count; i++) {
            NSDictionary *dic = arrTempRedAdvert[i];
            AdvertInfo *advertInfo = [[AdvertInfo alloc] init];
            advertInfo.advertID = [[dic[@"red_advert_id"]base64DecodedString]integerValue];
            advertInfo.advertImg = [dic[@"big_img"]base64DecodedString];
            advertInfo.merchantName = [dic[@"merchant_name"]base64DecodedString];
            advertInfo.advertApplyCount = [dic[@"sendred_number"]base64DecodedString];
            advertInfo.advertAmount = [dic[@"sendred_amount"]base64DecodedString];
            advertInfo.isCert = [[dic[@"is_cert"]base64DecodedString]boolValue];
            advertInfo.level = [dic[@"level_value"]base64DecodedString];
            advertInfo.advertTitle = [dic[@"red_advert_title"]base64DecodedString];

//            advertInfo.advertPraiseCount = [dic[@"count_praise"]base64DecodedString];
//            advertInfo.advertCollectCount = [dic[@"count_collect"]base64DecodedString];
//            advertInfo.redAdvertType = [[dic[@"red_advert_type"]base64DecodedString]integerValue];
            [*arrData addObject:advertInfo];
        }
    }
    return code;
}
/**
 限时抢购列表
 */
- (NSURLSessionTask *)getGrabRedPacketListWithIndustryID:(NSInteger)industryID
                                                    page:(NSInteger)page
                                                pageSize:(NSInteger)pageSize
                                               successed:(GetGrabRedPacketListSuccessed)successed
                                                  failed:(GetDataFailed)failed {
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(page) stringValue],@"page",
                                     [@(pageSize) stringValue],@"page_size",
                                     [@(industryID) stringValue],@"industry_id",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile grabRedPacketList] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrData = [NSMutableArray array];
        NSInteger endSecond;
        NSInteger code = [self getHotRedPacketAdvertListWithJsonStr:responseString endSecond:&endSecond arrData:&arrData];
        successed(code,endSecond, arrData);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger ) getHotRedPacketAdvertListWithJsonStr:(NSString *)json endSecond:(NSInteger *)endSecond arrData:(NSMutableArray **)arrData {
    NSDictionary *dictJson=[json objectFromJSONString];
    NSInteger code = [[dictJson objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSDictionary *dicResult = [dictJson objectForKey:@"result"];
        *endSecond = [[dicResult[@"start_time"] base64DecodedString] integerValue];
        //红包广告
        NSArray *arrTempRedAdvert = dicResult[@"red_advert_list"];
        for (NSInteger i=0; i<arrTempRedAdvert.count; i++) {
            NSDictionary *dic = arrTempRedAdvert[i];
            AdvertInfo *advertInfo = [[AdvertInfo alloc] init];
            advertInfo.advertID = [[dic[@"red_advert_id"]base64DecodedString]integerValue];
            advertInfo.advertImg = [dic[@"big_img"]base64DecodedString];
            advertInfo.merchantName = [dic[@"merchant_name"]base64DecodedString];
//            advertInfo.advertApplyCount = [dic[@"sendred_number"]base64DecodedString];
//            advertInfo.advertAmount = [dic[@"sendred_amount"]base64DecodedString];
            advertInfo.isCert = [[dic[@"is_cert"]base64DecodedString]boolValue];
            advertInfo.level = [dic[@"level"]base64DecodedString];
            advertInfo.advertTitle = [dic[@"red_advert_title"]base64DecodedString];
            
            //            advertInfo.advertPraiseCount = [dic[@"count_praise"]base64DecodedString];
            //            advertInfo.advertCollectCount = [dic[@"count_collect"]base64DecodedString];
            //            advertInfo.redAdvertType = [[dic[@"red_advert_type"]base64DecodedString]integerValue];
            [*arrData addObject:advertInfo];
        }
    }
    return code;
}
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
                                                  failed:(GetDataFailed)failed {
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(page) stringValue],@"page",
                                     [@(pageSize) stringValue],@"page_size",
                                     [@(industryID) stringValue],@"industry_id",
                                     [@(mark) stringValue],@"page_mark",
                                     [NSString stringByReplaceNullString:keyWords],@"key_words",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile newRedPacketList] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrData = [NSMutableArray array];
        NSInteger code = [self getNewRedPacketAdvertListWithJsonStr:responseString arrData:&arrData];
        successed(code, arrData);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger ) getNewRedPacketAdvertListWithJsonStr:(NSString *)json arrData:(NSMutableArray **)arrData {
    NSDictionary *dictJson=[json objectFromJSONString];
    NSInteger code = [[dictJson objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSMutableArray *arrResult = dictJson[@"result"];
        //红包广告
        for (NSInteger i=0; i<arrResult.count; i++) {
            NSDictionary *dic = arrResult[i];
            AdvertInfo *advertInfo = [[AdvertInfo alloc] init];
            advertInfo.advertID = [[dic[@"red_advert_id"]base64DecodedString]integerValue];
            advertInfo.advertImg = [dic[@"big_img"]base64DecodedString];
            advertInfo.merchantName = [dic[@"merchant_name"]base64DecodedString];
            advertInfo.advertApplyCount = [dic[@"reward_num"]base64DecodedString];
            advertInfo.advertAmount = [dic[@"total_amount"]base64DecodedString];
            advertInfo.isCert = [[dic[@"is_cert"]base64DecodedString]boolValue];
            advertInfo.level = [dic[@"level"]base64DecodedString];
            advertInfo.advertTitle = [dic[@"red_advert_title"]base64DecodedString];
            
            //            advertInfo.advertPraiseCount = [dic[@"count_praise"]base64DecodedString];
            //            advertInfo.advertCollectCount = [dic[@"count_collect"]base64DecodedString];
            //            advertInfo.redAdvertType = [[dic[@"red_advert_type"]base64DecodedString]integerValue];
            [*arrData addObject:advertInfo];
        }
    }
    return code;
}

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
                                                    Failed:(GetDataFailed)failed{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(redAdvertID) stringValue], @"red_advert_id",
                                      [@(userID) stringValue], @"user_id", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getRedAdvertInfo] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        AdvertInfo *advertInfoModel;
        NSInteger code = [self getRedPacketAdvertInfoWithJsonStr:responseString advertInfoModel:&advertInfoModel];
        succeed(code, advertInfoModel);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger)getRedPacketAdvertInfoWithJsonStr:(NSString *)json advertInfoModel:(AdvertInfo **)advertInfoModel {
    NSDictionary *jsonDict = [json objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSDictionary *resultDict = jsonDict[@"result"];
        AdvertInfo *advertInfo = [[AdvertInfo alloc] init];
        
        advertInfo.advertID = [[resultDict[@"red_advert_id"] base64DecodedString] integerValue];
        advertInfo.redAdvertType = [[resultDict[@"red_advert_type"] base64DecodedString] integerValue];
        advertInfo.advertTitle = [resultDict[@"red_advert_title"] base64DecodedString];
        advertInfo.addressInfo.addressLatitude = [[resultDict[@"latitude"] base64DecodedString] doubleValue];
        advertInfo.addressInfo.addressLongitude = [[resultDict[@"longitude"] base64DecodedString] doubleValue];
        advertInfo.merchantName = [resultDict[@"merchant_name"] base64DecodedString];
        advertInfo.addressInfo.addressDetail = [resultDict[@"address_detail"] base64DecodedString];
        advertInfo.isCert = [[resultDict[@"is_cert"] base64DecodedString] integerValue];
        advertInfo.isOpenApplyRed = [[resultDict[@"is_open_apply_red"] base64DecodedString] integerValue];
        advertInfo.isPraise = [[resultDict[@"is_praise"] base64DecodedString] integerValue];
        advertInfo.isApply = [[resultDict[@"is_apply"] base64DecodedString] integerValue];
        advertInfo.isReceive = [[resultDict[@"is_receive"] base64DecodedString] integerValue];
        advertInfo.countDown = [[resultDict[@"count_down"] base64DecodedString] integerValue];
        advertInfo.userInfo.userID = [[resultDict[@"user_id"] base64DecodedString] integerValue];
        advertInfo.advertCommentCount = [[resultDict[@"count_comment"] base64DecodedString] integerValue];
        advertInfo.merchantURL = [resultDict[@"merchant_url"] base64DecodedString];
        advertInfo.linkUrl = [resultDict[@"advert_url"] base64DecodedString];
        advertInfo.isCollect = [[resultDict[@"is_collect"] base64DecodedString] integerValue];
        advertInfo.levelValue = [[resultDict[@"level_value"] base64DecodedString] integerValue];
        advertInfo.advertBrowseTime = [[resultDict[@"browse_time"] base64DecodedString] integerValue];
        advertInfo.advertAmount = [resultDict[@"count_red_amount"] base64DecodedString];
        advertInfo.advertApplyCount = [resultDict[@"count_red_get"] base64DecodedString];
        advertInfo.advertSpecialCount = [resultDict[@"count_special_red"] base64DecodedString];
        advertInfo.userInfo.userHeadImg = [resultDict[@"head_image"] base64DecodedString];
        advertInfo.userInfo.userLevel = [[resultDict[@"user_level"] base64DecodedString] integerValue];
        //广告图集列表
        NSArray *arrGoodsGallery=[resultDict objectForKey:@"red_advert_gallery_list"];
        if (arrGoodsGallery.count>0) {
            for (NSDictionary *dicGallery in arrGoodsGallery) {
                ImageInfo *imageInfo = [[ImageInfo alloc] init];
                imageInfo.galleryID = [[[dicGallery objectForKey:@"red_advert_gallery_id"] base64DecodedString] integerValue];
                imageInfo.imageSource = [[dicGallery objectForKey:@"source_img"] base64DecodedString];
                imageInfo.imageBig = [[dicGallery objectForKey:@"big_img"] base64DecodedString];
                [advertInfo.arrRedAdvertGalleryList addObject:imageInfo];
            }
        }
        //标签列表
        NSArray *arrLabel=[resultDict objectForKey:@"red_advert_label_list"];
        if (arrLabel.count>0) {
            for (NSDictionary *dicLabel in arrLabel) {
                RedPacketAdvertLabelInfo *labelInfo = [[RedPacketAdvertLabelInfo alloc] init];
                labelInfo.redPacketAdvertLabelID = [[[dicLabel objectForKey:@"red_advert_label_id"] base64DecodedString] integerValue];
                labelInfo.redPacketAdvertLabelName = [[dicLabel objectForKey:@"red_advert_label_name"] base64DecodedString];
                [advertInfo.arrRedAdvertLabelList addObject:labelInfo];
            }
        }
        //供货商印象列表
        NSArray *arrImpress=[resultDict objectForKey:@"impress_list"];
        if (arrImpress.count>0) {
            for (NSDictionary *dicImpress in arrImpress) {
                ImpressInfo *impressInfo = [[ImpressInfo alloc] init];
                impressInfo.impressID = [[[dicImpress objectForKey:@"impress_id"] base64DecodedString] integerValue];
                impressInfo.impressName = [[dicImpress objectForKey:@"impress_name"] base64DecodedString];
                impressInfo.impressCommentCount = [[[dicImpress objectForKey:@"count_comment"] base64DecodedString] integerValue];
                impressInfo.impressIsComment = [[[dicImpress objectForKey:@"is_comment"] base64DecodedString] integerValue];
                
                [advertInfo.arrImpressList addObject:impressInfo];
            }
        }
        //评论列表
        NSArray *arrComment=[resultDict objectForKey:@"comment_list"];
        if (arrComment.count>0) {
            for (NSDictionary *dicComment in arrComment) {
                CommentInfo *commentInfo = [[CommentInfo alloc] init];
                commentInfo.commentID = [[[dicComment objectForKey:@"comment_id"] base64DecodedString] integerValue];
                commentInfo.commentScore = [[[dicComment objectForKey:@"comment_score"] base64DecodedString] floatValue];
                commentInfo.commentAddTime = [[dicComment objectForKey:@"add_time"] base64DecodedString];
                commentInfo.commentContent = [[dicComment objectForKey:@"comment_content"] base64DecodedString];
                commentInfo.userInfo.userHeadImg = [[dicComment objectForKey:@"head_image"] base64DecodedString];
                commentInfo.userInfo.userNickName = [[dicComment objectForKey:@"nick_name"] base64DecodedString];
                
                [advertInfo.arrCommentList addObject:commentInfo];
            }
        }
        //供应商电话列表
        NSArray *arrTel=[resultDict objectForKey:@"merchant_tel_list"];
        if (arrTel.count>0) {
            for (NSDictionary *dicTel in arrTel) {
                MerchantInfo *merchantInfo = [[MerchantInfo alloc] init];
                merchantInfo.merchantTelID = [[[dicTel objectForKey:@"merchant_tel_id"] base64DecodedString] integerValue];
                merchantInfo.merchantTel = [[dicTel objectForKey:@"merchant_tel"] base64DecodedString];
                
                [advertInfo.arrMerchantTelList addObject:merchantInfo];
            }
        }
        
        *advertInfoModel = advertInfo;
    }
    return code;
}
/**
 供货商印象点评
 
 @param userID    登录用户ID
 @param impressID 印象ID
 @param succeed     succeed
 @param failed      failed
 
 @return value
 */
-(NSURLSessionTask *)addImpressCommentInfoWithUserID:(NSInteger)userID
                                           ImpressID:(NSInteger)impressID
                                             Succeed:(AddImpressCommentInfoSuccessed)succeed
                                              Failed:(GetDataFailed)failed{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      [@(impressID) stringValue], @"impress_id",nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile AddImpressCommentInfo] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self addImpressCommentInfoWithJsonStr:responseString];
        succeed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger)addImpressCommentInfoWithJsonStr:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    return code;
}
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
                                          Failed:(GetDataFailed)failed{
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(pageIndex) stringValue],@"page",
                                     [@(pageSize) stringValue],@"page_size",
                                     [@(merchantUserID) stringValue],@"merchant_user_id",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getCommentList] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrCommentList = [[NSMutableArray alloc] init];
        NSInteger code=[self getCommentListWithjsonString:responseString arrCommentList:&arrCommentList];
        succeed(code,arrCommentList);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
-(NSInteger)getCommentListWithjsonString:(NSString *)jsonStr arrCommentList:(NSMutableArray **)arrCommentList{
    NSDictionary *dictReuslt = [jsonStr objectFromJSONString];
    NSInteger code = [[dictReuslt objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSArray *arrResult = [dictReuslt objectForKey:@"result"];
        for (NSDictionary *dicComment in arrResult) {
            CommentInfo *commentInfo = [[CommentInfo alloc] init];
            commentInfo.commentID = [[[dicComment objectForKey:@"comment_id"] base64DecodedString] integerValue];
            commentInfo.commentScore = [[[dicComment objectForKey:@"comment_score"] base64DecodedString] floatValue];
            commentInfo.commentAddTime = [[dicComment objectForKey:@"add_time"] base64DecodedString];
            commentInfo.commentContent = [[dicComment objectForKey:@"comment_content"] base64DecodedString];
            commentInfo.userInfo.userHeadImg = [[dicComment objectForKey:@"head_image"] base64DecodedString];
            commentInfo.userInfo.userNickName = [[dicComment objectForKey:@"nick_name"] base64DecodedString];
            //图集列表
            NSArray *arrGallery=[dicComment objectForKey:@"gallery_list"];
            if (arrGallery.count>0) {
                for (NSDictionary *dicGallery in arrGallery) {
                    ImageInfo *imageInfo = [[ImageInfo alloc] init];
                    imageInfo.galleryID = [[[dicGallery objectForKey:@"comment_gallery_id"] base64DecodedString] integerValue];
                    imageInfo.imageThumb = [[dicGallery objectForKey:@"thumb_img"] base64DecodedString];
                    
                    [commentInfo.arrCommentGallery addObject:imageInfo];
                }
            }
            
            [*arrCommentList addObject:commentInfo];
        }
    }
    return code;
}
/**
 点赞和取消点赞
 
 @param userID      用户ID
 @param redAdvertID 红包广告ID
 @param succeed     succeed
 @param failed      failed
 
 @return value
 */
-(NSURLSessionTask *)addPraiseAndCancelPraiseInfoWithUserID:(NSInteger )userID
                                                redAdvertID:(NSInteger)redAdvertID
                                                    Succeed:(AddPraiseInfoSuccessed)succeed
                                                     Failed:(GetDataFailed)failed{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      [@(redAdvertID) stringValue], @"red_advert_id",nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile addPraiseInfo] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self addPraiseAndCancelPraiseInfoWithJsonStr:responseString];
        succeed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger)addPraiseAndCancelPraiseInfoWithJsonStr:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    return code;
}
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
                                          Failed:(GetDataFailed)failed{
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(userID) stringValue],@"user_id",
                                     [@(redAdvertID) stringValue],@"red_advert_id",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile openRedAdvertInfo] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSString *redAmount;
        NSInteger code = [self openRedAdvertInfoWithJsonStr:responseString redAmount:&redAmount];
        succeed(code,redAmount);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
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
                                          Failed:(GetDataFailed)failed{
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(userID) stringValue],@"user_id",
                                     [@(redAdvertID) stringValue],@"game_red_id",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile openGameRedAdvertInfo] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSString *redAmount;
        NSInteger code = [self openRedAdvertInfoWithJsonStr:responseString redAmount:&redAmount];
        succeed(code,redAmount);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
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
                                              Failed:(GetDataFailed)failed{
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(userID) stringValue],@"user_id",
                                     [@(redAdvertID) stringValue],@"password_red_id",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile openSceneRedPacketInfo] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSString *redAmount;
        NSInteger code = [self openRedAdvertInfoWithJsonStr:responseString redAmount:&redAmount];
        succeed(code,redAmount);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

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
                                          Failed:(GetDataFailed)failed{
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(userID) stringValue],@"user_id",
                                     [@(redAdvertID) stringValue],@"today_red_id",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile openTodayRedPacketInfo] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSString *redAmount;
        NSInteger code = [self openRedAdvertInfoWithJsonStr:responseString redAmount:&redAmount];
        succeed(code,redAmount);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger)openRedAdvertInfoWithJsonStr:(NSString *)json redAmount:(NSString **)redAmount{
    NSDictionary *dictJson=[json objectFromJSONString];
    NSInteger code = [[dictJson objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSDictionary *dicResult = [dictJson objectForKey:@"result"];
        *redAmount = [dicResult[@"red_amount"] base64DecodedString];
    }
    return code;
}
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
                                        Failed:(GetDataFailed)failed{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      [@(redAdvertID) stringValue], @"red_advert_id",nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile addApplyRedInfo] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self addApplyRedInfoWithJsonStr:responseString];
        succeed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger)addApplyRedInfoWithJsonStr:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    return code;
}
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
                                       Failed:(GetDataFailed)failed{
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(userID) stringValue],@"user_id",
                                     [@(merchantUserID) stringValue],@"merchant_user_id",
                                     [@(commentScore) stringValue],@"comment_score",
                                     commentContent,@"comment_content",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] uploadBatchFileWithPath:[GlobalFile addCommentInfo] filePathArray:filePath parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson key:@"file0" onCompletionHandler:^(NSString *responseString) {
        CommentInfo *commentInfoModel;
        NSInteger code=[self addCommentInfoWithResonseString:responseString commentInfoModel:&commentInfoModel];
        succeed(code,commentInfoModel);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
-(NSInteger)addCommentInfoWithResonseString:(NSString *)responseString commentInfoModel:(CommentInfo **)commentInfoModel{
    NSDictionary *dictReuslt = [responseString objectFromJSONString];
    NSInteger code= [[dictReuslt objectForKey:@"code"] integerValue];
    if (code == 100) {
        
        NSDictionary *dictResult=[dictReuslt objectForKey:@"result"];
        
        CommentInfo *commentInfo = [[CommentInfo alloc] init];
        commentInfo.commentID = [[[dictResult objectForKey:@"score"] base64DecodedString] floatValue];
        commentInfo.commentContent = [[dictResult objectForKey:@"content"] base64DecodedString];
        
        *commentInfoModel = commentInfo;
    }
    return code;
}
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
                                             Failed:(GetDataFailed)failed{
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(userID) stringValue],@"user_id",
                                     [@(redAdvertID) stringValue],@"red_advert_id",
                                     [@(browseTime) stringValue],@"browse_time",
                                     telPhone,@"tel_phone",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile addConsultRecordInfo] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger isRedRecord;
        NSInteger code = [self addConsultRecordInfoWithJsonStr:responseString isRedRecord:&isRedRecord];
        succeed(code,isRedRecord);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger)addConsultRecordInfoWithJsonStr:(NSString *)json isRedRecord:(NSInteger *)isRedRecord{
    NSDictionary *dictJson=[json objectFromJSONString];
    NSInteger code = [[dictJson objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSDictionary *dicResult = [dictJson objectForKey:@"result"];
        *isRedRecord = [[dicResult[@"is_red_record"] base64DecodedString] integerValue];
    }
    return code;
}
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
                                             Failed:(GetDataFailed)failed{
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(userID) stringValue],@"user_id",
                                     [@(redAdvertID) stringValue],@"red_advert_id",
                                     [@(browseTime) stringValue],@"browse_time",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile openTelRedAdvertInfo] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSString *redAmount;
        NSInteger code = [self openTelRedAdvertInfoWithJsonStr:responseString redAmount:&redAmount];
        succeed(code,redAmount);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger)openTelRedAdvertInfoWithJsonStr:(NSString *)json redAmount:(NSString **)redAmount{
    NSDictionary *dictJson=[json objectFromJSONString];
    NSInteger code = [[dictJson objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSDictionary *dicResult = [dictJson objectForKey:@"result"];
        *redAmount = [dicResult[@"red_amount"] base64DecodedString];
    }
    return code;
}
@end
