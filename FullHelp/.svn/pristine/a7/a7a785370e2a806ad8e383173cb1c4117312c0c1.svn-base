//
//  CustomServicerTableCell.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/9.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "CustomServicerTableCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import <HHSoftFrameWorkKit/UIDevice+DeviceInfo.h>
#import "GlobalFile.h"
#import "CustomServicerInfo.h"
#import "NSMutableAttributedString+hhsoft.h"

@interface CustomServicerTableCell ()

@property (nonatomic, strong) UIView *bgView, *shadowImgView, *lineView, *leftLineView, *rightLineView;
@property (nonatomic, strong) HHSoftLabel *nameLabel, *telLabel, *addressLabel, *qqLabel, *weChatLabel, *sinaWeiBoLabel;

@end

@implementation CustomServicerTableCell

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
    
    _nameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:16.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [_bgView addSubview:_nameLabel];
    
    _telLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:14.0 text:@"" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(telTapTouch)];
    [_telLabel addGestureRecognizer:singleTap];
    [_bgView addSubview:_telLabel];
    
    _addressLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [_bgView addSubview:_addressLabel];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectZero];
    _lineView.backgroundColor = [GlobalFile colorWithRed:229.0 green:229.0 blue:229.0 alpha:1.0];
    [_bgView addSubview:_lineView];
    
    _qqLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:11.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
    [_bgView addSubview:_qqLabel];
    _leftLineView = [[UIView alloc] initWithFrame:CGRectZero];
    _leftLineView.backgroundColor = [GlobalFile colorWithRed:229.0 green:229.0 blue:229.0 alpha:1.0];
    [_bgView addSubview:_leftLineView];
    _weChatLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:11.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
    [_bgView addSubview:_weChatLabel];
    _rightLineView = [[UIView alloc] initWithFrame:CGRectZero];
    _rightLineView.backgroundColor = [GlobalFile colorWithRed:229.0 green:229.0 blue:229.0 alpha:1.0];
    [_bgView addSubview:_rightLineView];
    _sinaWeiBoLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:11.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
    [_bgView addSubview:_sinaWeiBoLabel];
}

- (void)setCustomServicerInfo:(CustomServicerInfo *)customServicerInfo {
    _customServicerInfo = customServicerInfo;
    _nameLabel.text = customServicerInfo.customName;
    _telLabel.text = customServicerInfo.customTel;
    _addressLabel.text = customServicerInfo.customAddress;
    
    NSMutableAttributedString *qqAttributed = [[NSMutableAttributedString alloc] init];
    [qqAttributed attributedStringWithImageStr:@"custom_qq" imageSize:CGSizeMake(14, 14)];
    [qqAttributed appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", [NSString stringByReplaceNullString:customServicerInfo.customQQ]]]];
    _qqLabel.attributedText = qqAttributed;
    
    NSMutableAttributedString *weChatAttributed = [[NSMutableAttributedString alloc] init];
    [weChatAttributed attributedStringWithImageStr:@"custom_wechat" imageSize:CGSizeMake(14, 14)];
    [weChatAttributed appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", [NSString stringByReplaceNullString:customServicerInfo.customWeChat]]]];
    _weChatLabel.attributedText = weChatAttributed;
    
    NSMutableAttributedString *sinaAttributed = [[NSMutableAttributedString alloc] init];
    [sinaAttributed attributedStringWithImageStr:@"custom_sina" imageSize:CGSizeMake(14, 14)];
        [sinaAttributed appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", [NSString stringByReplaceNullString:customServicerInfo.customSinaWeiBo]]]];
    _sinaWeiBoLabel.attributedText = sinaAttributed;
}

- (void)telTapTouch {
    [UIDevice callUp:_customServicerInfo.customTel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = [HHSoftAppInfo AppScreen].width-20;
    _shadowImgView.frame = CGRectMake(10, 10, width, self.frame.size.height-10);
    _bgView.frame = CGRectMake(0, 0, width, CGRectGetHeight(_shadowImgView.frame));
    CGSize size = [_customServicerInfo.customAddress boundingRectWithfont:[UIFont systemFontOfSize:14.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-20-20, CGFLOAT_MAX)];
    _nameLabel.frame = CGRectMake(10, 0, (width - 20)/2.0, 30);
    _telLabel.frame = CGRectMake((width - 20)/2.0+15, 0, (width - 20)/2.0-5, 30);
    _addressLabel.frame = CGRectMake(10, 30, width - 20, size.height);
    _lineView.frame = CGRectMake(10, CGRectGetMaxY(_addressLabel.frame)+9.5, width-20, 1);
    _qqLabel.frame = CGRectMake(10, CGRectGetMaxY(_addressLabel.frame)+10.5, (width-40)/3.0, 39.5);
    _leftLineView.frame = CGRectMake(CGRectGetMaxX(_qqLabel.frame)+4.5, CGRectGetMinY(_qqLabel.frame)+10, 1, CGRectGetHeight(_qqLabel.frame)-20);
    _weChatLabel.frame = CGRectMake(CGRectGetMaxX(_qqLabel.frame)+10, CGRectGetMinY(_qqLabel.frame), (width-40)/3.0, CGRectGetHeight(_qqLabel.frame));
    _rightLineView.frame = CGRectMake(CGRectGetMaxX(_weChatLabel.frame)+4.5, CGRectGetMinY(_qqLabel.frame)+10, 1, CGRectGetHeight(_qqLabel.frame)-20);
    _sinaWeiBoLabel.frame = CGRectMake(CGRectGetMaxX(_weChatLabel.frame)+10, CGRectGetMinY(_qqLabel.frame), (width-40)/3.0, CGRectGetHeight(_qqLabel.frame));
}

+ (CGFloat)getCellHeightWith:(CustomServicerInfo *)customServicerInfo {
    CGSize size = [customServicerInfo.customAddress boundingRectWithfont:[UIFont systemFontOfSize:14.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-20-20, CGFLOAT_MAX)];
    return 30+size.height+10+40+10;
}

@end
