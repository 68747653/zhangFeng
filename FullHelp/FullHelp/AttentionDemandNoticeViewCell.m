//
//  AttentionDemandNoticeViewCell.m
//  FullHelp
//
//  Created by hhsoft on 17/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AttentionDemandNoticeViewCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "AttentionInfo.h"
#import "DemandNoticeInfo.h"

@interface AttentionDemandNoticeViewCell ()
@property (nonatomic,strong) UIImageView *demandNoticeImageView;
@property (nonatomic,strong) HHSoftLabel *nameLabel,*timeLabel,*collectCountLabel;

@end

@implementation AttentionDemandNoticeViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initAttentionAdvertViewCell];
    }
    return self;
}
-(void)initAttentionAdvertViewCell{
    //图片
    _demandNoticeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 100, 80)];
    _demandNoticeImageView.contentMode = UIViewContentModeScaleAspectFill;
    _demandNoticeImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_demandNoticeImageView];
    //名称
    _nameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(125, 10, [HHSoftAppInfo AppScreen].width-125-15, 40) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:2];
    [self.contentView addSubview:_nameLabel];
    //时间
    _timeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(125, 60, ([HHSoftAppInfo AppScreen].width-125-15)/2.0, 30) fontSize:12.0 text:@"" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [self.contentView addSubview:_timeLabel];
    //收藏数
    _collectCountLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(125+([HHSoftAppInfo AppScreen].width-125-15)/2.0, 60, ([HHSoftAppInfo AppScreen].width-125-15)/2.0, 30) fontSize:12.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
    [self.contentView addSubview:_collectCountLabel];
}
-(void)setAttentionInfo:(AttentionInfo *)attentionInfo{
    _attentionInfo = attentionInfo;
    //图片
    [_demandNoticeImageView sd_setImageWithURL:[NSURL URLWithString:_attentionInfo.demandNoticeInfo.demandNoticeThumbImg] placeholderImage:[GlobalFile HHSoftDefaultImg5_4]];
    //名称
    _nameLabel.text = [NSString stringByReplaceNullString:_attentionInfo.demandNoticeInfo.demandNoticeName];
    //时间
    _timeLabel.text = [NSString stringByReplaceNullString:_attentionInfo.demandNoticeInfo.demandNoticeAddTime];
    //收藏数
    _collectCountLabel.text = [NSString stringWithFormat:@" %@",[NSString stringByReplaceNullString:[@(_attentionInfo.demandNoticeInfo.demandNoticeCollectCount) stringValue]]];
    NSMutableAttributedString *consultingAtt=[[NSMutableAttributedString alloc] initWithString:_collectCountLabel.text];
    NSTextAttachment *consultingAtta=[[NSTextAttachment alloc] initWithData:nil ofType:nil];
    UIImage *image=[UIImage imageNamed:@"attention_collect.png"];
    consultingAtta.image=image;
    consultingAtta.bounds=CGRectMake(0, -(image.size.height/10.0), image.size.width, image.size.height);
    NSAttributedString *consultingAttStr=[NSAttributedString attributedStringWithAttachment:consultingAtta];
    [consultingAtt insertAttributedString:consultingAttStr atIndex:0];
    _collectCountLabel.attributedText=consultingAtt;
}

@end
