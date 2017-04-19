//
//  UserCenterNetWorkEngine.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "UserCenterNetWorkEngine.h"
#import <HHSoftFrameWorkKit/HHSoftJSONKit.h>
#import <HHSoftFrameWorkKit/HHSoftEncrypt.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftEncode.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "UserInfo.h"
#import "AdvertInfo.h"
#import "ConsultRecordInfo.h"
#import "DemandNoticeInfo.h"
#import "RegionInfo.h"
#import "AddressInfo.h"
#import "CustomServicerInfo.h"
#import "PointsInfo.h"
#import "ChangeRecordInfo.h"
#import "RuleInfo.h"
#import "MessageInfo.h"
#import "RewardInfo.h"

@implementation UserCenterNetWorkEngine
/**
 签到
 
 @param userID      用户ID
 @param successed   成功
 @param failed      失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)addSignInfoWithUserID:(NSInteger)userID
                                  successed:(AddSignInfoSuccessed)successed
                                     failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile addSignInfoUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self getCodeWithJsonStr:responseString];
        successed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger ) getCodeWithJsonStr:(NSString *)json {
    NSDictionary *dictJson=[json objectFromJSONString];
    NSInteger code = [[dictJson objectForKey:@"code"] integerValue];
    return code;
}
/**
 我的
 
 @param userID    用户ID
 @param successed 成功
 @param failed    失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getUserCenterWithUserID:(NSInteger)userID
                                    successed:(GetUserCenterSuccessed)successed
                                       failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getUserInfoMySelfUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        UserInfo *userInfo;
        NSInteger code = [self parseUserCenterReslutToUserInfo:&userInfo jsonString:responseString];
        successed(code, userInfo);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger)parseUserCenterReslutToUserInfo:(UserInfo **)userModel jsonString:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code=[jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSDictionary *resultDict = jsonDict[@"result"];
        
        UserInfo *userInfo = [[UserInfo alloc]init];
        userInfo.userID = [[resultDict[@"user_id"] base64DecodedString] integerValue];
        userInfo.userNickName = [resultDict[@"nick_name"] base64DecodedString];
        userInfo.userHeadImg = [resultDict[@"head_image"] base64DecodedString];
        userInfo.userPoints = [[resultDict[@"user_points"] base64DecodedString] integerValue];
        userInfo.userLevel = [[resultDict[@"level_value"] base64DecodedString] integerValue];
        userInfo.userType = [[resultDict[@"user_type"] base64DecodedString] integerValue];
        userInfo.userFees = [[resultDict[@"user_fees"] base64DecodedString] floatValue];
        userInfo.userIsCert = [[resultDict[@"is_cert"] base64DecodedString] integerValue];
        userInfo.userIsOpenRed = [[resultDict[@"is_open_apply_red"] base64DecodedString] integerValue];
        userInfo.userCashAmount = [[resultDict[@"cash_amount"] base64DecodedString] floatValue];
        userInfo.userCashRedNum = [[resultDict[@"cash_red_num"] base64DecodedString] integerValue];
        
        *userModel = userInfo;
    }
    return code;
}

/**
 个人信息
 
 @param userID    用户ID
 @param successed 成功
 @param failed    失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getUserInfoWithUserID:(NSInteger)userID
                                  successed:(GetUserInfoSuccessed)successed
                                     failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getUserInfoUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        UserInfo *userInfo;
        NSInteger code = [self parseUserInfoReslutToUserInfo:&userInfo jsonString:responseString];
        successed(code, userInfo);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger)parseUserInfoReslutToUserInfo:(UserInfo **)userModel jsonString:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code=[jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSDictionary *resultDict = jsonDict[@"result"];

        UserInfo *userInfo = [[UserInfo alloc]init];
        userInfo.userID = [[resultDict[@"user_id"] base64DecodedString] integerValue];
        userInfo.userNickName = [resultDict[@"nick_name"] base64DecodedString];
        userInfo.userHeadImg = [resultDict[@"head_image"] base64DecodedString];
        userInfo.userLoginName = [resultDict[@"login_name"] base64DecodedString];
        userInfo.userProvinceID = [[resultDict[@"province_id"] base64DecodedString] integerValue];
        userInfo.userProvinceName = [resultDict[@"province_name"] base64DecodedString];
        userInfo.userCityID = [[resultDict[@"city_id"] base64DecodedString] integerValue];
        userInfo.userCityName = [resultDict[@"city_name"] base64DecodedString];
        userInfo.userDistrictID = [[resultDict[@"district_id"] base64DecodedString] integerValue];
        userInfo.userDistrictName = [resultDict[@"district_name"] base64DecodedString];
        userInfo.userIndustryID = [[resultDict[@"industry_id"] base64DecodedString] integerValue];
        userInfo.userIndustryName = [resultDict[@"industry_name"] base64DecodedString];
        userInfo.userMerchantName = [resultDict[@"merchant_name"] base64DecodedString];
        userInfo.userMerchantAddressInfo.addressDetail = [resultDict[@"address_detail"] base64DecodedString];
        userInfo.userMerchantAddressInfo.addressHouseNumber = [resultDict[@"house_number"] base64DecodedString];
        userInfo.userRealName = [resultDict[@"real_name"] base64DecodedString];
        userInfo.userBirthday = [resultDict[@"birth_day"] base64DecodedString];
        userInfo.userMerchantAddressInfo.addressLatitude = [[resultDict[@"latitude"] base64DecodedString] floatValue];
        userInfo.userMerchantAddressInfo.addressLongitude = [[resultDict[@"longitude"] base64DecodedString] floatValue];
        userInfo.userIsOpenRed = [[resultDict[@"is_open_apply_red"] base64DecodedString] integerValue];
        
        *userModel = userInfo;
    }
    return code;
}
/**
 修改个人信息
 
 @param userID      用户ID
 @param mark        1：头像，2：昵称，3：姓名，4：出生日期 5：店名1：验证原手机号吗· 2：修改手机号
 @param userInfoStr 对应的mark值
 @param successed   成功
 @param failed      失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)editUserInfoWithUserID:(NSInteger)userID
                                        mark:(NSInteger)mark
                                 userInfoStr:(NSString *)userInfoStr
                                   successed:(EditUserInfoSuccessed)successed
                                      failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict;
    NSURLSessionTask *op;
    if (mark == 1) {
        paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                     [@(userID) stringValue], @"user_id",
                     [@(mark) stringValue], @"mark",
                     userInfoStr, @"userinfo_str", nil];
        op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] uploadFileWithPath:[GlobalFile editUserInfoUrl] filePath:userInfoStr parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson key:@"user_image" onCompletionHandler:^(NSString *responseString) {
            NSString *userHeadImg;
            NSInteger code = [self parseEditUserInfoWithjsonString:responseString userHeadImg:&userHeadImg];
            successed(code, userHeadImg);
        } onFailHandler:^(NSError *responseError) {
            failed(responseError);
        }];
    } else {
        paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                     [@(userID) stringValue], @"user_id",
                     [@(mark) stringValue], @"mark",
                     userInfoStr, @"userinfo_str", nil];
        op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile editUserInfoUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
            NSString *userHeadImg;
            NSInteger code = [self parseEditUserInfoWithjsonString:responseString userHeadImg:&userHeadImg];
            successed(code, userHeadImg);
        } onFailHandler:^(NSError *responseError) {
            failed(responseError);
        }];
    }
    return op;
}

- (NSInteger)parseEditUserInfoWithjsonString:(NSString *)jsonStr userHeadImg:(NSString **)userHeadImg {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code=[jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSDictionary *resultDict = jsonDict[@"result"];
        *userHeadImg = [resultDict[@"head_image"] base64DecodedString];
    }
    return code;
}

/**
 修改地址
 
 @param userID           用户ID
 @param lat              纬度
 @param lng              经度
 @param addressDetail    店铺地址
 @param houseNumber      门牌号
 @param successed        成功
 @param failed           失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)editUserAddressWithWithUserID:(NSInteger)userID
                                                lat:(CGFloat)lat
                                                lng:(CGFloat)lng
                                      addressDetail:(NSString *)addressDetail
                                        houseNumber:(NSString *)houseNumber
                                          successed:(EditUserAddressSuccessed)successed
                                             failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      [@(lat) stringValue], @"lat",
                                      [@(lng) stringValue], @"lng",
                                      addressDetail, @"address_detail",
                                      houseNumber, @"house_number", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile editUserAddressUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self parseEditUserAddressWithjsonString:responseString];
        successed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger)parseEditUserAddressWithjsonString:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code=[jsonDict[@"code"] integerValue];
    return code;
}

/**
 修改手机号
 
 @param userID     用户ID
 @param mark       1：验证原手机号吗· 2：修改手机号
 @param userTel    用户手机号
 @param verifyCode 验证码
 @param successed  成功
 @param failed     失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)editUserTelWithWithUserID:(NSInteger)userID
                                           mark:(NSInteger)mark
                                        userTel:(NSString *)userTel
                                     verifyCode:(NSString *)verifyCode
                                      successed:(EditUserLoginNameSuccessed)successed
                                         failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      [@(mark) stringValue], @"mark",
                                      userTel, @"user_tel",
                                      verifyCode, @"verify_code", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile editLoginNameUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self parseEditUserAddressWithjsonString:responseString];
        successed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

/**
 修改密码
 
 @param userID     用户ID
 @param newPwd     新密码
 @param oldPwd     旧密码
 @param successed  成功
 @param failed     失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)editUserPwdWithUserID:(NSInteger)userID
                                     newPwd:(NSString *)newPwd
                                     oldPwd:(NSString *)oldPwd
                                  successed:(EditUserOldPasswordSuccessed)successed
                                     failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      [HHSoftEncrypt Md5ThirtyTwoEnctyptString:[HHSoftEncrypt Md5ThirtyTwoEnctyptString:newPwd]], @"new_pwd",
                                      [HHSoftEncrypt Md5ThirtyTwoEnctyptString:[HHSoftEncrypt Md5ThirtyTwoEnctyptString:oldPwd]], @"old_pwd", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile editOldPasswordUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self parseEditUserAddressWithjsonString:responseString];
        successed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

/**
 申请开通打赏红包
 
 @param userID    用户ID
 @param mark      1：开通红包打赏 2：设置红包打赏
 @param redNum    红包总数量
 @param redAmount 红包单个金额
 @param successed 成功
 @param failed    失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)userApplyeRedWithUserID:(NSInteger)userID
                                         mark:(NSInteger)mark
                                       redNum:(NSInteger)redNum
                                    redAmount:(CGFloat)redAmount
                                    successed:(UserApplyRedSuccessed)successed
                                       failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      [@(mark) stringValue], @"mark",
                                      [@(redNum) stringValue], @"cash_red_num",
                                      [@(redAmount) stringValue], @"cash_red_amount", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile userApplyRedUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self parseEditUserAddressWithjsonString:responseString];
        successed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

/**
 关闭打赏红包
 
 @param userID    用户ID
 @param successed 成功
 @param failed    失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)userColseRedWithUserID:(NSInteger)userID
                                   successed:(UserColseRedSuccessed)successed
                                      failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile userCloseRedUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self parseEditUserAddressWithjsonString:responseString];
        successed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
/**
 咨询记录（商家/代货商）
 
 @param userID    用户id
 @param userType  用户类型【1：商家 2：供货商】
 @param pageIndex 第几页
 @param pageSize  页数
 @param succeed   succeed
 @param failed    failed
 
 @return value
 */
-(NSURLSessionTask *)getConsultRecordListWithUserID:(NSInteger)userID
                                           UserType:(NSInteger)userType
                                          PageIndex:(NSInteger)pageIndex
                                           PageSize:(NSInteger)pageSize
                                            Succeed:(GetConsultRecordListSuccessed)succeed
                                             Failed:(GetDataFailed)failed{
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(userID) stringValue],@"user_id",
                                     [@(userType) stringValue],@"user_type",
                                     [@(pageIndex) stringValue],@"page",
                                     [@(pageSize) stringValue],@"page_size",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getConsultRecordList] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrRecordList = [[NSMutableArray alloc] init];
        NSInteger code=[self getConsultRecordListWithjsonString:responseString arrRecordList:&arrRecordList];
        succeed(code,arrRecordList);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
-(NSInteger)getConsultRecordListWithjsonString:(NSString *)jsonStr arrRecordList:(NSMutableArray **)arrRecordList{
    NSDictionary *dictReuslt = [jsonStr objectFromJSONString];
    NSInteger code = [[dictReuslt objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSArray *arrResult = [dictReuslt objectForKey:@"result"];
        for (NSDictionary *dict in arrResult) {
            ConsultRecordInfo *consultRecordInfo = [[ConsultRecordInfo alloc] init];
            consultRecordInfo.consultRecordID = [[[dict objectForKey:@"consult_record_id"] base64DecodedString] integerValue];
            consultRecordInfo.consultRecordAddTime = [[dict objectForKey:@"add_time"] base64DecodedString];
            consultRecordInfo.advertInfo.advertID = [[[dict objectForKey:@"red_advert_id"] base64DecodedString] integerValue];
            consultRecordInfo.userInfo.userHeadImg = [[dict objectForKey:@"head_image"] base64DecodedString];
            consultRecordInfo.userInfo.userNickName = [[dict objectForKey:@"nick_name"] base64DecodedString];
            consultRecordInfo.userInfo.userLoginName = [[dict objectForKey:@"login_name"] base64DecodedString];
            consultRecordInfo.userInfo.userTelPhone = [[dict objectForKey:@"tel_phone"] base64DecodedString];
            
            [*arrRecordList addObject:consultRecordInfo];
        }
    }
    return code;
}
/**
 我的发布列表
 
 @param userID    用户id
 @param userType  用户类型【1：商家 2：供货商】
 @param pageIndex 第几页
 @param pageSize  页数
 @param succeed   succeed
 @param failed    failed
 
 @return value
 */
-(NSURLSessionTask *)getMyDemandNoticeListWithUserID:(NSInteger)userID
                                            UserType:(NSInteger)userType
                                           PageIndex:(NSInteger)pageIndex
                                            PageSize:(NSInteger)pageSize
                                             Succeed:(GetMyDemandNoticeListSuccessed)succeed
                                              Failed:(GetDataFailed)failed{
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [@(userID) stringValue],@"user_id",
                                     [@(userType) stringValue],@"user_type",
                                     [@(pageIndex) stringValue],@"page",
                                     [@(pageSize) stringValue],@"page_size",
                                     nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getMyDemandNoticeList] parmarDic:parmDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrDemandNoticeList = [[NSMutableArray alloc] init];
        NSInteger code=[self getMyDemandNoticeWithjsonString:responseString arrDemandNoticeList:&arrDemandNoticeList];
        succeed(code,arrDemandNoticeList);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
-(NSInteger)getMyDemandNoticeWithjsonString:(NSString *)jsonStr arrDemandNoticeList:(NSMutableArray **)arrDemandNoticeList{
    NSDictionary *dictReuslt = [jsonStr objectFromJSONString];
    NSInteger code = [[dictReuslt objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSArray *arrResult = [dictReuslt objectForKey:@"result"];
        for (NSDictionary *dict in arrResult) {
            DemandNoticeInfo *demandNoticeInfo = [[DemandNoticeInfo alloc] init];
            demandNoticeInfo.demandNoticeID = [[[dict objectForKey:@"demand_notice_id"] base64DecodedString] integerValue];
            demandNoticeInfo.demandNoticeAddTime = [[dict objectForKey:@"add_time"] base64DecodedString];
            demandNoticeInfo.demandNoticeName = [[dict objectForKey:@"demand_notice_name"] base64DecodedString];
            demandNoticeInfo.demandNoticeCollectCount = [[[dict objectForKey:@"collect_count"] base64DecodedString] integerValue];
            demandNoticeInfo.demandNoticeThumbImg = [[dict objectForKey:@"thumb_img"] base64DecodedString];
            
            [*arrDemandNoticeList addObject:demandNoticeInfo];
        }
    }
    return code;
}
/**
 我的发布删除
 
 @param userID         商家/供货商ID
 @param demandNoticeID 需求/公示公告ID
 @param succeed   succeed
 @param failed    failed
 
 @return value
 */
-(NSURLSessionTask *)deleteDemandNoticeInfoWithUserID:(NSInteger)userID
                                       DemandNoticeID:(NSInteger)demandNoticeID
                                              Succeed:(DeleteDemandNoticeInfoSuccessed)succeed
                                               Failed:(GetDataFailed)failed{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      [@(demandNoticeID) stringValue], @"demand_notice_id", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile deleteDemandNoticeInfo] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self deleteDemandNoticeInfoWithjsonString:responseString];
        succeed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
/**
 删除咨询记录
 
 @param userType       用户类型【1：商家 2;供货商】
 @param consultRecordID 记录id
 @param succeed   succeed
 @param failed    failed
 
 @return value
 */
-(NSURLSessionTask *)deleteConsultRecordInfoWithUserType:(NSInteger)userType
                                         ConsultRecordID:(NSInteger)consultRecordID
                                                 Succeed:(DeleteDemandNoticeInfoSuccessed)succeed
                                                  Failed:(GetDataFailed)failed{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userType) stringValue], @"user_type",
                                      [@(consultRecordID) stringValue], @"consult_record_id", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile deleteConsultRecordInfo] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self deleteDemandNoticeInfoWithjsonString:responseString];
        succeed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger)deleteDemandNoticeInfoWithjsonString:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code=[jsonDict[@"code"] integerValue];
    return code;
}

/**
 联系我们
 
 @param userType      1:商家 2;代货商
 @param successed     成功
 @param failed        失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getRegionIndustryListWithUserType:(NSInteger)userType
                                              successed:(GetRegionIndustryListSuccessed)successed
                                                 failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userType) stringValue], @"user_type", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getRegionIndustryListUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrData = [NSMutableArray arrayWithCapacity:0];
        NSInteger code = [self parseGetRegionListResultToArrData:&arrData jsonStr:responseString];
        //code 100：成功，101：失败，102：参数错误，100001：网络接连异常
        successed(code, arrData);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger)parseGetRegionListResultToArrData:(NSMutableArray **)arrData jsonStr:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSArray *arrResult = jsonDict[@"result"];
        if (arrResult.count) {
            for (NSDictionary *regionDict in arrResult) {
                RegionInfo *regionInfo = [[RegionInfo alloc] init];
                regionInfo.regionID = [[regionDict[@"region_id"] base64DecodedString] integerValue];
                regionInfo.regionName = [regionDict[@"region_name"] base64DecodedString];
                
                [*arrData addObject:regionInfo];
            }
        }
    }
    return code;
}

/**
 地区行业客服列表
 
 @param industryID  行业ID
 @param successed   成功
 @param failed      失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getCustomListWithIndustryID:(NSInteger)industryID
                                        successed:(GetCustomListSuccessed)successed
                                           failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(industryID) stringValue], @"industry_id", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getCustomListUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrData = [NSMutableArray arrayWithCapacity:0];
        NSInteger code = [self parseGetCustomListResultToArrData:&arrData jsonStr:responseString];
        //code 100：成功，101：失败，102：参数错误，100001：网络接连异常
        successed(code, arrData);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger)parseGetCustomListResultToArrData:(NSMutableArray **)arrData jsonStr:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSArray *arrResult = jsonDict[@"result"];
        if (arrResult.count) {
            for (NSDictionary *regionDict in arrResult) {
                CustomServicerInfo *customServicerInfo = [[CustomServicerInfo alloc] init];
                customServicerInfo.customID = [[regionDict[@"custom_id"] base64DecodedString] integerValue];
                customServicerInfo.customName = [regionDict[@"custom_name"] base64DecodedString];
                customServicerInfo.customTel = [regionDict[@"custom_tel"] base64DecodedString];
                customServicerInfo.customAddress = [regionDict[@"custom_address"] base64DecodedString];
                customServicerInfo.customQQ = [regionDict[@"custom_qq"] base64DecodedString];
                customServicerInfo.customWeChat = [regionDict[@"custom_wechat"] base64DecodedString];
                customServicerInfo.customSinaWeiBo = [regionDict[@"custom_webo"] base64DecodedString];
                
                [*arrData addObject:customServicerInfo];
            }
        }
    }
    return code;
}

/**
 获取通知栏推送状态
 
 @param userID    用户ID
 @param deviceToken 设备号
 @param deviceType  设备类型【0：安卓，1：IOS】
 @param successed   成功
 @param failed      失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getIsPushWithUserID:(NSInteger)userID
                              deviceToken:(NSString *)deviceToken
                               deviceType:(NSInteger)deviceType
                                successed:(GetIsPushSuccessed)successed
                                   failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      deviceToken, @"device_token",
                                      [@(deviceType) stringValue], @"device_type", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getIsPushUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        UserInfo *userInfo;
        NSInteger code = [self parseGetIsPushWithjsonString:responseString userInfo:&userInfo];
        successed(code, userInfo);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger)parseGetIsPushWithjsonString:(NSString *)jsonStr userInfo:(UserInfo **)userModel {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSDictionary *resultDict = [jsonDict objectForKey:@"result"];
        UserInfo *userInfo = [[UserInfo alloc]init];
        userInfo.userID = [[resultDict[@"user_id"] base64DecodedString] integerValue];
        userInfo.userIsPush = [[resultDict[@"is_push"] base64DecodedString] integerValue];
        
        *userModel = userInfo;
    }
    return code;
}
/**
 修改通知栏推送状态
 
 @param userID    用户ID
 @param deviceToken 设备号
 @param deviceType  设备类型【0：安卓，1：IOS】
 @param isPush    用户ID
 @param successed   成功
 @param failed      失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)editIsPushWithUserID:(NSInteger)userID
                               deviceToken:(NSString *)deviceToken
                                deviceType:(NSInteger)deviceType
                                    isPush:(NSInteger)isPush
                                 successed:(EditIsPushSuccessed)successed
                                    failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      deviceToken, @"device_token",
                                      [@(deviceType) stringValue], @"device_type",
                                      [@(isPush) stringValue], @"is_push", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile ediIsPushUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self parseEditUserAddressWithjsonString:responseString];
        successed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

#pragma mark --- 获取用户积分列表
/**
 获取用户积分列表
 
 @param userID    用户ID
 @param pageIndex 页数
 @param pageSize  每页条数
 @param successed successed
 @param failed    failed
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getUserPointListWithUserID:(NSInteger)userID
                                       pageIndex:(NSInteger)pageIndex
                                        pageSize:(NSInteger)pageSize
                                       successed:(GetUserPointListSuccessed)successed
                                          failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      [@(pageIndex) stringValue], @"page",
                                      [@(pageSize) stringValue], @"page_size", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile userPointList] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        PointsInfo *pointsInfo;
        NSInteger code = [self parseUserPointListResuleToPointsInfo:&pointsInfo jsonStr:responseString];
        successed(code, pointsInfo);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger)parseUserPointListResuleToPointsInfo:(PointsInfo **)pointsModel jsonStr:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [[jsonDict objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSDictionary *resultDict = [jsonDict objectForKey:@"result"];
        PointsInfo *pointsInfo = [[PointsInfo alloc] init];
        pointsInfo.pointsUserPoints = [[resultDict[@"user_points"] base64DecodedString] integerValue];
        pointsInfo.pointsFewDays = [[resultDict[@"few_days"] base64DecodedString] integerValue];
        pointsInfo.pointsIsSign = [[resultDict[@"is_sign"] base64DecodedString] integerValue];
        
        NSArray *arrChangeRecord = resultDict[@"user_points_list"];
        if (arrChangeRecord.count) {
            for (NSDictionary *dict in arrChangeRecord) {
                ChangeRecordInfo *changeRecordInfo = [[ChangeRecordInfo alloc] init];
                changeRecordInfo.changeID = [[dict[@"change_point_id"] base64DecodedString] integerValue];
                changeRecordInfo.changePoints = [[dict[@"change_point"] base64DecodedString] integerValue];
                changeRecordInfo.changeUserPoints = [[dict[@"user_point"] base64DecodedString] integerValue];
                changeRecordInfo.changeTime = [dict[@"add_time"] base64DecodedString];
                changeRecordInfo.changeType = [[dict[@"type"] base64DecodedString] integerValue];
                changeRecordInfo.changeTypeName = [dict[@"type_str"] base64DecodedString];
                changeRecordInfo.changeMemo = [dict[@"memo"] base64DecodedString];
                [pointsInfo.pointsArrChange addObject:changeRecordInfo];
            }
        }
        *pointsModel = pointsInfo;
    }
    return code;
}

/**
 积分申请提现
 
 @param userID      用户ID
 @param points      提现积分
 @param successed   成功
 @param failed      失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)addPointsWithdrawalsWithUserID:(NSInteger)userID
                                              points:(NSInteger)points
                                           successed:(AddPointsWithdrawalsSuccessed)successed
                                              failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      [@(points) stringValue], @"withdrawals_point", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile addPointWithdrawalsUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self parseEditUserAddressWithjsonString:responseString];
        successed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
#pragma mark --- 获取积分规则列表
/**
 获取积分规则列表
 
 @param pageIndex 页数
 @param pageSize  每页条数
 @param successed successed
 @param failed    failed
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getPointRuleListPageIndex:(NSInteger)pageIndex
                                       pageSize:(NSInteger)pageSize
                                      successed:(GetPointRuleListSuccessed)successed
                                         failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                      [@(pageIndex) stringValue], @"page",
                                      [@(pageSize) stringValue], @"page_size", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getPointRuleList] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrRule = [NSMutableArray arrayWithCapacity:0];;
        NSInteger code = [self parsePointRuleListWithArrRule:&arrRule jsonStr:responseString];
        successed(code, arrRule);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger)parsePointRuleListWithArrRule:(NSMutableArray **)arrRule jsonStr:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [[jsonDict objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSArray *arrResult = [jsonDict objectForKey:@"result"];
        if (arrResult.count) {
            for (NSDictionary *ruleDict in arrResult) {
                RuleInfo *ruleInfo = [[RuleInfo alloc] init];
                ruleInfo.ruleID = [[ruleDict[@"rule_id"] base64DecodedString] integerValue];
                ruleInfo.ruleName = [ruleDict[@"rule_name"] base64DecodedString];
                ruleInfo.rulePoints = [[ruleDict[@"point"] base64DecodedString] integerValue];
                [*arrRule addObject:ruleInfo];
            }
        }
    }
    return code;
}
/**
 意见反馈
 
 @param userID          用户id
 @param feedBackType    1：功能异常 2，使用建议 3：功能需求 4.系统闪退 5： 检举投诉）
 @param telPhone        手机号码
 @param feedBackContent 反馈内容
 @param succeed   成功
 @param failed      失败
 
 @return NSURLSessionTask
 */
-(NSURLSessionTask *)addFeedBackWithUserID:(NSInteger)userID
                              FeedBackType:(NSInteger)feedBackType
                                  TelPhone:(NSString *)telPhone
                           FeedBackContent:(NSString *)feedBackContent
                                  FilePath:(NSMutableArray *)filePath
                                   Succeed:(AddFeedBackSuccessed)succeed
                                    Failed:(GetDataFailed)failed;{
    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      [@(feedBackType) stringValue], @"feed_back_type",
                                      [NSString stringByReplaceNullString:telPhone],@"tel_phone",
                                      [NSString stringByReplaceNullString:feedBackContent],@"feed_back_content",
                                      nil];
    NSURLSessionTask *op;
    if (filePath.count) {
        op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] uploadBatchFileWithPath:[GlobalFile addFeedBack] filePathArray:filePath parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson key:@"file0" onCompletionHandler:^(NSString *responseString) {
            NSInteger code=[self addFeedBackWithResonseString:responseString];
            succeed(code);
        } onFailHandler:^(NSError *responseError) {
            failed(responseError);
        }];
    }else{
        op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile addFeedBack] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
            NSInteger code = [self addFeedBackWithResonseString:responseString];
            succeed(code);
        } onFailHandler:^(NSError *responseError) {
            failed(responseError);
        }];
    }
    
    return op;
}
- (NSInteger)addFeedBackWithResonseString:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code=[jsonDict[@"code"] integerValue];
    return code;
}
/**
 获取系统消息列表
 
 @param userID   用户ID
 @param page     页数
 @param pageSize 每页显示的条数
 @param successed successed
 @param failed  failed
 
 @return  value
 */
- (NSURLSessionTask *)getMessageListWithUserID:(NSInteger)userID
                                          page:(NSInteger)page
                                      pageSize:(NSInteger)pageSize
                                     successed:(GetMessageListSuccessed)successed
                                        failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue],@"user_id",
                                      [@(page) stringValue],@"page",
                                      [@(pageSize) stringValue],@"page_size",
                                      nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getSystemList] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrMessageList = [[NSMutableArray alloc] init];
        NSInteger code=[self getMessageListWithjsonString:responseString arrMessageList:&arrMessageList];
        successed(code, arrMessageList);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
-(NSInteger)getMessageListWithjsonString:(NSString *)jsonStr arrMessageList:(NSMutableArray **)arrMessageList{
    NSDictionary *dictReuslt = [jsonStr objectFromJSONString];
    NSInteger code = [[dictReuslt objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSMutableArray *arrResult = [dictReuslt objectForKey:@"result"];
        for (NSDictionary *dict in arrResult) {
            MessageInfo *messageInfo = [[MessageInfo alloc] init];
            messageInfo.messageID = [[[dict objectForKey:@"system_id"] base64DecodedString] integerValue];
            messageInfo.messageLogoID = [[[dict objectForKey:@"logo_id"] base64DecodedString] integerValue];
            messageInfo.messageType = [[[dict objectForKey:@"type"] base64DecodedString] integerValue];
            messageInfo.messageState = [[[dict objectForKey:@"state"] base64DecodedString] integerValue];
            messageInfo.messageAddTime = [[dict objectForKey:@"add_time"] base64DecodedString];
            messageInfo.messageTypeStr = [[dict objectForKey:@"type_str"] base64DecodedString];
            messageInfo.messageContent = [[dict objectForKey:@"content"] base64DecodedString];
            messageInfo.messageTitle = [[dict objectForKey:@"title"] base64DecodedString];
            
            [*arrMessageList addObject:messageInfo];
        }
    }
    return code;
}
/**
 单个删除系统消息
 
 @param infoID      系统消息ID
 @param userID      用户ID
 @param successed   succeed
 @param getDataFail failed
 
 @return value
 */
-(NSURLSessionTask *)deleteSingleSystemWithInfoID:(NSInteger)infoID
                                           UserID:(NSInteger)userID
                  DeleteSingleSystemUserSuccessed:(DeleteSingleSystemUserSuccessed)successed
                                      GetDataFail:(GetDataFailed)getDataFail{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(infoID) stringValue],@"info_id",
                                      [@(userID) stringValue],@"user_id",
                                      nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile deleteSinglesSystemUser] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self parseDeleteSystemWithjsonString:responseString];
        successed(code);
    } onFailHandler:^(NSError *responseError) {
        getDataFail(responseError);
    }];
    return op;
}

/**
 清空系统消息
 
 @param userID  用户ID
 @param succeed succeed
 @param fail    failed
 
 @return value
 */
-(NSURLSessionTask *)emptySystemUserInfoWithUserID:(NSInteger)userID
                                           succeed:(EmptySystemUserInfoSuccessed)succeed
                                              Fail:(GetDataFailed)fail{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:userID]],@"user_id",nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile emptySystemUserInfo] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self parseDeleteSystemWithjsonString:responseString];
        succeed(code);
    } onFailHandler:^(NSError *responseError) {
        fail(responseError);
    }];
    return op;
}
- (NSInteger)parseDeleteSystemWithjsonString:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code=[jsonDict[@"code"] integerValue];
    return code;
}
/**
 获取系统消息详情
 
 @param systemID 系统消息ID
 @param successed successed
 @param failed    failed
 
 @return value
 */
- (NSURLSessionTask *)getSystemInfoWithSystemID:(NSInteger)systemID
                                         userID:(NSInteger)userID
                                      successed:(GetSystemInfoSuccessed)successed
                                         failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      [@(systemID) stringValue], @"system_id", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getSystemInfo] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSString *messageContent;
        NSInteger code = [self getSystemInfoWithJsonString:responseString messageContent:&messageContent];
        successed(code, messageContent);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
-(NSInteger)getSystemInfoWithJsonString:(NSString *)jsonStr messageContent:(NSString **)messageContent{
    NSDictionary *dictionary=[jsonStr objectFromJSONString];
    NSInteger code = [[dictionary objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSDictionary *dicResult = [dictionary objectForKey:@"result"];
        *messageContent = [[dicResult objectForKey:@"content"] base64DecodedString];
    }
    return code;
}

/**
 我的广告
 
 @param userID            用户ID
 @param page              第几页
 @param pageSize          每页显示几条
 @param isShelvesStr      是否上架：0：已下架，1：展示中，即将上架传空
 @param successed         成功
 @param failed            失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getRedAdvertListWithUserID:(NSInteger)userID
                                            page:(NSInteger)page
                                        pageSize:(NSInteger)pageSize
                                    isShelvesStr:(NSString *)isShelvesStr
                                       successed:(GetRedAdvertListSuccessed)successed
                                          failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      [@(page) stringValue], @"page",
                                      [@(pageSize) stringValue], @"page_size",
                                      isShelvesStr, @"is_shelves", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getRedAdvertListUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrData = [NSMutableArray arrayWithCapacity:0];
        NSInteger code = [self parseGetRedAdvertListResultToArrData:&arrData jsonStr:responseString];
        successed(code, arrData);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger)parseGetRedAdvertListResultToArrData:(NSMutableArray **)arrData jsonStr:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSArray *arrResult = jsonDict[@"result"];
        if (arrResult.count) {
            for (NSDictionary *dict in arrResult) {
                AdvertInfo *advertInfo = [[AdvertInfo alloc] init];
                advertInfo.advertID = [[dict[@"red_advert_id"] base64DecodedString] integerValue];
                advertInfo.advertType = [[dict[@"red_advert_type"] base64DecodedString] integerValue];
                advertInfo.advertImg = [dict[@"big_img"] base64DecodedString];
                advertInfo.advertBeginTime = [dict[@"start_time"] base64DecodedString];
                advertInfo.advertEndTime = [dict[@"end_time"] base64DecodedString];
                
                [*arrData addObject:advertInfo];
            }
        }
    }
    return code;
}

/**
 分享地址
 
 @param successed         成功
 @param failed            失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getShareAddressSuccessed:(GetShareAddressSuccessed)successed
                                        failed:(GetDataFailed)failed {
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile shareUrlName] parmarDic:nil method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSString *shareAddress;
        NSInteger code = [self parseGetShareAddressResultToShareAddress:&shareAddress jsonStr:responseString];
        successed(code, shareAddress);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger)parseGetShareAddressResultToShareAddress:(NSString **)shareAddress jsonStr:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSDictionary *resultDict = jsonDict[@"result"];

        *shareAddress = [resultDict[@"share_address"] base64DecodedString];
    }
    return code;
}

/**
 我的打赏申请（商家/代理商）
 
 @param userID    用户id
 @param page      第几页
 @param pageSize  页数
 @param mark      打赏状态【-1:全部（默认） 1：申请中，2：已打赏，3：已拒绝】
 @param userType  角色类型（ 1：商家 2：供货商）
 @param successed successed
 @param failed    failed
 
 @return value
 */
-(NSURLSessionTask *)getApplyRedListWithUserID:(NSInteger)userID
                                          Page:(NSInteger)page
                                      PageSize:(NSInteger)pageSize
                                          Mark:(NSInteger)mark
                                      UserType:(NSInteger)userType
                                        InfoID:(NSInteger)infoID
                                       Succeed:(GetMessageListSuccessed)successed
                                        Failed:(GetDataFailed)failed{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue],@"user_id",
                                      [@(page) stringValue],@"page",
                                      [@(pageSize) stringValue],@"page_size",
                                      [@(mark) stringValue],@"mark",
                                      [@(userType) stringValue],@"user_type",
                                      [@(infoID) stringValue],@"info_id",
                                      nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getApplyRedList] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrApplyList = [[NSMutableArray alloc] init];
        NSInteger code=[self getApplyRedListWithjsonString:responseString arrApplyList:&arrApplyList];
        successed(code, arrApplyList);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
-(NSInteger)getApplyRedListWithjsonString:(NSString *)jsonStr arrApplyList:(NSMutableArray **)arrApplyList{
    NSDictionary *dictReuslt = [jsonStr objectFromJSONString];
    NSInteger code = [[dictReuslt objectForKey:@"code"] integerValue];
    if (code == 100) {
        NSMutableArray *arrResult = [dictReuslt objectForKey:@"result"];
        for (NSDictionary *dict in arrResult) {
            RewardInfo *rewardInfo = [[RewardInfo alloc] init];
            rewardInfo.rewardID = [[[dict objectForKey:@"applyred_id"] base64DecodedString] integerValue];
            rewardInfo.rewardAmount = [[[dict objectForKey:@"applyred_amount"] base64DecodedString] floatValue];
            rewardInfo.rewardState = [[[dict objectForKey:@"apply_red_state"] base64DecodedString] integerValue];
            rewardInfo.rewardAddTime = [[dict objectForKey:@"add_time"] base64DecodedString];
            rewardInfo.rewardStateStr = [[dict objectForKey:@"apply_red_state_str"] base64DecodedString];
            rewardInfo.rewardRedAdvertID = [[[dict objectForKey:@"red_advert_id"] base64DecodedString] integerValue];
            rewardInfo.userInfo.userID = [[[dict objectForKey:@"merchant_user_id"] base64DecodedString] integerValue];
            rewardInfo.userInfo.userHeadImg = [[dict objectForKey:@"head_image"] base64DecodedString];
            rewardInfo.userInfo.userNickName = [[dict objectForKey:@"nick_name"] base64DecodedString];
            rewardInfo.userInfo.userLoginName = [[dict objectForKey:@"login_name"] base64DecodedString];
            rewardInfo.rewardNoPassReason = [[dict objectForKey:@"no_pass_reason"] base64DecodedString];
            
            [*arrApplyList addObject:rewardInfo];
        }
    }
    return code;
}
/**
 删除申请打赏信息
 
 @param userType   用户类型【1：商家 2：代理商】
 @param applyredID 打赏申请id
 @param successed successed
 @param failed    failed
 
 @return value
 */
-(NSURLSessionTask *)deleteApplyRedInfoWithUserType:(NSInteger)userType
                                         ApplyredID:(NSInteger)applyredID
                                            Succeed:(DeleteApplyRedInfoSuccessed)successed
                                             Failed:(GetDataFailed)failed{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userType) stringValue],@"user_type",
                                      [@(applyredID) stringValue],@"applyred_id",
                                      nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile deleteApplyRedInfo] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self parseDeleteApplyRedInfoWithjsonString:responseString];
        successed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger)parseDeleteApplyRedInfoWithjsonString:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code=[jsonDict[@"code"] integerValue];
    return code;
}
/**
 修改申请打赏状态
 
 @param userID       供货商id
 @param userType     1:商家 2:供货商
 @param applyRedID   未通过原因
 @param noPassReason 1：同意打赏 2：拒绝打赏
 @param mark         打赏id
 @param successed successed
 @param failed    failed
 
 @return value
 */
-(NSURLSessionTask *)editApplyRedInfoWithUserID:(NSInteger)userID
                                       UserType:(NSInteger)userType
                                     ApplyRedID:(NSInteger)applyRedID
                                   NoPassReason:(NSString *)noPassReason
                                           Mark:(NSInteger)mark
                                        Succeed:(EditApplyRedInfoSuccessed)successed
                                         Failed:(GetDataFailed)failed{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue],@"user_id",
                                      [@(userType) stringValue],@"user_type",
                                      [@(applyRedID) stringValue],@"applyred_id",
                                      [NSString stringByReplaceNullString:noPassReason],@"no_pass_reason",
                                      [@(mark) stringValue],@"mark",
                                      nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile editApplyRedInfo] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self parseEditApplyRedInfoWithjsonString:responseString];
        successed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}
- (NSInteger)parseEditApplyRedInfoWithjsonString:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code=[jsonDict[@"code"] integerValue];
    return code;
}

@end
