//
//  AccountChangeTableCell.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AccountChangeTableCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "AccountChangeInfo.h"

@interface AccountChangeTableCell ()

@property (nonatomic, strong) HHSoftLabel *typeNameLabel, *addTimeLabel, *detailLabel, *userLabel, *changeLabel;

@end

@implementation AccountChangeTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //变动类型
        _typeNameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 0, [HHSoftAppInfo AppScreen].width/2.0 - 20, 30) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
        [self addSubview:_typeNameLabel];
        //时间
        _addTimeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width/2.0+5, 0, [HHSoftAppInfo AppScreen].width/2.0 - 20, 30) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
        [self addSubview:_addTimeLabel];
        //详情
        _detailLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 40, [HHSoftAppInfo AppScreen].width - 30, 20) fontSize:12.0 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
        [self addSubview:_detailLabel];
        //当前余额
        _userLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 0, [HHSoftAppInfo AppScreen].width/2.0 - 20, 30) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
        [self addSubview:_userLabel];
        //变动金额
        _changeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width/2.0+5, 0, [HHSoftAppInfo AppScreen].width/2.0 - 20, 30) fontSize:14.0 text:@"" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
        [self addSubview:_changeLabel];
    }
    return self;
}

- (void)setAccountChangeInfo:(AccountChangeInfo *)accountChangeInfo {
    _typeNameLabel.text = accountChangeInfo.accountChangeTitle;
    _addTimeLabel.text = accountChangeInfo.accountChangeTime;
    _detailLabel.text = accountChangeInfo.accountChangeDesc;
    _userLabel.text = [NSString stringWithFormat:@"当前余额：￥%@", [GlobalFile stringFromeFloat:accountChangeInfo.accountChangeFees decimalPlacesCount:2]];
    _changeLabel.text = [NSString stringWithFormat:@"%@", [GlobalFile stringFromeFloat:accountChangeInfo.accountChangeAmount decimalPlacesCount:2]];
    CGSize size = [accountChangeInfo.accountChangeDesc boundingRectWithfont:[UIFont systemFontOfSize:12.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width - 30, CGFLOAT_MAX)];
    _detailLabel.frame = CGRectMake(15, 40, [HHSoftAppInfo AppScreen].width - 30, size.height);
    _userLabel.frame = CGRectMake(15, CGRectGetMaxY(_detailLabel.frame) + 10, [HHSoftAppInfo AppScreen].width*2/3.0 - 20, 30);
    _changeLabel.frame = CGRectMake([HHSoftAppInfo AppScreen].width*2/3.0+5, CGRectGetMaxY(_detailLabel.frame) + 10, [HHSoftAppInfo AppScreen].width/3.0 - 20, 30);
}

+ (CGFloat)getCellHeightWith:(AccountChangeInfo *)accountChangeInfo {
    CGSize size = [accountChangeInfo.accountChangeDesc boundingRectWithfont:[UIFont systemFontOfSize:12.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width - 30, CGFLOAT_MAX)];
    return 30+10+size.height+10+30;
}

@end
