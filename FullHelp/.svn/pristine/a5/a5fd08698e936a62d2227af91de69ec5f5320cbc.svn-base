//
//  AttentionNewsViewCell.m
//  FullHelp
//
//  Created by hhsoft on 17/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AttentionNewsViewCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "AttentionInfo.h"
#import "NewsInfo.h"

@interface AttentionNewsViewCell ()
@property (nonatomic,strong) UIImageView *newsImageView,*videoImageView,*videoBgImageView;
@property (nonatomic,strong) HHSoftLabel *nameLabel,*timeLabel,*visitCountLabel,*collectCountLabel;

@end

@implementation AttentionNewsViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initAttentionNewsViewCell];
    }
    return self;
}
-(void)initAttentionNewsViewCell{
    //图片
    _newsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 100, 80)];
    _newsImageView.contentMode = UIViewContentModeScaleAspectFill;
    _newsImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_newsImageView];
    //视频背景图片
    _videoBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 100, 80)];
    _videoBgImageView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
    [self.contentView addSubview:_videoBgImageView];
    //视频图片
    _videoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 20, 40, 40)];
    _videoImageView.image = [UIImage imageNamed:@"attention_video.png"];
    [_videoBgImageView addSubview:_videoImageView];
    //名称
    _nameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(125, 10, [HHSoftAppInfo AppScreen].width-125-15, 40) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:2];
    [self.contentView addSubview:_nameLabel];
    //浏览数
    _visitCountLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(125, 60, 50, 30) fontSize:12.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
    [self.contentView addSubview:_visitCountLabel];
    //收藏数
    _collectCountLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(125+([HHSoftAppInfo AppScreen].width-125-15)/2.0, 60, ([HHSoftAppInfo AppScreen].width-125-15)/2.0, 30) fontSize:12.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
    [self.contentView addSubview:_collectCountLabel];
    //时间
    _timeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(125, 60, [HHSoftAppInfo AppScreen].width-125-15-5-_visitCountLabel.frame.size.width-_collectCountLabel.frame.size.width, 30) fontSize:12.0 text:@"" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [self.contentView addSubview:_timeLabel];
}
-(void)setAttentionInfo:(AttentionInfo *)attentionInfo{
    _attentionInfo = attentionInfo;
    //图片
    [_newsImageView sd_setImageWithURL:[NSURL URLWithString:_attentionInfo.newsInfo.newsImage] placeholderImage:[GlobalFile HHSoftDefaultImg5_4]];
    if (_attentionInfo.newsInfo.newsType == 1) {
        _videoBgImageView.hidden = NO;
    }else{
        _videoBgImageView.hidden = YES;
    }
    //名称
    _nameLabel.text = [NSString stringByReplaceNullString:_attentionInfo.newsInfo.newsTitle];
    //时间
    _timeLabel.text = [NSString stringByReplaceNullString:_attentionInfo.newsInfo.newsPublishTime];
    //浏览数
    _visitCountLabel.text = [NSString stringWithFormat:@" %@",[NSString stringByReplaceNullString:[@(_attentionInfo.newsInfo.newsVisitCount) stringValue]]];
    NSMutableAttributedString *textAtt=[[NSMutableAttributedString alloc] initWithString:_visitCountLabel.text];
    NSTextAttachment *atta=[[NSTextAttachment alloc] initWithData:nil ofType:nil];
    UIImage *sImage=[UIImage imageNamed:@"attention_visit.png"];
    atta.image=sImage;
    atta.bounds=CGRectMake(0, -(sImage.size.height/10.0), sImage.size.width, sImage.size.height);
    NSAttributedString *imgAttStr=[NSAttributedString attributedStringWithAttachment:atta];
    [textAtt insertAttributedString:imgAttStr atIndex:0];
    _visitCountLabel.attributedText=textAtt;
    //收藏数
    _collectCountLabel.text = [NSString stringWithFormat:@" %@",[NSString stringByReplaceNullString:[@(_attentionInfo.newsInfo.newsCollectCount) stringValue]]];
    NSMutableAttributedString *consultingAtt=[[NSMutableAttributedString alloc] initWithString:_collectCountLabel.text];
    NSTextAttachment *consultingAtta=[[NSTextAttachment alloc] initWithData:nil ofType:nil];
    UIImage *image=[UIImage imageNamed:@"attention_collect.png"];
    consultingAtta.image=image;
    consultingAtta.bounds=CGRectMake(0, -(image.size.height/10.0), image.size.width, image.size.height);
    NSAttributedString *consultingAttStr=[NSAttributedString attributedStringWithAttachment:consultingAtta];
    [consultingAtt insertAttributedString:consultingAttStr atIndex:0];
    _collectCountLabel.attributedText=consultingAtt;
    
    CGSize visitSize = [_visitCountLabel.text boundingRectWithfont:[UIFont systemFontOfSize:12.0] maxTextSize:CGSizeMake(([HHSoftAppInfo AppScreen].width-125-60)/2.0-sImage.size.width, 30)];
    
    CGSize collectSize = [_collectCountLabel.text boundingRectWithfont:[UIFont systemFontOfSize:12.0] maxTextSize:CGSizeMake(([HHSoftAppInfo AppScreen].width-125-60)/2.0-image.size.width, 30)];
    _collectCountLabel.frame = CGRectMake([HHSoftAppInfo AppScreen].width-15-collectSize.width-image.size.width, 60, collectSize.width+image.size.width, 30);
    _visitCountLabel.frame = CGRectMake([HHSoftAppInfo AppScreen].width-15-collectSize.width-image.size.width-visitSize.width-sImage.size.width, 60, visitSize.width+sImage.size.width, 30);
    
//    CGSize timeSize = [_timeLabel.text boundingRectWithfont:[UIFont systemFontOfSize:12.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-125-15-5-_visitCountLabel.frame.size.width-_collectCountLabel.frame.size.width, 30)];
    _timeLabel.frame = CGRectMake(125, 60, [HHSoftAppInfo AppScreen].width-125-15-5-_visitCountLabel.frame.size.width-_collectCountLabel.frame.size.width, 30);
}

@end
