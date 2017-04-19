//
//  SystemMassageViewCell.m
//  FullHelp
//
//  Created by hhsoft on 17/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "SystemMassageViewCell.h"
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "MessageInfo.h"

@interface SystemMassageViewCell()
@property (nonatomic,strong) UIImageView *massageImageView;
@property (nonatomic,strong) HHSoftLabel *typeLabel,*titleLabel, *timeLabel, *detailLabel;

@end

@implementation SystemMassageViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initWithSystemMassageViewCell];
    }
    return self;
}

-(void)initWithSystemMassageViewCell{
    //图片
    _massageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 40, 40)];
    _massageImageView.image = [UIImage imageNamed:@"massage_image.png"];
    [self.contentView addSubview:_massageImageView];
    //状态
    _typeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(45, 10, 10, 10) fontSize:13.0 text:@"" textColor:[UIColor redColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
    _typeLabel.layer.cornerRadius = _typeLabel.frame.size.width/2.0;
    _typeLabel.layer.masksToBounds = YES;
    _typeLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_typeLabel];
    //标题
    _titleLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(65, 5, [HHSoftAppInfo AppScreen].width-65-80-15, 25) fontSize:14.0 text:@"" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [self.contentView addSubview:_titleLabel];
    //时间
    _timeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width-80-15, 5, 80, 25) fontSize:12.0 text:@"" textColor:[UIColor lightGrayColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
    [self addSubview:_timeLabel];
    //详情
    _detailLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(65, 30, [HHSoftAppInfo AppScreen].width-65-15, 25) fontSize:12.0 text:@"" textColor:[UIColor lightGrayColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
    [self addSubview:_detailLabel];
}

- (void)setMessageInfo:(MessageInfo *)messageInfo {
    //0:未处理 1：已推送 2：已读
    if (messageInfo.messageState == 2) {
        _typeLabel.hidden = YES;
    }else{
        _typeLabel.hidden = NO;
    }
    _titleLabel.text = [NSString stringByReplaceNullString:messageInfo.messageTypeStr];
    _timeLabel.text = [NSString stringByReplaceNullString:messageInfo.messageAddTime];
    _detailLabel.text = [NSString stringByReplaceNullString:messageInfo.messageTitle];
    CGSize size = [[NSString stringByReplaceNullString:messageInfo.messageContent] boundingRectWithfont:[UIFont systemFontOfSize:12.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-65-15,CGFLOAT_MAX)];
    if (size.height<25) {
        _detailLabel.frame = CGRectMake(65, 30, [HHSoftAppInfo AppScreen].width-65-15, 25);
    }else{
        _detailLabel.frame = CGRectMake(65, 30, [HHSoftAppInfo AppScreen].width-65-15, size.height);
    }
}

+ (CGFloat)getCellHeightWithMessageInfo:(MessageInfo *)mesageInfo {
    CGSize size = [mesageInfo.messageContent boundingRectWithfont:[UIFont systemFontOfSize:12.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-65-15,CGFLOAT_MAX)];
    if (size.height<25) {
        return 60;
    }else{
        return 30+size.height+10;
    }
}

@end
