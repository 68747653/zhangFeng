//
//  NSString+HHSoftBase64.h
//  HHSoftFrameWorkKit
//
//  Created by dgl on 15-3-6.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HHSoftEncode)

/**
 *  将Base64编码的字符串实例化一个的普通的字符串（直接解码了）
 *
 *  @param NSString base64编码的字符串
 *
 *  @return
 */
#pragma mark -将Base64编码的字符串实例化一个的普通的字符串（直接解码了）
+ (NSString *)stringWithBase64EncodedString:(NSString *)base64String;
/**
 *  字符串进行Base64编码后按照wrapWidth的长度进行换行
 *
 *  @param wrapWidth 每行展示的字符串的长度
 *
 *  @return 换行后的字符串
 */
#pragma mark -字符串进行Base64编码后按照wrapWidth的长度进行换行
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
/**
 *  字符串进行Base64的编码
 *
 *  @return 编码后的字符串
 */
#pragma mark -字符串进行Base64的编码
- (NSString *)base64EncodedString;
/**
 *  字符串进行Base64的解码
 *
 *  @return 解码后的字符串
 */
#pragma mark -字符串进行Base64的解码
- (NSString *)base64DecodedString;
/**
 *  将Base64的字符串转换为Base64编码的NSdata
 *
 *  @return NSData
 */
#pragma mark -将Base64的字符串转换为Base64编码的NSdata
- (NSData *)base64DecodedData;

/**
 *  url编码
 *
 *  @return NSString
 */
#pragma mark -url编码
- (NSString *)URLEncodedString;
/**
 *  url解码
 *
 *  @return NSString
 */
#pragma mark -url解码
- (NSString *)URLDecodedString;


@end
