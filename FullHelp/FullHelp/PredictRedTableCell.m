//
//  PredictRedTableCell.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/14.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "PredictRedTableCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import "GlobalFile.h"
#import "RedPacketInfo.h"
#import "UserInfo.h"

@interface PredictRedTableCell ()

@property (nonatomic, strong) UIView *bgView, *shadowImgView, *lineView;
@property (nonatomic, strong) HHSoftLabel *nameLabel, *amountLabel, *memoLabel, *timeLabel;
@property (nonatomic, strong) UIImageView *bigImgView;

@end

@implementation PredictRedTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellAccessoryNone;
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
    
    _nameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:16.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [_bgView addSubview:_nameLabel];
    
    _amountLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:14.0 text:@"" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
    [_bgView addSubview:_amountLabel];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectZero];
    _lineView.backgroundColor = [GlobalFile colorWithRed:229.0 green:229.0 blue:229.0 alpha:1.0];
    [_bgView addSubview:_lineView];
    
    _memoLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [_bgView addSubview:_memoLabel];
    
    _timeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [_bgView addSubview:_timeLabel];
}

- (void)setRedPacketInfo:(RedPacketInfo *)redPacketInfo {
    _redPacketInfo = redPacketInfo;
    _bigImgView.image = [UIImage imageNamed:@"home_predictRed"];
    _nameLabel.text = redPacketInfo.sendUserInfo.userMerchantName;
    _amountLabel.text = [NSString stringWithFormat:@"￥%@", [GlobalFile stringFromeFloat:[redPacketInfo.redPacketAmount floatValue] decimalPlacesCount:2]];
    _memoLabel.text = @"预报红包，要提前看哦";
    _timeLabel.text = redPacketInfo.redPacketMemo;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = [HHSoftAppInfo AppScreen].width-20;
    _shadowImgView.frame = CGRectMake(10, 10, width, self.frame.size.height-10);
    _bgView.frame = CGRectMake(0, 0, width, CGRectGetHeight(_shadowImgView.frame));
    _bigImgView.frame = CGRectMake(10, 10, 63, 90);
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_bigImgView.frame)+10, CGRectGetMinX(_bigImgView.frame), (width - CGRectGetMaxX(_bigImgView.frame) - 30)/3*2.0, 29.5);
    _amountLabel.frame = CGRectMake(CGRectGetMaxX(_nameLabel.frame)+10, CGRectGetMinY(_bigImgView.frame), CGRectGetWidth(_nameLabel.frame)/2.0, 29.5);
    _lineView.frame = CGRectMake(CGRectGetMaxX(_bigImgView.frame)+15, CGRectGetMaxY(_nameLabel.frame), (width - CGRectGetMaxX(_bigImgView.frame) - 30), 1);
    _memoLabel.frame = CGRectMake(CGRectGetMaxX(_bigImgView.frame)+10, CGRectGetMaxY(_lineView.frame), (width - CGRectGetMaxX(_bigImgView.frame) - 20), 29.5);
    _timeLabel.frame = CGRectMake(CGRectGetMaxX(_bigImgView.frame)+10, CGRectGetMaxY(_memoLabel.frame), (width - CGRectGetMaxX(_bigImgView.frame) - 20), 30);
}

+ (CGFloat)getCellHeightWith:(RedPacketInfo *)redPacketInfo {
    return 120;
}

@end
