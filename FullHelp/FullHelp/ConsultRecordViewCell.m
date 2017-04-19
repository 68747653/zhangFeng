//
//  ConsultRecordViewCell.m
//  FullHelp
//
//  Created by hhsoft on 17/2/7.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "ConsultRecordViewCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "ConsultRecordInfo.h"
#import "UserInfo.h"
#import "AdvertInfo.h"

@interface ConsultRecordViewCell ()
@property (nonatomic,strong) UIImageView *recordImageView;
@property (nonatomic,strong) HHSoftLabel *nameLabel,*telLabel,*timeLabel;

@end

@implementation ConsultRecordViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initAttentionAdvertViewCell];
    }
    return self;
}
-(void)initAttentionAdvertViewCell{
    //图片
    _recordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 60, 60)];
    _recordImageView.contentMode = UIViewContentModeScaleAspectFill;
    _recordImageView.layer.cornerRadius = _recordImageView.frame.size.width/2.0;
    _recordImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_recordImageView];
    //名称
    _nameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(85, 10, [HHSoftAppInfo AppScreen].width-85-15, 30) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:2];
    [self.contentView addSubview:_nameLabel];
    //电话
    _telLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(85, 40, ([HHSoftAppInfo AppScreen].width-85-15)/2.0, 30) fontSize:14.0 text:@"" textColor:[UIColor grayColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [self.contentView addSubview:_telLabel];
    //时间
    _timeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(85+([HHSoftAppInfo AppScreen].width-85-15)/2.0, 40, ([HHSoftAppInfo AppScreen].width-85-15)/2.0, 30) fontSize:14.0 text:@"" textColor:[UIColor grayColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
    [self.contentView addSubview:_timeLabel];
}
-(void)setConsultRecordInfo:(ConsultRecordInfo *)consultRecordInfo{
    _consultRecordInfo = consultRecordInfo;
    //图片
    [_recordImageView sd_setImageWithURL:[NSURL URLWithString:_consultRecordInfo.userInfo.userHeadImg] placeholderImage:[GlobalFile HHSoftDefaultImg1_1]];
    //名称
    _nameLabel.text = [NSString stringByReplaceNullString:_consultRecordInfo.userInfo.userNickName];
    //电话
    if (_consultRecordInfo.userInfo.userTelPhone.length) {
        _telLabel.text = [NSString stringByReplaceNullString:_consultRecordInfo.userInfo.userTelPhone];
    }else{
        _telLabel.text = [NSString stringByReplaceNullString:_consultRecordInfo.userInfo.userLoginName];
    }
    //时间
    _timeLabel.text = [NSString stringByReplaceNullString:_consultRecordInfo.consultRecordAddTime];
}

@end
