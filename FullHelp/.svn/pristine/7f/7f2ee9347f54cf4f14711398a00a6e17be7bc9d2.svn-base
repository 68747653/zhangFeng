//
//  SupplierRewardViewCell.m
//  FullHelp
//
//  Created by hhsoft on 17/2/13.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "SupplierRewardViewCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import <HHSoftFrameWorkKit/HHSoftButton.h>
#import "GlobalFile.h"
#import "RewardInfo.h"
#import "UserInfo.h"

@interface SupplierRewardViewCell ()
@property (nonatomic,strong) UIView *bgView,*lineView,*lineViews;
@property (nonatomic,strong) HHSoftLabel *timeLabel,*satateLabel,*nameLabel,*moneyLabel;
@property (nonatomic,strong) HHSoftButton *deleteButton,*reasonButton,*rewardButton,*refusedButton;
@property (nonatomic,strong) UIImageView *headImageView;

@end

@implementation SupplierRewardViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initSupplierRewardViewCell];
    }
    return self;
}
-(void)initSupplierRewardViewCell{
    self.backgroundColor = [GlobalFile backgroundColor];
    //背景View
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, [HHSoftAppInfo AppScreen].width-20, 170)];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 4.0;
    _bgView.layer.masksToBounds = YES;
    [self.contentView addSubview:_bgView];
    //背景Layer
    CALayer *backlayer = [CALayer layer];
    backlayer.frame = CGRectMake(0,0, [HHSoftAppInfo AppScreen].width-20, 170);
    backlayer.backgroundColor = [UIColor colorWithWhite:254.0/255.0 alpha:1].CGColor;//backgroundColor背景颜色
    backlayer.borderColor = [UIColor colorWithWhite:254.0/255.0 alpha:1].CGColor;//borderColor阴影边框颜色
    backlayer.shadowOffset = CGSizeMake(0, 2);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    backlayer.shadowOpacity = 0.1;//阴影透明度，默认0
    backlayer.shadowRadius = 1;//阴影半径，默认3
    backlayer.cornerRadius = 4;
    [_bgView.layer insertSublayer:backlayer atIndex:0];
    //时间
    _timeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(10, 5, ([HHSoftAppInfo AppScreen].width-40)/2.0, 30) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [_bgView addSubview:_timeLabel];
    //状态
    _satateLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(10+([HHSoftAppInfo AppScreen].width-40)/2.0, 5, ([HHSoftAppInfo AppScreen].width-40)/2.0, 30) fontSize:14.0 text:@"" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
    [_bgView addSubview:_satateLabel];
    //分割线
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 39.75, [HHSoftAppInfo AppScreen].width-40, 0.5)];
    _lineView.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:223.0/255.0 blue:223.0/255.0 alpha:1.0];
    [_bgView addSubview:_lineView];
    //头像
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 70, 70)];
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2.0;
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.layer.masksToBounds = YES;
    [_bgView addSubview:_headImageView];
    //名称
    _nameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(90, 50, [HHSoftAppInfo AppScreen].width-110, 40) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:2];
    [_bgView addSubview:_nameLabel];
    //金额
    _moneyLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(90, 90, [HHSoftAppInfo AppScreen].width-110, 30) fontSize:14.0 text:@"" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [_bgView addSubview:_moneyLabel];
    //分割线
    _lineViews = [[UIView alloc] initWithFrame:CGRectMake(10, 129.75, [HHSoftAppInfo AppScreen].width-40, 0.5)];
    _lineViews.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:223.0/255.0 blue:223.0/255.0 alpha:1.0];
    [_bgView addSubview:_lineViews];
    //打赏
    _rewardButton = [[HHSoftButton alloc] initWithFrame:CGRectMake(10, 130, 63, 40) innerImage:[UIImage imageNamed:@"reward_reward.png"] innerImageRect:CGRectMake(0, 11, 18, 18) descTextRect:CGRectMake(23, 0, 30, 40) descText:@"打赏" textColor:[UIColor lightGrayColor] textFont:[UIFont systemFontOfSize:14.0] textAligment:NSTextAlignmentLeft];
    [_bgView addSubview:_rewardButton];
    [_rewardButton addTarget:self action:@selector(rewardSupplierRewardButton) forControlEvents:UIControlEventTouchUpInside];
    //拒绝
    _refusedButton = [[HHSoftButton alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width-83, 130, 63, 40) innerImage:[UIImage imageNamed:@"reward_refused.png"] innerImageRect:CGRectMake(0, 11, 18, 18) descTextRect:CGRectMake(23, 0, 30, 40) descText:@"拒绝" textColor:[UIColor lightGrayColor] textFont:[UIFont systemFontOfSize:14.0] textAligment:NSTextAlignmentLeft];
    [_bgView addSubview:_refusedButton];
    [_refusedButton addTarget:self action:@selector(refusedSupplierRewardButton) forControlEvents:UIControlEventTouchUpInside];
    //删除
    _deleteButton = [[HHSoftButton alloc] initWithFrame:CGRectMake(10, 130, 63, 40) innerImage:[UIImage imageNamed:@"reward_delete.png"] innerImageRect:CGRectMake(0, 11, 18, 18) descTextRect:CGRectMake(23, 0, 30, 40) descText:@"删除" textColor:[UIColor lightGrayColor] textFont:[UIFont systemFontOfSize:14.0] textAligment:NSTextAlignmentLeft];
    [_bgView addSubview:_deleteButton];
    [_deleteButton addTarget:self action:@selector(deleteSupplierRewardButton) forControlEvents:UIControlEventTouchUpInside];
    //原因
    _reasonButton = [[HHSoftButton alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width-113, 130, 83, 40) innerImage:[UIImage imageNamed:@"reward_reason.png"] innerImageRect:CGRectMake(0, 11, 18, 18) descTextRect:CGRectMake(23, 0, 60, 40) descText:@"拒绝原因" textColor:[UIColor lightGrayColor] textFont:[UIFont systemFontOfSize:14.0] textAligment:NSTextAlignmentLeft];
    [_bgView addSubview:_reasonButton];
    [_reasonButton addTarget:self action:@selector(reasonSupplierRewardButton) forControlEvents:UIControlEventTouchUpInside];
}
-(void)setRewardInfo:(RewardInfo *)rewardInfo{
    _rewardInfo = rewardInfo;
    //时间
    _timeLabel.text = [NSString stringByReplaceNullString:_rewardInfo.rewardAddTime];
    //状态
    _satateLabel.text = [NSString stringByReplaceNullString:_rewardInfo.rewardStateStr];
    //头像
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:_rewardInfo.userInfo.userHeadImg] placeholderImage:[GlobalFile HHSoftDefaultImg1_1]];
    //名称
    if (_rewardInfo.userInfo.userNickName.length) {
        _nameLabel.text = [NSString stringByReplaceNullString:_rewardInfo.userInfo.userNickName];
    }else{
        _nameLabel.text = [NSString stringByReplaceNullString:_rewardInfo.userInfo.userLoginName];
    }
    //金额
    _moneyLabel.text = [NSString stringWithFormat:@"申请打赏￥%@",[NSString stringByReplaceNullString:[GlobalFile stringFromeFloat:_rewardInfo.rewardAmount decimalPlacesCount:2]]];
    //状态（1：已申请 2：已同意 3：已拒绝）
    if (_rewardInfo.rewardState == 1) {
        _rewardButton.hidden = NO;
        _refusedButton.hidden = NO;
        _deleteButton.hidden = YES;
        _reasonButton.hidden = YES;
    }else if (_rewardInfo.rewardState == 3){
        _rewardButton.hidden = YES;
        _refusedButton.hidden = YES;
        _deleteButton.hidden = NO;
        _reasonButton.hidden = NO;
    }
}
#pragma mark -- 打赏按钮点击事件
-(void)rewardSupplierRewardButton{
    if (_rewardSupplierRewardBlock) {
        _rewardSupplierRewardBlock();
    }
}
#pragma mark -- 拒绝按钮点击事件
-(void)refusedSupplierRewardButton{
    if (_refusedSupplierRewardBlock) {
        _refusedSupplierRewardBlock();
    }
}
#pragma mark -- 删除按钮点击事件
-(void)deleteSupplierRewardButton{
    if (_deleteSupplierRewardBlock) {
        _deleteSupplierRewardBlock();
    }
}
#pragma mark -- 原因按钮点击事件
-(void)reasonSupplierRewardButton{
    if (_reasonSupplierRewardBlock) {
        _reasonSupplierRewardBlock();
    }
}
@end
