//
//  HHSoftLocationRegionInfo.h
//  FrameTest
//
//  Created by dgl on 15-6-2.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HHSoftLocationRegionInfo : NSObject<NSCoding>
/**
 *  经度
 */
@property (nonatomic,assign) CGFloat longitude;
/**
 *  纬度
 */
@property (nonatomic,assign) CGFloat latitude;

@property (nonatomic,copy) NSString *countryName;
@property (nonatomic,copy) NSString *provinceName;
@property (nonatomic,copy) NSString *cityName;
@property (nonatomic,copy) NSString *districtName;

-(id)init;

@end
