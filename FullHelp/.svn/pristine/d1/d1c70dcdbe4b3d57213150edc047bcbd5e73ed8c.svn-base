//
//  RechargeRecordTableCell.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "RechargeRecordTableCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "AccountChangeInfo.h"

@interface RechargeRecordTableCell ()

@property (nonatomic, strong) HHSoftLabel *typeNameLabel, *addTimeLabel, *userLabel, *changeLabel;

@end

@implementation RechargeRecordTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //变动类型
        _typeNameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 0, [HHSoftAppInfo AppScreen].width/2.0 - 20, 30) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
        [self addSubview:_typeNameLabel];
        
        //变动金额
        _changeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width/2.0+5, 0, [HHSoftAppInfo AppScreen].width/2.0 - 20, 30) fontSize:14.0 text:@"" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
        [self addSubview:_changeLabel];
        
        //时间
        _addTimeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 30, [HHSoftAppInfo AppScreen].width/2.0-20, 30) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
        [self addSubview:_addTimeLabel];
        
        //当前余额
        _userLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width/2.0+5, 30, [HHSoftAppInfo AppScreen].width/2.0 - 20, 30) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
        [self addSubview:_userLabel];
    }
    return self;
}

- (void)setAccountChangeInfo:(AccountChangeInfo *)accountChangeInfo {
    _typeNameLabel.text = accountChangeInfo.accountChangeTitle;
    _changeLabel.text = [NSString stringWithFormat:@"%@", [GlobalFile stringFromeFloat:accountChangeInfo.accountChangeAmount decimalPlacesCount:2]];
    _addTimeLabel.text = accountChangeInfo.accountChangeTime;
    _userLabel.text = [NSString stringWithFormat:@"余额：￥%@", [GlobalFile stringFromeFloat:accountChangeInfo.accountChangeFees decimalPlacesCount:2]];
}

+ (CGFloat)getCellHeightWith:(AccountChangeInfo *)accountChangeInfo {
    return 60.0;
}

@end
