//
//  UserLoginNetWorkEngine.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftNetWorkEngine.h>

@class UserInfo;

//登录
typedef void(^UserLoginSuccessed)(NSInteger code, UserInfo *userInfo);

//注册
typedef void(^UserRegisterSuccessed)(NSInteger code, UserInfo *userInfo);

//忘记密码
typedef void(^UpdatePasswordSuccessed)(NSInteger code);

//地区列表
typedef void(^GetRegionListSuccessed)(NSInteger code, NSMutableArray *arrRegion);

//行业列表
typedef void(^GetIndustryListSuccessed)(NSInteger code, NSMutableArray *arrIndustry);

//获取验证码
typedef void(^GetVerifyCodeSuccessed)(NSInteger code);

//获取使用帮助
typedef void(^GetUserHelpSuccessed)(NSInteger code, NSString *detailUrl);

//更新设备状态
typedef void(^UpdateDeviceStateSuccessed)(NSInteger code);

//获取数据失败
typedef void(^GetDataFailed)(NSError *error);

@interface UserLoginNetWorkEngine : HHSoftNetWorkEngine

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
                                      failed:(GetDataFailed)failed;

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
                                        failed:(GetDataFailed)failed;

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
                                         failed:(GetDataFailed)failed;

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
                                    failed:(GetDataFailed)failed;

/**
 行业列表
 
 @param regionID      地区ID
 @param successed     成功
 @param failed        失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getIndustryListWithRegionID:(NSInteger)regionID
                                        successed:(GetIndustryListSuccessed)successed
                                           failed:(GetDataFailed)failed;

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
                                        failed:(GetDataFailed)failed;

/**
 获取使用帮助
 
 @param helpID        使用帮助ID
 @param successed     成功
 @param failed        失败
 
 @return NSURLSessionTask
 */
- (NSURLSessionTask *)getUserHelpWithHelpID:(NSInteger)helpID
                                  successed:(GetUserHelpSuccessed)successed
                                     failed:(GetDataFailed)failed;

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
                                           failed:(GetDataFailed)failed;

@end
