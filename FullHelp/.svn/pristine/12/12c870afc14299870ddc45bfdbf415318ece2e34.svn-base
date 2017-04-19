//
//  GameAdvertView.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/14.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "GameAdvertView.h"
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import "GlobalFile.h"
@interface GameAdvertView ()
@property (nonatomic, copy) ClickBlock clickBlock;
@property (nonatomic, strong) UIImageView *redPacketImgView;
@end

@implementation GameAdvertView

- (instancetype)initWithFrame:(CGRect)frame clickBlock:(ClickBlock)clickBlock{
    self = [super initWithFrame:frame];
    if (self) {
        self.clickBlock = clickBlock;
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {

    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    CGFloat imgWidth = [HHSoftAppInfo AppScreen].width-40;
    self.redPacketImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, ([HHSoftAppInfo AppScreen].height-imgWidth)/2, imgWidth,imgWidth)];
    self.redPacketImgView.userInteractionEnabled = YES;
    [self addSubview:_redPacketImgView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 15, 15, 15);
    [button setBackgroundImage:[UIImage imageNamed:@"redPacket_close.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(colseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.redPacketImgView addSubview:button];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [self.redPacketImgView addGestureRecognizer:tap];
}
- (void)tapGesture {
    if (self.clickBlock) {
        self.clickBlock();
    }
}
- (void)colseButtonClick {
    [self removeFromSuperview];
}

- (void)setAdvertImg:(NSString *)advertImg {
    _advertImg = advertImg;
    [_redPacketImgView sd_setImageWithURL:[NSURL URLWithString:_advertImg] placeholderImage:[GlobalFile HHSoftDefaultImg1_1]];
    
}
@end
