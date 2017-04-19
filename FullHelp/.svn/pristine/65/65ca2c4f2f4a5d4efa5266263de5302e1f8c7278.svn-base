//
//  HHSoftVerticalMoveLabel.m
//  HHSoftProduct
//
//  Created by hhsoft on 2016/12/28.
//  Copyright © 2016年 ZZUn. All rights reserved.
//

#import "HHSoftVerticalMoveLabel.h"

@interface HHSoftVerticalMoveLabel ()
@property (nonatomic,strong) UILabel              *label1;
@property (nonatomic,strong) UILabel              *label2;
@property (nonatomic, assign) NSInteger showMessageIndex;
@property (nonatomic,strong) NSTimer              *timer;
//@property (nonatomic, strong) UIButton *backgroundButton;

@end

@implementation HHSoftVerticalMoveLabel
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor = [UIColor lightGrayColor];
        self.textFont = [UIFont systemFontOfSize:15];
        self.scrollDuration = 0.5;
        self.stayDuration = 2;
        self.layer.masksToBounds = YES;
        [self setUpUI];
    }
    return self;
}
- (void)start {
    if (self.arrMessage.count < 2) {
        return;
    }
    NSTimer *timer = [NSTimer timerWithTimeInterval:_stayDuration target:self selector:@selector(scrollAnimate) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)stop{
    [self.timer invalidate];
    
}
- (void)scrollAnimate {
    CGRect rect1 = self.label1.frame;
    CGRect rect2 = self.label2.frame;
    rect1.origin.y -= self.frame.size.height;
    rect2.origin.y -= self.frame.size.height;
    [UIView animateWithDuration:_scrollDuration animations:^{
        self.label1.frame = rect1;
        self.label2.frame = rect2;
    } completion:^(BOOL finished) {
        [self checkLabelFrameChange:self.label1];
        [self checkLabelFrameChange:self.label2];
    }];
}
#pragma mark ------ 将最上面的label移动到下面并更改需要显示的内容
- (void)checkLabelFrameChange:(UILabel *)label {
    if (label.frame.origin.y < -10) {
        CGRect rect = label.frame;
        rect.origin.y = self.frame.size.height;
        label.frame = rect;
        label.text = self.arrMessage[self.showMessageIndex];
        if (self.arrMessage.count-1 == self.showMessageIndex) {
            self.showMessageIndex = 0;
        }else {
            self.showMessageIndex++;
        }
    }
}
- (void)setUpUI {
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width, self.frame.size.height)];
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
    
    _label1.textColor = _label2.textColor = self.textColor;
    _label1.font = _label2.font = self.textFont;
    
    UIButton *backgroundButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [backgroundButton addTarget:self action:@selector(backgroundButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_label1];
    [self addSubview:_label2];
    [self addSubview:backgroundButton];
    
}
- (void)setArrMessage:(NSMutableArray<NSString *> *)arrMessage {
    _arrMessage = arrMessage;
    if (_arrMessage.count > 2) {
        _label1.text = _arrMessage[0];
        _label2.text = _arrMessage[1];
        self.showMessageIndex = 2;
    }
    else if (_arrMessage.count == 2) {
        _label1.text = _arrMessage[0];
        _label2.text = _arrMessage[1];
        self.showMessageIndex = 0;
    }
    else if (_arrMessage.count == 1) {
        _label1.text = _arrMessage[0];
    }
}
- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    self.label1.textColor = textColor;
    self.label2.textColor = textColor;
}

- (void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
    self.label1.font = textFont;
    self.label2.font = textFont;
}
- (void)setScrollDuration:(NSTimeInterval)scrollDuration{
    _scrollDuration = scrollDuration;
}

- (void)setStayDuration:(NSTimeInterval)stayDuration{
    _stayDuration = stayDuration;
}
- (void)setTextColor:(UIColor *)textColor textFont:(UIFont *)textFont scrollDuration:(NSTimeInterval)scrollDuration stayDuration:(NSTimeInterval)stayDuration {
    self.textColor = textColor;
    self.textFont = textFont;
    self.scrollDuration = scrollDuration;
    self.stayDuration = stayDuration;

}
- (void)backgroundButtonClick {
    if (self.arrMessage.count == 0) return;
    if (self.clickMessageBlock) {
        self.clickMessageBlock((self.showMessageIndex + self.arrMessage.count - 2)%self.arrMessage.count);
    }
}

@end
