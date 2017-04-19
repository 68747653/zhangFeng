//
//  NSMutableAttributedString+hhsoft.m
//  test
//
//  Created by hhsoft on 16/1/4.
//  Copyright © 2016年 ZZUn. All rights reserved.
//

#import "NSMutableAttributedString+hhsoft.h"

@implementation NSMutableAttributedString (hhsoft)
- (void)changeStr:(NSString *)changeStr changeFont:(UIFont *)changeFont changeColor:(UIColor *)changeColor{
    if (changeStr) {
        NSRange rangeRmb=[self.mutableString rangeOfString:changeStr];
        NSDictionary *fontDic=[NSDictionary dictionaryWithObjectsAndKeys:changeColor,NSForegroundColorAttributeName,changeFont,NSFontAttributeName, nil];
        [self addAttributes:fontDic range:rangeRmb];
    }
    
}

- (void )attributedStringWithImageStr:(NSString *)imgStr imageSize:(CGSize)imageSize{
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:imgStr];
    attach.bounds = CGRectMake(0, -3, imageSize.width, imageSize.height);
    NSAttributedString *attrImg=[NSAttributedString attributedStringWithAttachment:attach];
    [self appendAttributedString:attrImg];
}
@end
