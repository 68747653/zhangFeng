//
//  HHSoftAppInfo.h
//  HHSoftFrameWorkKit
//
//  Created by dgl on 15-3-9.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HHSoftAppInfo : NSObject

/**
 *  app的展示名称（DisplayName）
 *
 *  @return
 */
+(NSString *)AppName;
/**
 *  app的编译版本
 *
 *  @return
 */
+(NSString *)AppBuildVersion;
/**
 *  app发布到APPStore的版本
 *
 *  @return
 */
+(NSString *)AppVersion;
/**
 *  app的唯一标识(e.g.:com.hhsoft.test)
 *
 *  @return
 */
+(NSString *)AppBundleIdentifer;
/**
 *  版本更新
 *
 *  @param newVersion 新版本
 *
 *  @return Yes=需要更新； No= 不需要更新
 */
+(BOOL)IsShouldUpdateAppToNewVersion:(NSString *)newVersion;
/**
 *  获取当前手机的SDK的版本
 *
 *  @return
 */
+(CGFloat)AppSdkVersion;

/**
 *  获取当前手机屏幕的大小
 *
 *  @return CGSize
 */
+(CGSize)AppScreen;
/**
 *  获取系统默认的深颜色的字体
 *
 *  @return UIColor
 */
+(UIColor *)defaultDeepSystemColor;
/**
 *  获取系统默认的浅色字体
 *
 *  @return UIColor
 */
+(UIColor *)defaultLightSystemColor;





@end
