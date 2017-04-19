//
//  UserInfoEngine.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "UserInfoEngine.h"
#import <HHSoftFrameWorkKit/HHSoftDefaults.h>
#import "UserInfo.h"

@implementation UserInfoEngine

/**
 获取保存在本地的用户信息
 
 @return UserInfo
 */
+ (UserInfo *)getUserInfo {
    HHSoftDefaults *defaults = [[HHSoftDefaults alloc] init];
    NSData *data = [defaults objectForKey:@"user_userInfo"];
    UserInfo *userInfo = (UserInfo *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return userInfo;
}

/**
 保存用户信息
 
 @param userInfo 用户信息
 */
+ (void)setUserInfo:(UserInfo *)userInfo {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    HHSoftDefaults *defaults = [[HHSoftDefaults alloc] init];
    [defaults saveObject:data forKey:@"user_userInfo"];
}

/**
 是否登录
 
 @return BOOL
 */
+ (BOOL)isLogin {
    if ([self getUserInfo].userID) {
        return YES;
    }
    return NO;
}

/**
 获取登录信息（账号）key:@"user_userLoginName"
 
 @return 登录信息（账号）
 */
+ (NSDictionary *)getUserLoginDict {
    HHSoftDefaults *defaults = [[HHSoftDefaults alloc] init];
    NSData *data = [defaults objectForKey:@"login_userInfo"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

/**
 保存登录信息（账号）
 
 @param loginDict 登录信息（账号）
 */
+ (void)setUserLoginDict:(NSDictionary *)loginDict {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:loginDict];
    HHSoftDefaults *defaults = [[HHSoftDefaults alloc] init];
    [defaults saveObject:data forKey:@"login_userInfo"];
}

/**
 获取保存在本地的注册信息
 
 @return UserInfo
 */
+ (UserInfo *)getRegisterUserInfo {
    HHSoftDefaults *defaults = [[HHSoftDefaults alloc] init];
    NSData *data = [defaults objectForKey:@"register_userInfo"];
    UserInfo *userInfo = (UserInfo *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return userInfo;
}

/**
 保存注册信息
 
 @param userInfo 用户注册信息
 */
+ (void)setRegisterUserInfo:(UserInfo *)userInfo {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    HHSoftDefaults *defaults = [[HHSoftDefaults alloc] init];
    [defaults saveObject:data forKey:@"register_userInfo"];
}

@end
