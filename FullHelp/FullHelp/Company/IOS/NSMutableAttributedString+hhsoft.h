//
//  NSMutableAttributedString+hhsoft.h
//  test
//
//  Created by hhsoft on 16/1/4.
//  Copyright © 2016年 ZZUn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSMutableAttributedString (hhsoft)

/**
 更改部分字颜色大小

 @param changeStr   需更改颜色字体的文字
 @param changeFont  大小
 @param changeColor 颜色
 */
- (void)changeStr:(NSString *)changeStr changeFont:(UIFont *)changeFont changeColor:(UIColor *)changeColor;
- (void )attributedStringWithImageStr:(NSString *)imgStr imageSize:(CGSize)imageSize;
@end
