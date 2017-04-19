//
//  PointsChangeTableCell.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/9.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "PointsChangeTableCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "ChangeRecordInfo.h"

@interface PointsChangeTableCell ()

@property (nonatomic, strong) HHSoftLabel *typeNameLabel, *addTimeLabel, *detailLabel, *userPointsLabel, *changePointsLabel;

@end

@implementation PointsChangeTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    //变动类型标签
    _typeNameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 0, [HHSoftAppInfo AppScreen].width/2.0 - 20, 30) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [self addSubview:_typeNameLabel];
    //时间标签
    _addTimeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width/2.0+5, 0, [HHSoftAppInfo AppScreen].width/2.0 - 20, 30) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
    [self addSubview:_addTimeLabel];
    //详情标签
    _detailLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 40, [HHSoftAppInfo AppScreen].width - 30, 20) fontSize:12.0 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
    [self addSubview:_detailLabel];
    //当前积分标签
    _userPointsLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [self addSubview:_userPointsLabel];
    //变动积分标签
    _changePointsLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:14.0 text:@"" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
    [self addSubview:_changePointsLabel];
}

- (void)setChangeRecordInfo:(ChangeRecordInfo *)changeRecordInfo {
    if (changeRecordInfo.changeTypeName.length) {
        _typeNameLabel.text = [NSString stringWithFormat:@"变动类型：%@", changeRecordInfo.changeTypeName];
    } else {
        _typeNameLabel.text = @"";
    }
    _addTimeLabel.text = changeRecordInfo.changeTime;
    _detailLabel.text = [NSString stringWithFormat:@"%@", changeRecordInfo.changeMemo];
    _userPointsLabel.text = [NSString stringWithFormat:@"当前金币：%@", @(changeRecordInfo.changeUserPoints)];
    _changePointsLabel.text = [NSString stringWithFormat:@"%@", @(changeRecordInfo.changePoints)];
    CGSize size = [changeRecordInfo.changeMemo boundingRectWithfont:[UIFont systemFontOfSize:12.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width - 30, CGFLOAT_MAX)];
    _detailLabel.frame = CGRectMake(15, 40, [HHSoftAppInfo AppScreen].width - 30, size.height);
    _userPointsLabel.frame = CGRectMake(15, CGRectGetMaxY(_detailLabel.frame) + 10, [HHSoftAppInfo AppScreen].width*2/3.0 - 20, 30);
    _changePointsLabel.frame = CGRectMake([HHSoftAppInfo AppScreen].width*2/3.0+5, CGRectGetMaxY(_detailLabel.frame) + 10, [HHSoftAppInfo AppScreen].width/3.0 - 20, 30);
}

+ (CGFloat)getCellHeightWith:(ChangeRecordInfo *)changeRecordInfo {
    CGSize size = [changeRecordInfo.changeMemo boundingRectWithfont:[UIFont systemFontOfSize:12.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width - 30, CGFLOAT_MAX)];
    return 30+10+size.height+10+30;
}

@end
