//
//  ClassButton.m
//  MiFenWo
//
//  Created by hhsoft on 15/12/30.
//  Copyright © 2015年 www.huahansoft.com. All rights reserved.
//

#import "HHSoftGraphicMixedButton.h"
//#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
@interface HHSoftGraphicMixedButton()
@property (nonatomic, assign) CGFloat titleLabelW;
@property (nonatomic, assign) CGSize imgSize;
@end
@implementation HHSoftGraphicMixedButton

- (instancetype)initWithFrame:(CGRect)frame imgSize:(CGSize)imgSize{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentRight;
//        self.titleLabel.backgroundColor = [UIColor redColor];
//        self.imageView.backgroundColor = [UIColor brownColor];
        self.imageView.contentMode = UIViewContentModeCenter;
        _imgSize = imgSize;
    }
    return self;
}
- (void)setButtonTitle:(NSString *)buttonTitle {
    _buttonTitle = buttonTitle;
    [self setTitle:_buttonTitle forState:UIControlStateNormal];
    NSDictionary *attribute = @{NSFontAttributeName:self.titleLabel.font};

    CGSize size = [_buttonTitle boundingRectWithSize:CGSizeMake(self.frame.size.width, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
    _titleLabelW = size.width;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleW = _titleLabelW;
    CGFloat titleH = contentRect. size . height ;
    CGFloat titleX = (contentRect. size . width-_titleLabelW-_imgSize.width)/2 ;
    CGFloat titleY = 0 ;
    contentRect = ( CGRect ){{titleX,titleY},{titleW,titleH}};
    return contentRect;
}
- ( CGRect )imageRectForContentRect:( CGRect )contentRect {
    CGFloat imageW = _imgSize.width ;
    CGFloat imageH = _imgSize.height ;
    CGFloat imageX = (contentRect.size.width-_titleLabelW-_imgSize.width)/2+_titleLabelW ;
    CGFloat imageY = (contentRect.size.height-_imgSize.height)/2 ;
    contentRect = ( CGRect ){{imageX,imageY},{imageW,imageH}};
    return contentRect;
}
@end
