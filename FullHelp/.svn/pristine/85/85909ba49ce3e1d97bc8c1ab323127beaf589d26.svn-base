//
//  HomeRedPacketView.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "HomeRedPacketView.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import "NSMutableAttributedString+hhsoft.h"
#import "AdvertInfo.h"
#import "GlobalFile.h"

@interface HomeRedPacketView ()
@property (nonatomic, strong) UIView *bgView,*shadowImgView,*bottomView;
@property (nonatomic, strong) UIImageView *advertImg,*levelImg,*certImg;
@property (nonatomic, strong) HHSoftLabel *imgLabel,*merchantNameLabel,*amountLabel,*favorableLabel,*countLabel;
@end

@implementation HomeRedPacketView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    _shadowImgView = [[UIView alloc] initWithFrame:CGRectZero];
    _shadowImgView.layer.shadowColor = [UIColor blackColor].CGColor;
    _shadowImgView.layer.shadowOffset = CGSizeMake(1, 1);
    _shadowImgView.layer.shadowOpacity = 0.3;
    _shadowImgView.layer.shadowRadius = 5.0f;
    [self addSubview:_shadowImgView];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _bgView.layer.cornerRadius = 5.0f;
    _bgView.layer.masksToBounds = YES;
    _bgView.backgroundColor = [UIColor whiteColor];
    [_shadowImgView addSubview:_bgView];
    
    _advertImg = [[UIImageView alloc] init];
    [_bgView addSubview:_advertImg];
    
    _imgLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:12 text:@"" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    _imgLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.7];
//        _imgLabel.backgroundColor = [UIColor greenColor];
    [_bgView addSubview:_imgLabel];
    
    _merchantNameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:14 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
//        _merchantNameLabel.backgroundColor = [UIColor purpleColor];
    [_bgView addSubview:_merchantNameLabel];
    
    _levelImg = [[UIImageView alloc] init];
//        _levelImg.backgroundColor = [UIColor orangeColor];
    [_bgView addSubview:_levelImg];
    
    _certImg = [[UIImageView alloc] init];
//        _certImg.backgroundColor = [UIColor orangeColor];
    _certImg.image = [UIImage imageNamed:@"cert.png"];
    _certImg.hidden = NO;
    [_bgView addSubview:_certImg];
    
    _amountLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:12 text:@"" textColor:[UIColor lightGrayColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [_bgView addSubview:_amountLabel];
    
    _bottomView = [[UIView alloc] init];
//            _bottomView.backgroundColor = [UIColor redColor];
    [_bgView addSubview:_bottomView];
    
    CALayer *line = [CALayer layer];
    line.backgroundColor = [GlobalFile backgroundColor].CGColor;
    line.frame = CGRectMake(10, 0, [HHSoftAppInfo AppScreen].width-40, 1);
    [_bottomView.layer addSublayer:line];
    
    
    _favorableLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:10 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
//            _favorableLabel.backgroundColor = [UIColor blueColor];
    [_bottomView addSubview:_favorableLabel];
    
    _countLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:10 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
//            _countLabel.backgroundColor = [UIColor grayColor];
    [_bottomView addSubview:_countLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(categoryTap)];
    [self addGestureRecognizer:tap];
    
}
#pragma mark ------ 选择类别击事件
- (void) categoryTap {
    if (_delegate && [_delegate respondsToSelector:@selector(homeRedPackerView:advertInfo:)]) {
        [_delegate homeRedPackerView:self advertInfo:_advertInfo];
    }
}
- (void)setAdvertInfo:(AdvertInfo *)advertInfo {
    _advertInfo = advertInfo;
    _levelImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"level%@.png",_advertInfo.level]];
    _merchantNameLabel.text = [NSString stringWithFormat:@"  %@",_advertInfo.merchantName];
    if (_advertInfo.isCert) {
        _certImg.hidden = NO;
    }
    else {
        _certImg.hidden = YES;
    }
    
    [_advertImg sd_setImageWithURL:[NSURL URLWithString:_advertInfo.advertImg] placeholderImage:[GlobalFile HHSoftDefaultImg4_5]];
    _imgLabel.text = [NSString stringWithFormat:@"  %@",_advertInfo.advertTitle];
    _amountLabel.text = [NSString stringWithFormat:@"  已打赏%@人,赏金%@元",_advertInfo.advertApplyCount,_advertInfo.advertAmount];
    
    NSMutableAttributedString *tagAttributed = [[NSMutableAttributedString alloc] init];
    [tagAttributed attributedStringWithImageStr:@"like.png" imageSize:CGSizeMake(14, 14)];
    [tagAttributed appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@",_advertInfo.advertPraiseCount]]];
    _favorableLabel.attributedText = tagAttributed;
    
    NSMutableAttributedString *countAttributed = [[NSMutableAttributedString alloc] init];
//    [countAttributed attributedStringWithImageStr:@"like.png" imageSize:CGSizeMake(10, 10)];
//    [countAttributed appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@  ",_advertInfo.advertPraiseCount]]];
    [countAttributed attributedStringWithImageStr:@"collect.png" imageSize:CGSizeMake(14, 14)];
    [countAttributed appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@",_advertInfo.advertCollectCount]]];
    _countLabel.attributedText = countAttributed;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = ([HHSoftAppInfo AppScreen].width-30)/2;
    CGFloat height = width/4*5;
    
    _shadowImgView.frame = CGRectMake(0, 0, width, self.frame.size.height);
    _bgView.frame = CGRectMake(0, 0, width, CGRectGetHeight(_shadowImgView.frame));
    _advertImg.frame = CGRectMake(0, 0, width, height);
    _imgLabel.frame = CGRectMake(0, CGRectGetMaxY(_advertImg.frame)-20, width, 20);
    _merchantNameLabel.frame = CGRectMake(0, CGRectGetMaxY(_advertImg.frame), width-70, 30);
    if (_advertInfo.isCert) {
        _levelImg.frame = CGRectMake(width-60, CGRectGetMaxY(_advertImg.frame)+5, 20, 20);
    }
    else {
        _levelImg.frame = CGRectMake(width-30, CGRectGetMaxY(_advertImg.frame)+5, 20, 20);
    }
    
    _certImg.frame = CGRectMake(width-30, CGRectGetMaxY(_advertImg.frame)+5, 20, 20);
    _amountLabel.frame = CGRectMake(0, CGRectGetMaxY(_merchantNameLabel.frame), width, 25);
    _bottomView.frame = CGRectMake(0, CGRectGetMaxY(_amountLabel.frame), width, 30);
    _favorableLabel.frame = CGRectMake(10, 2.5, width/2-10, 25);
    _countLabel.frame = CGRectMake(width/2, 2.5, width/2-10, 25);
}
@end
