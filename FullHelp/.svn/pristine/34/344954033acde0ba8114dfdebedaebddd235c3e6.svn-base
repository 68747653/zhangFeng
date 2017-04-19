//
//  UIButton+HHSoft.m
//  MedicalCareFree
//
//  Created by hhsoft on 2016/10/11.
//  Copyright © 2016年 www.huahansoft.com. All rights reserved.
//

#import "UIButton+HHSoft.h"

@implementation UIButton (HHSoft)
- (void)verticalImageAndTitle:(CGFloat)spacing
{

    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.titleLabel.font,NSFontAttributeName, nil];
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:dic];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}
@end
