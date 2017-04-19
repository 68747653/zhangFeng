//
//  AddressInfo.h
//  FullHelp
//
//  Created by hhsoft on 17/2/7.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AddressInfo : NSObject

/**
 地址
 */
@property (nonatomic,copy) NSString *addressDetail;

/**
 门牌号
 */
@property (nonatomic, copy) NSString *addressHouseNumber;

/**
 纬度
 */
@property (nonatomic,assign) double addressLatitude;

/**
 经度
 */
@property (nonatomic,assign) double addressLongitude;

@property (nonatomic, strong) UIFont *addressFont;
@property (nonatomic, assign) CGSize addressSize;

/**
 地址 门牌号
 */
@property (nonatomic, copy) NSString *address;
@end
