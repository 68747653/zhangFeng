//
//  NSDate+HHSoftAddition.h
//  HHSoftFrameWorkKit
//
//  Created by dgl on 15-3-9.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HHSoftAddition)
/**
 *  将日期转化为以斜杠分开的时间格式
 *
 *  @return 2015/03/18 13:25:34
 */
-(NSString *)stringDateByHHSoftDefaultFormate;

/**
 *  将日期转化为字符串。
 *  @param  format:转化格式，形如@"yyyy年MM月dd日hh时mm分ss秒"。
 *  return  返回转化后的字符串。
 */
- (NSString *)convertDateToStringWithFormat:(NSString *)format;

/**
 *  距离当前的时间间隔描述
 *
 *  @return 
 */
- (NSString *)timeIntervalDescription;//

@end
