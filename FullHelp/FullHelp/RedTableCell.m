//
//  RedTableCell.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/13.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "RedTableCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "AccountChangeInfo.h"

@interface RedTableCell ()

@property (nonatomic, strong) HHSoftLabel *typeNameLabel, *addTimeLabel, *changeLabel;

@end

@implementation RedTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //类型
        _typeNameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 0, [HHSoftAppInfo AppScreen].width/2.0 - 20, 30) fontSize:14.0 text:@"" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
        [self addSubview:_typeNameLabel];
        
        //金额
        _changeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width/2.0+5, 0, [HHSoftAppInfo AppScreen].width/2.0 - 20, 30) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
        [self addSubview:_changeLabel];
        
        //时间
        _addTimeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 30, [HHSoftAppInfo AppScreen].width-30, 30) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
        [self addSubview:_addTimeLabel];
        
    }
    return self;
}

- (void)setAccountChangeInfo:(AccountChangeInfo *)accountChangeInfo {
    _typeNameLabel.text = accountChangeInfo.accountChangeTitle;
    _changeLabel.text = [NSString stringWithFormat:@"%@元", [GlobalFile stringFromeFloat:accountChangeInfo.accountChangeAmount decimalPlacesCount:2]];
    _addTimeLabel.text = accountChangeInfo.accountChangeTime;
}

+ (CGFloat)getCellHeightWith:(AccountChangeInfo *)accountChangeInfo {
    return 60.0;
}

@end
