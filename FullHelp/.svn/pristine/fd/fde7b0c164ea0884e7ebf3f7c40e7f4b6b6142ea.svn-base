//
//  NSString+NSStringAddition.h
//  BusinessChat
//
//  Created by hhsoft on 2016/10/19.
//  Copyright © 2016年 www.huahansoft.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addition)

/**
 获得 kMaxLength长度的字符

 @param kMaxLength 最大字符长度
 @param string     字符串

 @return kMaxLength长度的字符
 */
+ (NSString *)getSubWithMaxLength:(NSInteger)kMaxLength string:(NSString *)string;

/**
 判断中英混合的的字符串长度

 @param strtemp 中英混合的的字符串

 @return 中英混合的的字符串长度
 */
+ (NSInteger)convertToInt:(NSString *)strtemp;


/**
 验证价格是否是正确格式 小数点后两位

 @return NSString
 */
- (NSString *)verifyPriceFormat;

// 判断是否是11位手机号码
- (BOOL)isPhoneNumberNew;
@end
