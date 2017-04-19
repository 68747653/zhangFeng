//
//  AccountTableCell.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AccountTableCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import <HHSoftFrameWorkKit/HHSoftButton.h>
#import "GlobalFile.h"
#import "AccountInfo.h"

@interface AccountTableCell ()

@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) HHSoftLabel *nameLabel, *accountLabel;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) HHSoftButton *setDefaultButton, *deleteButton;

@end

@implementation AccountTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    //图片
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 44, 44)];
    [self addSubview:_imgView];
    //姓名
    _nameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(64, 10, [HHSoftAppInfo AppScreen].width-64-10, 30) fontSize:12.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
    [self addSubview:_nameLabel];
    //账号
    _accountLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(64, 50, [HHSoftAppInfo AppScreen].width-64-10, 30) fontSize:12.0 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
    [self addSubview:_accountLabel];
    //分割线
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 90, [HHSoftAppInfo AppScreen].width-10, 0.5)];
    _lineView.backgroundColor = [GlobalFile colorWithRed:223.0 green:223.0 blue:223.0 alpha:1.0];
    [self addSubview:_lineView];
    //设置默认账号
    _setDefaultButton = [[HHSoftButton alloc] initWithFrame:CGRectMake(0, 90.5, [HHSoftAppInfo AppScreen].width/2.0, 40) innerImage:[UIImage imageNamed:@""] innerImageRect:CGRectMake(10, 12.5, 15, 15) descTextRect:CGRectMake(28, 0, [HHSoftAppInfo AppScreen].width/2.0-28, 40) descText:@"" textColor:[GlobalFile themeColor] textFont:[UIFont systemFontOfSize:13.0] textAligment:NSTextAlignmentLeft];
    [self addSubview:_setDefaultButton];
    [_setDefaultButton addTarget:self action:@selector(setDefaultButtonPress) forControlEvents:UIControlEventTouchUpInside];
    //删除
    _deleteButton = [[HHSoftButton alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width/2.0, 90.5, [HHSoftAppInfo AppScreen].width/2.0, 40) innerImage:[UIImage imageNamed:@"addressmanager_delete"] innerImageRect:CGRectMake([HHSoftAppInfo AppScreen].width/2.0-58, 12.5, 15, 15) descTextRect:CGRectMake([HHSoftAppInfo AppScreen].width/2.0-40, 0, 30, 40) descText:@"删除" textColor:[HHSoftAppInfo defaultDeepSystemColor] textFont:[UIFont systemFontOfSize:13.0] textAligment:NSTextAlignmentLeft];
    [self addSubview:_deleteButton];
    [_deleteButton addTarget:self action:@selector(deleteButtonPress) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setAccountInfo:(AccountInfo *)accountInfo {
    _accountInfo = accountInfo;
    //图片
    if (_accountInfo.accountType == 1) {
        _imgView.image = [UIImage imageNamed:@"account_alipay"];
    } else if (_accountInfo.accountType == 2) {
        _imgView.image = [UIImage imageNamed:@"account_weixin"];
    } else if (_accountInfo.accountType == 3) {
        _imgView.image = [UIImage imageNamed:@"account_card"];
    }
    if (accountInfo.accountBankName.length) {
        //姓名
        _nameLabel.text = [NSString stringWithFormat:@"%@(%@)", [NSString stringByReplaceNullString:accountInfo.accountCardHolder], [NSString stringByReplaceNullString:accountInfo.accountBankName]];
    } else {
        //姓名
        _nameLabel.text = [NSString stringWithFormat:@"%@", [NSString stringByReplaceNullString:accountInfo.accountCardHolder]];
    }
    CGSize nameSize = [_nameLabel.text boundingRectWithfont:[UIFont systemFontOfSize:12.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-64-10, CGFLOAT_MAX)];
    _nameLabel.frame = CGRectMake(64, 10, [HHSoftAppInfo AppScreen].width-64-10, nameSize.height);
    //账号
    _accountLabel.text = [NSString stringWithFormat:@"账号：%@",[NSString stringByReplaceNullString:accountInfo.accountNo]];
    CGSize accountSize = [_accountLabel.text boundingRectWithfont:[UIFont systemFontOfSize:12.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-64-10, CGFLOAT_MAX)];
    _accountLabel.frame = CGRectMake(64, 10+nameSize.height+10, [HHSoftAppInfo AppScreen].width-64-10, accountSize.height);
    //分割线
    _lineView.frame = CGRectMake(10, 10+nameSize.height+10+accountSize.height+10, [HHSoftAppInfo AppScreen].width-10, 0.5);
    //删除
    _deleteButton.frame = CGRectMake([HHSoftAppInfo AppScreen].width/2.0, 10+nameSize.height+10+accountSize.height+10+0.5, [HHSoftAppInfo AppScreen].width/2.0, 40);
    //设置默认账号
    _setDefaultButton.frame = CGRectMake(0, 10+nameSize.height+10+accountSize.height+10+0.5, [HHSoftAppInfo AppScreen].width/2.0, 40);
    if (accountInfo.accountIsDefault) {
        [_setDefaultButton setSelectImage:[UIImage imageNamed:@"login_agree"] descText:@"默认账户" textColor:[GlobalFile themeColor] textFont:[UIFont systemFontOfSize:13.0]];
    } else {
        [_setDefaultButton setSelectImage:[UIImage imageNamed:@"login_no_agree"] descText:@"设置默认账户" textColor:[HHSoftAppInfo defaultDeepSystemColor] textFont:[UIFont systemFontOfSize:13.0]];
    }
}

+ (CGFloat)getCellHeightWith:(AccountInfo *)accountInfo {
    CGSize nameSize;
    if (accountInfo.accountBankName.length) {
        nameSize = [[NSString stringWithFormat:@"%@(%@)", [NSString stringByReplaceNullString:accountInfo.accountCardHolder], [NSString stringByReplaceNullString:accountInfo.accountBankName]] boundingRectWithfont:[UIFont systemFontOfSize:12.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-64-10, CGFLOAT_MAX)];
    } else {
        nameSize = [[NSString stringWithFormat:@"%@",[NSString stringByReplaceNullString:accountInfo.accountCardHolder]] boundingRectWithfont:[UIFont systemFontOfSize:12.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-64-10, CGFLOAT_MAX)];
    }
    CGSize accountSize = [[NSString stringWithFormat:@"账号：%@",[NSString stringByReplaceNullString:accountInfo.accountNo]] boundingRectWithfont:[UIFont systemFontOfSize:12.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-64-10, CGFLOAT_MAX)];
    return 10+nameSize.height+10+accountSize.height+10+0.5+40;
}

#pragma mark -- 设置默认账号按钮点击事件
- (void)setDefaultButtonPress {
    if (_accountInfo.accountIsDefault == 0) {
        if (_setDefaultAccountBlock) {
            _setDefaultAccountBlock();
        }
    }
}

#pragma mark -- 删除按钮点击事件
- (void)deleteButtonPress {
    if (_deleteAccountBlock) {
        _deleteAccountBlock();
    }
}

@end
