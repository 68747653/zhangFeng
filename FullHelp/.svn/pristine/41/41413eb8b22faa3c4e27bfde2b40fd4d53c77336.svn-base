//
//  SceneCell.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/14.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "SceneCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import "NSMutableAttributedString+hhsoft.h"
#import "AdvertInfo.h"
#import "GlobalFile.h"


@interface SceneCell ()
    @property (nonatomic, strong) UIView *bgView,*shadowImgView;
    @property (nonatomic, strong) UIImageView *advertImg;
    @property (nonatomic, strong) HHSoftLabel *merchantNameLabel;
@end

@implementation SceneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellAccessoryNone;
        [self setUI];
    }
    return self;
}
- (void)setUI {
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
    
    _merchantNameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:16 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    //    _merchantNameLabel.backgroundColor = [UIColor purpleColor];
    [_bgView addSubview:_merchantNameLabel];
}
- (void) setAdvertInfo:(AdvertInfo *)advertInfo {
    _advertInfo = advertInfo;
    _merchantNameLabel.text = [NSString stringWithFormat:@"  %@",_advertInfo.advertTitle];
    [_advertImg sd_setImageWithURL:[NSURL URLWithString:_advertInfo.advertImg] placeholderImage:[GlobalFile HHSoftDefaultImg2_1]];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = [HHSoftAppInfo AppScreen].width-20;
    CGFloat height = width/2;
    _shadowImgView.frame = CGRectMake(10, 5, width, self.frame.size.height-10);
    _bgView.frame = CGRectMake(0, 0, width, CGRectGetHeight(_shadowImgView.frame));
    _advertImg.frame = CGRectMake(0, 0, width, height);
    _merchantNameLabel.frame = CGRectMake(0, CGRectGetMaxY(_advertImg.frame), width-70, 30);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
