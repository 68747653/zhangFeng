//
//  UserInfoEngine.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserInfo;

@interface UserInfoEngine : NSObject

/**
 获取保存在本地的用户信息

 @return UserInfo
 */
+ (UserInfo *)getUserInfo;

/**
 保存用户信息

 @param userInfo 用户信息
 */
+ (void)setUserInfo:(UserInfo *)userInfo;

/**
 是否登录

 @return BOOL
 */
+ (BOOL)isLogin;

/**
 获取登录信息（账号）key:@"user_userLoginName"

 @return 登录信息（账号）
 */
+ (NSDictionary *)getUserLoginDict;

/**
 保存登录信息（账号）

 @param loginDict 登录信息（账号）
 */
+ (void)setUserLoginDict:(NSDictionary *)loginDict;

/**
 获取保存在本地的注册信息
 
 @return UserInfo
 */
+ (UserInfo *)getRegisterUserInfo;

/**
 保存注册信息
 
 @param userInfo 用户注册信息
 */
+ (void)setRegisterUserInfo:(UserInfo *)userInfo;

@end
