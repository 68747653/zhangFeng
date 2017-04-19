//
//  HHSoftEncrypt.h
//  HHSoftFrameWorkKit
//
//  Created by dgl on 15-3-9.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHSoftEncrypt : NSObject
#pragma mark -使用默认加密Key的加密方式加密
/**
 *  使用默认加密Key的加密方式加密
 *
 *  @param sourceString 源字符串
 *
 *  @return 加密过后的字符串*/
+(NSString *)EncryptString:(NSString *)sourceString;
/**
 *  使用默认加密Key的方式解密
 *
 *  @param sourceString 加密过后的字符串
 *
 *  @return 解密过后的字符串
 */
#pragma mark -使用默认加密Key的方式解密
+(NSString *)DecryptString:(NSString *)sourceString;

/**
 *  使用自定义Key的方式进行加密
 *
 *  @param key          加密的Key值
 *  @param sourceString 源字符串
 *
 *  @return 加密过后的字符串
 */
#pragma mark -使用自定义Key的方式进行加密
+(NSString *)EncryptStringWithKey:(NSString *)key andSourceString:(NSString *)sourceString;
/**
 *  使用自定义Key的方式进行解密
 *
 *  @param key          解密的Key值
 *  @param sourceString 加密过后的字符串
 *
 *  @return 解密过后的字符串
 */
#pragma mark -使用自定义Key的方式进行解密
+(NSString *)DecryptStringWithKey:(NSString *)key andSourceString:(NSString *)sourceString;

/**
 *  获取16位小写的MD5加密过后的字符串
 *
 *  @param sourceString 源字符串
 *
 *  @return 加密过后的字符串
 */
#pragma mark -取16位小写的MD5加密过后的字符串
+(NSString *)MD5SixTeenEncryptString:(NSString *)sourceString;
/**
 *  获取32位的小写MD5加密过后的字符串
 *
 *  @param sourceString 源字符串
 *
 *  @return 加密过后的字符串
 */
#pragma mark -获取32位的小写MD5加密过后的字符串
+(NSString *)Md5ThirtyTwoEnctyptString:(NSString *)sourceString;


@end
