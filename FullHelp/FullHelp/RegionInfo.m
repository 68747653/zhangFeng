//
//  RegionInfo.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "RegionInfo.h"
#import <HHSoftFrameWorkKit/HHSoftDefaults.h>

@interface RegionInfo () <NSCoding>

@end

@implementation RegionInfo

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _provinceID = [aDecoder decodeIntegerForKey:@"regionInfo_provinceID"];
        _provinceName = [aDecoder decodeObjectForKey:@"regionInfo_provinceName"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:_provinceID forKey:@"regionInfo_provinceID"];
    [aCoder encodeObject:_provinceName forKey:@"regionInfo_provinceName"];
}

/**
 保存最新地区位置
 
 @param regionInfo 地区信息
 */
+ (void)setRegionInfo:(RegionInfo *)regionInfo {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:regionInfo];
    HHSoftDefaults *defaults = [[HHSoftDefaults alloc] init];
    [defaults saveObject:data forKey:@"RegionInfo_regionInfo"];
}

/**
 获取地区信息
 
 @return RegionInfo
 */
+ (RegionInfo *)getRegionInfo {
    HHSoftDefaults *defaults = [[HHSoftDefaults alloc] init];
    NSData *data = [defaults objectForKey:@"RegionInfo_regionInfo"];
    RegionInfo *regionInfo = (RegionInfo *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return regionInfo;
}

@end
