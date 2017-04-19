//
//  PointsRuleTableCell.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/9.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "PointsRuleTableCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "RuleInfo.h"

@interface PointsRuleTableCell ()

@property (nonatomic, strong) HHSoftLabel *pointRuleLabel, *pointLabel;

@end

@implementation PointsRuleTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    //规则标签
    _pointRuleLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
    [self addSubview:_pointRuleLabel];
    //积分标签
    _pointLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width - 55, 10, 40, 20) fontSize:14.0 text:@"" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
    [self addSubview:_pointLabel];
}

- (void)setRuleInfo:(RuleInfo *)ruleInfo {
    CGSize size = [ruleInfo.ruleName boundingRectWithfont:[UIFont systemFontOfSize:14.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width - 70, 10000)];
    _pointRuleLabel.frame = CGRectMake(15, 10, [HHSoftAppInfo AppScreen].width - 70, size.height);
    _pointRuleLabel.text = ruleInfo.ruleName;
    _pointLabel.frame = CGRectMake([HHSoftAppInfo AppScreen].width - 55, 10, 40, size.height);
    _pointLabel.text = [NSString stringWithFormat:@"%@", @(ruleInfo.rulePoints)];
}

+ (CGFloat)getCellHeightWith:(RuleInfo *)ruleInfo {
    CGSize size = [ruleInfo.ruleName boundingRectWithfont:[UIFont systemFontOfSize:14.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width - 70, CGFLOAT_MAX)];
    return size.height + 20;
}


@end
