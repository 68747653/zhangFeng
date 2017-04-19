//
//  NSString+HHSoftAddition.h
//  HHSoftFrameWorkKit
//
//  Created by dgl on 15-3-9.
//  Copyright (c) 2015年 hhsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (HHSoftAddition)

#pragma mark ---------------------------常用字符串操作
/**
 *  判断是否为空字符串和是否为空指针（注意：这个判断如果字符串是nil的话，返回0）
 *
 *  @return bool
 */
#pragma mark -判断是否为空字符串和是否为空指针收（注意：这个判断如果字符串是nil的话，返回0）
+(BOOL)IsNullOrEmptyString:(NSString *)aString;
/**
 *  替换空指针为空字符串
 *
 *  @return string
 */
#pragma mark -替换空指针为空字符串
+(NSString *)stringByReplaceNullString:(NSString *)aString;
/**
 *  替换空指针为字符串@"0"
 *
 *  @param aString 需要替换的字符串
 *
 *  @return 替换后的字符串
 */
#pragma mark -替换空指针为字符串@"0"
+(NSString *)stringByReplaceToZeroStringWithNullString:(NSString *)aString;

/**
 *  去掉字符串两边的空格
 *
 *  @return nsstring
 */
#pragma mark -去掉字符串两边的空格
- (NSString *)stringByTrimingWhitespace;

/**
 *  一共多少行"\n"
 *
 *  @return nsuinteger
 */
#pragma mark -获取当前字符串一共多少行（有多少个换行）
- (NSUInteger)numberOfLines;

#pragma mark -------------------------合法性验证

/**
 *  邮箱符合法性验证
 *
 *  @return 是否是合法的邮箱
 */
#pragma mark -邮箱符合性验证
- (BOOL)isValidateEmail;
/**
 *  是否全是数字
 *
 *  @return 是否全是数字
 */
#pragma mark -是否全是数字
- (BOOL)isNumber;
/**
 *  是否全是英文字母
 *
 *  @return BOOL
 */
#pragma mark -是否全是英文字母
- (BOOL)isEnglishWords;
/**
 *  密码合法性验证（6—16位，只能包含字符、数字和 下划线）
 *
 *  @return BOOL
 */
#pragma mark -密码合法性验证（6—16位，只能包含字符、数字和 下划线）
- (BOOL)isValidatePassword;
/**
 *  验证是否为合法的url格式
 *
 *  @return BOOL
 */
#pragma mark -验证是否为合法的url格式
- (BOOL)isInternetUrl;

/**
 *  验证是否为电话号码正确格式为：XXXX-XXXXXXX，XXXX-XXXXXXXX，XXX-XXXXXXX，XXX-XXXXXXXX，XXXXXXX，XXXXXXXX
 *
 *  @return bool
 */
#pragma mark -验证是否是正确的手机号码
- (BOOL)isPhoneNumber;
/**
 *  判断是否为11位的数字
 *
 *  @return BOOL
 */
#pragma mark -判断是否为11位数字
- (BOOL)isElevenDigitNum;
/**
 *  验证是否是身份证 15位 或者18位
 *
 *  @return Bool
 */
#pragma mark -验证是否位正确的身份证号
- (BOOL)isIdentifyCardNumber;
/**
 *  是否是中文汉字
 *
 *  @return Bool
 */
#pragma mark -是否是中文汉字
-(BOOL)isChinese;


/**
 *  将时间格式转化为日期的格式,按照斜杠区分开，eg;2014/1/01 14:12
 *
 *  @return NSDate
 */
#pragma mark -将时间格式转化为日期的格式,按照斜杠区分开，eg;2014/1/01 14:12
-(NSDate *)dateByHHSoftFormate;

/**
 *  根据字符串内容自动计算宽高
 *
 *  @param font     文本的字体
 *  @param maxTextSize 最大宽高
 *
 *  @return cgrect
 */
- (CGSize)boundingRectWithfont:(UIFont *)font maxTextSize:(CGSize)maxTextSize;

@end
