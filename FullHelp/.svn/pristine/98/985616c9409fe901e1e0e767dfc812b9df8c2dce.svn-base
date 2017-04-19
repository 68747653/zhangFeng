//
//  MyPublishViewCell.m
//  FullHelp
//
//  Created by hhsoft on 17/2/7.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "MyPublishViewCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "DemandNoticeInfo.h"
#import "UserInfo.h"
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
@interface MyPublishViewCell ()
@property (nonatomic,strong) UIImageView *demandNoticeImageView;
@property (nonatomic,strong) HHSoftLabel *nameLabel,*timeLabel,*collectCountLabel,*merchantLabel;

@end

@implementation MyPublishViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initMyPublishViewCell];
    }
    return self;
}
-(void)initMyPublishViewCell{
    //图片
    _demandNoticeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 100, 80)];
    _demandNoticeImageView.contentMode = UIViewContentModeScaleAspectFill;
    _demandNoticeImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_demandNoticeImageView];
    //名称
    _nameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(125, 10, [HHSoftAppInfo AppScreen].width-125-15, 20) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:2];
    [self.contentView addSubview:_nameLabel];
    
    _merchantLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:14 text:@"" textColor:[UIColor lightGrayColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [self addSubview:_merchantLabel];
    //时间
    _timeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(125, 65, ([HHSoftAppInfo AppScreen].width-125-15)/2.0, 30) fontSize:12.0 text:@"" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [self.contentView addSubview:_timeLabel];
    //收藏数
    _collectCountLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(125+([HHSoftAppInfo AppScreen].width-125-15)/2.0, 60, ([HHSoftAppInfo AppScreen].width-125-15)/2.0, 30) fontSize:12.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
    [self.contentView addSubview:_collectCountLabel];
}
-(void)setDemandNoticeInfo:(DemandNoticeInfo *)demandNoticeInfo{
    _demandNoticeInfo = demandNoticeInfo;
    //图片
    [_demandNoticeImageView sd_setImageWithURL:[NSURL URLWithString:_demandNoticeInfo.demandNoticeThumbImg] placeholderImage:[GlobalFile HHSoftDefaultImg5_4]];
    //名称
    _nameLabel.text = _demandNoticeInfo.demandNoticeName;
    CGSize size = [_nameLabel.text boundingRectWithfont:_nameLabel.font maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-125-15, 100)];
    if (size.height > 17.0) {
        _nameLabel.frame = CGRectMake(125, 10, [HHSoftAppInfo AppScreen].width-125-15, 34);
    }
    else {
        _nameLabel.frame = CGRectMake(125, 10, [HHSoftAppInfo AppScreen].width-125-15, 20);
    }
//    [_nameLabel sizeToFit];
    
    _merchantLabel.text = [NSString stringByReplaceNullString:_demandNoticeInfo.userInfo.userMerchantName];
    _merchantLabel.frame = CGRectMake(CGRectGetMinX(_nameLabel.frame), CGRectGetMaxY(_nameLabel.frame)+5, [HHSoftAppInfo AppScreen].width-125-15, 20);
    
    //时间
    _timeLabel.text = [NSString stringByReplaceNullString:_demandNoticeInfo.demandNoticeAddTime];
    //收藏数
    _collectCountLabel.text = [NSString stringWithFormat:@" %@",[NSString stringByReplaceNullString:[@(_demandNoticeInfo.demandNoticeCollectCount) stringValue]]];
    NSMutableAttributedString *consultingAtt=[[NSMutableAttributedString alloc] initWithString:_collectCountLabel.text];
    NSTextAttachment *consultingAtta=[[NSTextAttachment alloc] initWithData:nil ofType:nil];
    UIImage *image=[UIImage imageNamed:@"attention_collect.png"];
    consultingAtta.image=image;
    consultingAtta.bounds=CGRectMake(0, -(image.size.height/10.0), image.size.width, image.size.height);
    NSAttributedString *consultingAttStr=[NSAttributedString attributedStringWithAttachment:consultingAtta];
    [consultingAtt insertAttributedString:consultingAttStr atIndex:0];
    _collectCountLabel.attributedText=consultingAtt;
    
    CGSize collectSize = [_collectCountLabel.text boundingRectWithfont:[UIFont systemFontOfSize:12.0] maxTextSize:CGSizeMake(([HHSoftAppInfo AppScreen].width-125-60)/2.0-image.size.width, 30)];
    _collectCountLabel.frame = CGRectMake([HHSoftAppInfo AppScreen].width-15-collectSize.width-image.size.width, 60, collectSize.width+image.size.width, 30);
    _timeLabel.frame = CGRectMake(125, 65, [HHSoftAppInfo AppScreen].width-125-15-5-_collectCountLabel.frame.size.width, 30);
}

@end
