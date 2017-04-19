//
//  LocationInfo.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/7.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "LocationInfo.h"
#import <HHSoftFrameWorkKit/HHSoftDefaults.h>

@interface LocationInfo () <NSCoding>

@end

@implementation LocationInfo

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _lat = [aDecoder decodeDoubleForKey:@"hhsoft_lat"];
        _lng = [aDecoder decodeDoubleForKey:@"hhsoft_lng"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeDouble:_lat forKey:@"hhsoft_lat"];
    [aCoder encodeDouble:_lng forKey:@"hhsoft_lng"];
}

/**
 保存最新一次的位置
 
 @param locationInfo 位置信息
 */
+ (void)setLocationInfo:(LocationInfo *)locationInfo {
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:locationInfo];
    HHSoftDefaults *defaults=[[HHSoftDefaults alloc] init];
    [defaults saveObject:data forKey:@"LocationInfo_locationInfo"];
}

/**
 获取位置信息
 
 @return LocationInfo
 */
+ (LocationInfo *)getLocationInfo {
    HHSoftDefaults *defaults=[[HHSoftDefaults alloc] init];
    LocationInfo *locationInfo;
    NSData *data=[defaults objectForKey:@"LocationInfo_locationInfo"];
    locationInfo=(LocationInfo *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (!locationInfo) {
        locationInfo = [[LocationInfo alloc] init];
    }
    locationInfo.lat=locationInfo.lat == 0?31.135632:locationInfo.lat;
    locationInfo.lng=locationInfo.lng == 0?121.524632:locationInfo.lng;
    return locationInfo;
}

@end
