//
//  HHSoftAppDelegate.h
//  HHSoftFrameWorkKit
//
//  Created by dgl on 15-5-13.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReceIveRemoteNotificationBlock)(NSDictionary *userInfo);
typedef void(^RegistRemoteNotificationSuccessedBlock)();
typedef void(^RegistRemoteNotificationFailBolck)();


@interface HHSoftAppDelegate : UIResponder<UIApplicationDelegate>
/**
 *  注册通知
 *
 *  @param receiveRemoteNotificationBlock 获取通知后的处理
 */
-(void)registerRemoteNotification:(ReceIveRemoteNotificationBlock)receiveRemoteNotificationBlock registRemoteNotificationSuccessedBlock:(RegistRemoteNotificationSuccessedBlock)registRemoteNotificationSuccessedBlock registRemoteNotificationFailBolck:(RegistRemoteNotificationFailBolck)registRemoteNotificationFailBolck;
/**
 *  获取手机deviceToken
 *
 *  @return NSString
 */
+(NSString *)deviceToken;

/**
 *  判断用户是否开启了远程通知
 *
 *  @return BOOL
 */
+(BOOL)isUserAllowedNotification;

@end
