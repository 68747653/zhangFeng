//
//  AdvertTableCell.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/13.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AdvertTableCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import "GlobalFile.h"
#import "AdvertInfo.h"
#import "NSMutableAttributedString+hhsoft.h"

@interface AdvertTableCell ()

@property (nonatomic, strong) UIView *bgView, *shadowImgView;
@property (nonatomic, strong) HHSoftLabel *timeLabel, *typeLabel;
@property (nonatomic, strong) UIImageView *bigImgView;

@end

@implementation AdvertTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor clearColor];
    _shadowImgView = [[UIView alloc] initWithFrame:CGRectZero];
    _shadowImgView.layer.shadowColor = [UIColor blackColor].CGColor;
    _shadowImgView.layer.shadowOffset = CGSizeMake(1, 1);
    _shadowImgView.layer.shadowOpacity = 0.3;
    _shadowImgView.layer.shadowRadius = 5.0;
    [self addSubview:_shadowImgView];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _bgView.layer.cornerRadius = 5.0;
    _bgView.layer.masksToBounds = YES;
    _bgView.backgroundColor = [UIColor whiteColor];
    [_shadowImgView addSubview:_bgView];
    
    _bigImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _bigImgView.contentMode = UIViewContentModeScaleAspectFill;
    _bigImgView.layer.masksToBounds = YES;
    [_bgView addSubview:_bigImgView];
    
    _typeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:14.0 text:@"" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
    _typeLabel.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    _typeLabel.layer.cornerRadius = 15.f;
    _typeLabel.layer.masksToBounds = YES;
    [_bigImgView addSubview:_typeLabel];
    
    _timeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:14.0 text:@"" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
    [_bgView addSubview:_timeLabel];
}

- (void)setAdvertInfo:(AdvertInfo *)advertInfo {
    _advertInfo = advertInfo;
    [_bigImgView sd_setImageWithURL:[NSURL URLWithString:advertInfo.advertImg] placeholderImage:[GlobalFile HHSoftDefaultImg2_1]];
    if (advertInfo.advertType == 1) {
        _typeLabel.text = @"现金红包  ";
    } else if (advertInfo.advertType == 2) {
        _typeLabel.text = @"专场红包  ";
    }
    
    NSMutableAttributedString *timeAttributed = [[NSMutableAttributedString alloc] init];
    [timeAttributed attributedStringWithImageStr:@"advert_showTime" imageSize:CGSizeMake(14, 14)];
    [timeAttributed appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"展示时间： %@-%@", advertInfo.advertBeginTime, advertInfo.advertEndTime]]];
    _timeLabel.attributedText = timeAttributed;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = [HHSoftAppInfo AppScreen].width-20;
    _shadowImgView.frame = CGRectMake(10, 10, width, self.frame.size.height-10);
    _bgView.frame = CGRectMake(0, 0, width, CGRectGetHeight(_shadowImgView.frame));
    _bigImgView.frame = CGRectMake(0, 0, width, CGRectGetHeight(_shadowImgView.frame)-40);
    CGSize size = [_typeLabel.text boundingRectWithfont:[UIFont systemFontOfSize:14.0] maxTextSize:CGSizeMake(CGFLOAT_MAX, 30)];
    _typeLabel.frame = CGRectMake(-20, 20, size.width+40, 30);
    _timeLabel.frame = CGRectMake(10, CGRectGetMaxY(_bigImgView.frame), (width - 20), 40);
}

+ (CGFloat)getCellHeightWith:(AdvertInfo *)advertInfo {
    return 10+[HHSoftAppInfo AppScreen].width/2.0+40;
}

@end
