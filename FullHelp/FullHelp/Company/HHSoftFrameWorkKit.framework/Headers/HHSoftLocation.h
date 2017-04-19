//
//  HHSoftLocation.h
//  HHSoftFrameWorkKit
//
//  Created by dgl on 15-6-2.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HHSoftLocationRegionInfo;

typedef void(^UpdateLocationSuccess)(HHSoftLocationRegionInfo *hhsoftLocationRegionInfo);
typedef void(^UpdateLocationFail)(NSError *error);

@interface HHSoftLocation : NSObject

/**
 *  位置信息，国家、省、市、县/区
 */
@property (nonatomic,strong) HHSoftLocationRegionInfo *hhsoftLocationRegionInfo;

/**
 *  初始化
 *
 *  @return
 */
-(id)init;

/**
 *  开始定位
 */
-(void)startUpdateLocationWithUpdateSuccessBlock:(UpdateLocationSuccess)updateSuccessBlock andUpdateLocationFail:(UpdateLocationFail)updateLocationFailBlock;

/**
 *  停止定位
 */
-(void)stopUpdateLocation;

/**
 *  检测用户是否开启位置信息服务
 */
+(void)detectIsUserOpenLocationService;
/**
 *  位置信息，国家、省、市、县/区
 */
+(HHSoftLocationRegionInfo *)localRegionInfo;

@end


