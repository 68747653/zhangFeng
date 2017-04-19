//
//  NSData+HHSoftBase64.h
//  HHSoftFrameWorkKit
//
//  Created by dgl on 15-3-6.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (HHSoftBase64)

/**
 *  根据Base64编码后的字符串获取NSData数据
 *
 *  @param string Base64编码后的字符串
 *
 *  @return NSData
 */
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
/**
 *  将NSData转换为Base64后的字符串并按照wrapWidth换行
 *
 *  @param wrapWidth 换行的字符串的长度
 *
 *  @return NSString
 */
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
/**
 *  将NSData数据进行Base64编码
 *
 *  @return NSString
 */
- (NSString *)base64EncodedString;

@end
