//
//  UserLoginNetWorkEngine.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "UserLoginNetWorkEngine.h"
#import <HHSoftFrameWorkKit/HHSoftJSONKit.h>
#import <HHSoftFrameWorkKit/HHSoftEncrypt.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftEncode.h>
#import "GlobalFile.h"
#import "UserInfo.h"
#import "RegionInfo.h"
#import "IndustryInfo.h"
#import "UserInfoEngine.h"

@implementation UserLoginNetWorkEngine

/**
 登录
 
 @param loginName     登录名
 @param loginPassword 登录密码
 @param deviceType    设备类型（0：android 1：ios）
 @param deviceToken   设备号
 @param successed     成功
 @param failed        失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)userLoginWithLoginName:(NSString *)loginName
                               loginPassword:(NSString *)loginPassword
                                  deviceType:(NSInteger)deviceType
                                 deviceToken:(NSString *)deviceToken
                                   successed:(UserLoginSuccessed)successed
                                      failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      loginName, @"login_name",
                                      [HHSoftEncrypt Md5ThirtyTwoEnctyptString:[HHSoftEncrypt Md5ThirtyTwoEnctyptString:loginPassword]], @"login_pwd",
                                      [@(deviceType) stringValue], @"device_type",
                                      deviceToken, @"device_token", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile userLoginUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        UserInfo *userInfo;
        NSInteger code = [self parseUserLoginResultToUserInfoModel:&userInfo jsonStr:responseString];
        //100:登录成功,101:登录失败,102:网络连接失败,103:手机号码错误，104：该用户不存在，105：密码错误,100001:网络连接异常,请稍后重试
        successed(code, userInfo);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger)parseUserLoginResultToUserInfoModel:(UserInfo **)userInfoModel jsonStr:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSDictionary *resultDict = jsonDict[@"result"];
        
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userID = [[resultDict[@"user_id"] base64DecodedString] integerValue];
        userInfo.userType = [[resultDict[@"user_type"] base64DecodedString] integerValue];
        userInfo.userNickName = [resultDict[@"nick_name"] base64DecodedString];
        userInfo.userHeadImg = [resultDict[@"head_image"] base64DecodedString];
//        userInfo.userRedNum = 10;
        userInfo.userRedNum = [[resultDict[@"remain_red_num"] base64DecodedString] integerValue];
        userInfo.userProvinceID = [[resultDict[@"province_id"] base64DecodedString] integerValue];
        userInfo.userProvinceName = [resultDict[@"province_name"] base64DecodedString];
        userInfo.userIndustryID = [[resultDict[@"industry_id"] base64DecodedString] integerValue];
        userInfo.userIndustryName = [resultDict[@"industry_name"] base64DecodedString];
        
        *userInfoModel = userInfo;
    }
    return code;
}

/**
 注册
 
 @param userInfo      用户信息
 @param loginName     登录名
 @param verifyCode    验证码
 @param loginPassword 登录密码
 @param deviceType    设备类型（0：android 1：ios）
 @param deviceToken   设备号
 @param successed     成功
 @param failed        失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)userRegisterWithUserInfo:(UserInfo *)userInfo
                                     loginName:(NSString *)loginName
                                    verifyCode:(NSString *)verifyCode
                                 loginPassword:(NSString *)loginPassword
                                    deviceType:(NSInteger)deviceType
                                   deviceToken:(NSString *)deviceToken
                                     successed:(UserRegisterSuccessed)successed
                                        failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userInfo.userType) stringValue], @"usert_ype",
                                      [@(userInfo.userProvinceID) stringValue], @"province_id",
                                      [@(userInfo.userCityID) stringValue], @"city_id",
                                      [@(userInfo.userDistrictID) stringValue], @"district_id",
                                      [@(userInfo.userIndustryID) stringValue], @"industry_id",
                                      loginName, @"login_name",
                                      verifyCode, @"verify_code",
                                      [HHSoftEncrypt Md5ThirtyTwoEnctyptString:[HHSoftEncrypt Md5ThirtyTwoEnctyptString:loginPassword]], @"login_pwd",
                                      [@(deviceType) stringValue], @"device_type",
                                      deviceToken, @"device_token", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile userRegisterUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        UserInfo *userInfo;
        NSInteger code = [self parseUserLoginResultToUserInfoModel:&userInfo jsonStr:responseString];
        //100:注册成功,101:注册失败,102:参数错误,103：手机号格式错误 ，104：验证码错误，105：验证码超时，106：用户已存在，100001:网络连接异常,请稍后重试
        successed(code, userInfo);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

/**
 忘记密码
 
 @param userTel       手机号
 @param verifyCode    验证码
 @param newPassword   新密码
 @param successed     成功
 @param failed        失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)updatePasswordWithUserTel:(NSString *)userTel
                                     verifyCode:(NSString *)verifyCode
                                    newPassword:(NSString *)newPassword
                                      successed:(UpdatePasswordSuccessed)successed
                                         failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      userTel, @"user_tel",
                                      verifyCode, @"verify_code",
                                      [HHSoftEncrypt Md5ThirtyTwoEnctyptString:[HHSoftEncrypt Md5ThirtyTwoEnctyptString:newPassword]], @"new_login_pwd", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile userFindPasswordUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self parseUpdatePasswordResultWithJsonStr:responseString];
        //100：成功，101：失败，102：参数错误，103:手机号格式错误 104：不存在此用户 105：验证码错误 106：验证码超时 100001：网络接连异常，请稍后再试
        successed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger)parseUpdatePasswordResultWithJsonStr:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    return code;
}

/**
 地区列表
 
 @param pID           父级城市ID
 @param layerID       级别ID（0：国家；1：省；2：市；3：县（区））
 @param successed     成功
 @param failed        失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getRegionListWithPID:(NSInteger)pID
                                   layerID:(NSInteger)layerID
                                 successed:(GetRegionListSuccessed)successed
                                    failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@([UserInfoEngine getRegisterUserInfo].userType) stringValue], @"user_type",
                                      [@(pID) stringValue], @"pid",
                                      [@(layerID) stringValue], @"layer_id", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getRegionListUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
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
                regionInfo.regionChildCount = [[regionDict[@"child_count"] base64DecodedString] integerValue];
                regionInfo.regionName = [regionDict[@"region_name"] base64DecodedString];
                
                [*arrData addObject:regionInfo];
            }
        }
    }
    return code;
}

/**
 行业列表
 
 @param regionID      地区ID
 @param successed     成功
 @param failed        失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getIndustryListWithRegionID:(NSInteger)regionID
                                        successed:(GetIndustryListSuccessed)successed
                                           failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(regionID) stringValue], @"region_id", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getIndustryListUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSMutableArray *arrData = [NSMutableArray arrayWithCapacity:0];
        NSInteger code = [self parseGetIndustryListResultToArrData:&arrData jsonStr:responseString];
        //100：成功，101：失败，102：参数错误，100001：网络接连异常
        successed(code, arrData);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger)parseGetIndustryListResultToArrData:(NSMutableArray **)arrData jsonStr:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSArray *arrResult = jsonDict[@"result"];
        if (arrResult.count) {
            for (NSDictionary *regionDict in arrResult) {
                IndustryInfo *industryInfo = [[IndustryInfo alloc] init];
                industryInfo.industryID = [[regionDict[@"industry_id"] base64DecodedString] integerValue];
                industryInfo.industryName = [regionDict[@"industry_name"] base64DecodedString];
                
                [*arrData addObject:industryInfo];
            }
        }
    }
    return code;
}

/**
 获取验证码
 
 @param userTel       手机号
 @param requestType   0：验证手机号是否存在（已存在返回104，用于eg:注册），1：验证手机号是否存在（不存在返回105，用于eg:找回密码），2：普通
 @param successed     成功
 @param failed        失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getVerifyCodeWithUserTel:(NSString *)userTel
                                   requestType:(NSInteger)requestType
                                     successed:(GetVerifyCodeSuccessed)successed
                                        failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      userTel, @"user_tel",
                                      [@(requestType) stringValue], @"request_type", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getVerifyCodeUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self parseUpdatePasswordResultWithJsonStr:responseString];
        //100:成功,101:失败,102:参数错误,103:手机号格式错误,104:用户已存在,105:用户不存在,100001:网络连接异常,请稍后重试
        successed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

/**
 获取使用帮助
 
 @param helpID        使用帮助ID
 @param successed     成功
 @param failed        失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getUserHelpWithHelpID:(NSInteger)helpID
                                  successed:(GetUserHelpSuccessed)successed
                                     failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(helpID) stringValue], @"helper_id", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile getUserHelpUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSString *detailUrl;
        NSInteger code = [self parseGetHelpResultToDetailUrl:&detailUrl jsonStr:responseString];
        successed(code, detailUrl);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

- (NSInteger)parseGetHelpResultToDetailUrl:(NSString **)detailUrl jsonStr:(NSString *)jsonStr {
    NSDictionary *jsonDict = [jsonStr objectFromJSONString];
    NSInteger code = [jsonDict[@"code"] integerValue];
    if (code == 100) {
        NSDictionary *resultDict = jsonDict[@"result"];
        
        *detailUrl = [resultDict[@"detail_url"] base64DecodedString];
    }
    return code;
}

/**
 更新设备状态
 
 @param userID        用户ID
 @param deviceType    设备类型（0：android 1：ios）
 @param deviceToken   设备号
 @param successed     成功
 @param failed        失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)updateDeviceStateWithUserID:(NSInteger)userID
                                       deviceType:(NSInteger)deviceType
                                      deviceToken:(NSString *)deviceToken
                                        successed:(UpdateDeviceStateSuccessed)successed
                                           failed:(GetDataFailed)failed {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      [@(userID) stringValue], @"user_id",
                                      [@(deviceType) stringValue], @"device_type",
                                      deviceToken, @"device_token", nil];
    NSURLSessionTask *op = [[HHSoftNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:[GlobalFile updateDeviceStateUrl] parmarDic:paramDict method:HttpPost paraMethod:ParaJson returnValueMethod:ReturnJson onCompletionHandler:^(NSString *responseString) {
        NSInteger code = [self parseUpdatePasswordResultWithJsonStr:responseString];
        //code 100：成功，101：失败，102：网络连接失败，100001：网络接连异常，请稍后再试
        successed(code);
    } onFailHandler:^(NSError *responseError) {
        failed(responseError);
    }];
    return op;
}

@end
