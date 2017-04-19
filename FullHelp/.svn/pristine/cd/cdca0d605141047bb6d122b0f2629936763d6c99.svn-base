//
//  AttentionAdvertViewCell.m
//  FullHelp
//
//  Created by hhsoft on 17/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AttentionAdvertViewCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "AttentionInfo.h"
#import "AdvertInfo.h"

@interface AttentionAdvertViewCell ()
@property (nonatomic,strong) UIImageView *advertImageView;
@property (nonatomic,strong) HHSoftLabel *nameLabel,*praiseCountLabel,*collectCountLabel;

@end

@implementation AttentionAdvertViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initAttentionAdvertViewCell];
    }
    return self;
}
-(void)initAttentionAdvertViewCell{
    //图片
    _advertImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 100, 80)];
    _advertImageView.contentMode = UIViewContentModeScaleAspectFill;
    _advertImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_advertImageView];
    //名称
    _nameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(125, 10, [HHSoftAppInfo AppScreen].width-125-15, 40) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:2];
    [self.contentView addSubview:_nameLabel];
    //点赞数
    _praiseCountLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(125, 60, ([HHSoftAppInfo AppScreen].width-125-15)/2.0, 30) fontSize:12.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [self.contentView addSubview:_praiseCountLabel];
    //收藏数
    _collectCountLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(125+([HHSoftAppInfo AppScreen].width-125-15)/2.0, 60, ([HHSoftAppInfo AppScreen].width-125-15)/2.0, 30) fontSize:12.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
    [self.contentView addSubview:_collectCountLabel];
}
-(void)setAttentionInfo:(AttentionInfo *)attentionInfo{
    _attentionInfo = attentionInfo;
    //图片
    [_advertImageView sd_setImageWithURL:[NSURL URLWithString:_attentionInfo.advertInfo.advertImg] placeholderImage:[GlobalFile HHSoftDefaultImg5_4]];
    //名称
    _nameLabel.text = [NSString stringByReplaceNullString:_attentionInfo.advertInfo.merchantName];
    //点赞数
    _praiseCountLabel.text = [NSString stringWithFormat:@" %@",[NSString stringByReplaceNullString:_attentionInfo.advertInfo.advertPraiseCount]];
    NSMutableAttributedString *textAtt=[[NSMutableAttributedString alloc] initWithString:_praiseCountLabel.text];
    NSTextAttachment *atta=[[NSTextAttachment alloc] initWithData:nil ofType:nil];
    UIImage *sImage=[UIImage imageNamed:@"attention_praise.png"];
    atta.image=sImage;
    atta.bounds=CGRectMake(0, -(sImage.size.height/10.0), sImage.size.width, sImage.size.height);
    NSAttributedString *imgAttStr=[NSAttributedString attributedStringWithAttachment:atta];
    [textAtt insertAttributedString:imgAttStr atIndex:0];
    _praiseCountLabel.attributedText=textAtt;
    //收藏数
    _collectCountLabel.text = [NSString stringWithFormat:@" %@",[NSString stringByReplaceNullString:_attentionInfo.advertInfo.advertCollectCount]];
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
