//
//  RegionInfo.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegionInfo : NSObject

/**
 地区ID
 */
@property (nonatomic, assign) NSInteger regionID;

/**
 地区名
 */
@property (nonatomic, copy) NSString *regionName;

/**
 下级城市数量
 */
@property (nonatomic, assign) NSInteger regionChildCount;

/**
 省ID
 */
@property (nonatomic, assign) NSInteger provinceID;

/**
 省名
 */
@property (nonatomic, copy) NSString *provinceName;

/**
 保存最新地区位置
 
 @param regionInfo 地区信息
 */
+ (void)setRegionInfo:(RegionInfo *)regionInfo;

/**
 获取地区信息
 
 @return RegionInfo
 */
+ (RegionInfo *)getRegionInfo;

@end
