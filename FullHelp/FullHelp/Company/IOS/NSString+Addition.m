//
//  NSString+NSStringAddition.m
//  BusinessChat
//
//  Created by hhsoft on 2016/10/19.
//  Copyright © 2016年 www.huahansoft.com. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)

/**
 *  获得 kMaxLength长度的字符
 */
+ (NSString *)getSubWithMaxLength:(NSInteger)kMaxLength string:(NSString *)string {
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* data = [string dataUsingEncoding:encoding];
    NSInteger length = [data length];
    if (length > kMaxLength) {
        NSData *data1 = [data subdataWithRange:NSMakeRange(0, kMaxLength)];
        NSString *content = [[NSString alloc] initWithData:data1 encoding:encoding];//【注意】：当截取kMaxLength长度字符时把中文字符截断返回的content会是nil
        if (!content || content.length == 0) {
            data1 = [data subdataWithRange:NSMakeRange(0, kMaxLength - 1)];
            content =  [[NSString alloc] initWithData:data1 encoding:encoding];
        }
        return content;
    }
    return nil;
}
//判断中英混合的的字符串长度
+ (NSInteger)convertToInt:(NSString *)strtemp {
    NSInteger strlength = 0;
    char *p = (char *)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (NSInteger i = 0; i < [strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            p++;
            strlength++;
        } else {
            p++;
        }
    }
    return strlength;
}

- (NSString *)verifyPriceFormat{
    NSString *resultStr=self;
    if (resultStr.length==1) {
        if ([resultStr isEqualToString:@"."]) {
            resultStr=@"0.";
            return resultStr;
        }
    }
    if (resultStr.length==2) {
        NSString *str=[resultStr substringToIndex:1];
        if ([str isEqualToString:@"0"] && ![resultStr containsString:@"."]) {
            resultStr=[resultStr substringFromIndex:1];
            return resultStr;
        }
    }
    if ([resultStr containsString:@"."]) {
        NSInteger count=0;
        for (NSInteger i=0; i<resultStr.length; i++) {
            char c=[resultStr characterAtIndex:i];
            if (c=='.') {
                count++;
            }
            if (count>1) {
                resultStr=[resultStr substringToIndex:i];
                return resultStr;
            }
        }
        NSRange range=[resultStr rangeOfString:@"."];
        if (range.length) {
            if (resultStr.length - range.location>3) {
                resultStr=[resultStr substringToIndex:range.location+3];
            }
        }
    }
        //限制最大7位数
    if ([resultStr floatValue]>=10000000) {
        NSRange range=[resultStr rangeOfString:@"."];
        if (range.length) {
            resultStr=[resultStr stringByReplacingCharactersInRange:NSMakeRange(range.location-1, 1) withString:@""];
            return resultStr;
        }
        resultStr=[resultStr substringToIndex:resultStr.length-1];
        return resultStr;
    }
    return resultStr;
}

// 判断是否是11位手机号码
- (BOOL)isPhoneNumberNew {
    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     * 联通号段正则表达式
     */
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     * 电信号段正则表达式
     */
    NSString *CT_NUM = @"^((133)|(153)|(173)|(177)|(18[0,1,9]))\\d{8}$";
    
    // 一个判断是否是手机号码的正则表达式
    NSString *pattern = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",CM_NUM,CU_NUM,CT_NUM];
    
    NSRegularExpression *regularExpression = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSString *mobile = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11) {
        NO;
    }
    
    // 无符号整型数据接收匹配的数据的数目
    NSUInteger numbersOfMatch = [regularExpression numberOfMatchesInString:mobile options:NSMatchingReportProgress range:NSMakeRange(0, mobile.length)];
    if (numbersOfMatch>0) return YES;
    
    return NO;
    
}
@end
