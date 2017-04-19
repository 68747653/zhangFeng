//
//  NewsTableCell.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/7.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "NewsTableCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import "GlobalFile.h"
#import "NewsInfo.h"
#import "ImageInfo.h"
#import "NSMutableAttributedString+hhsoft.h"

@interface NewsTableCell ()

@property (nonatomic, strong) UIImageView *newsImgView, *videoImgView;
@property (nonatomic, strong) HHSoftLabel *titleLabel, *timeLabel, *visitCountLabel, *collectCountLabel;

@end

@implementation NewsTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    _newsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 80)];
    _newsImgView.layer.masksToBounds = YES;
    _newsImgView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_newsImgView];
    
    _videoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_newsImgView.frame)/2.0-15, CGRectGetHeight(_newsImgView.frame)/2.0-15, 30, 30)];
    _videoImgView.image = [UIImage imageNamed:@"attention_video"];
    _videoImgView.hidden = YES;
    [_newsImgView addSubview:_videoImgView];
    
    _titleLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_newsImgView.frame)+10, CGRectGetMinY(_newsImgView.frame), [HHSoftAppInfo AppScreen].width - CGRectGetMaxX(_newsImgView.frame) - 20, 50) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
    [self addSubview:_titleLabel];
    
    _timeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:12.0 text:@"" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [self addSubview:_timeLabel];
    
    _visitCountLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:12.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
    [self addSubview:_visitCountLabel];
    
    _collectCountLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:12.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
    [self addSubview:_collectCountLabel];
}

- (void)setNewsInfo:(NewsInfo *)newsInfo {
    _newsInfo = newsInfo;
    [_newsImgView sd_setImageWithURL:[NSURL URLWithString:newsInfo.newsImageInfo.imageThumb] placeholderImage:[GlobalFile HHSoftDefaultImg4_5]];
    if (newsInfo.newsType == 1) {
        _videoImgView.hidden = NO;
    } else {
        _videoImgView.hidden = YES;
    }
    _titleLabel.text = newsInfo.newsTitle;
    _timeLabel.text = newsInfo.newsPublishTime;
    
    NSMutableAttributedString *visitAttributed = [[NSMutableAttributedString alloc] init];
    [visitAttributed attributedStringWithImageStr:@"attention_visit" imageSize:CGSizeMake(18, 14)];
    [visitAttributed appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@", @(newsInfo.newsVisitCount)]]];
    _visitCountLabel.attributedText = visitAttributed;
    
    NSMutableAttributedString *colloctAttributed = [[NSMutableAttributedString alloc] init];
    [colloctAttributed attributedStringWithImageStr:@"attention_collect" imageSize:CGSizeMake(14, 14)];
    [colloctAttributed appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@", @(newsInfo.newsCollectCount)]]];
    _collectCountLabel.attributedText = colloctAttributed;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = [HHSoftAppInfo AppScreen].width - CGRectGetMaxX(_newsImgView.frame) - 20;
    _timeLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame), width/2.0, 30);
    _visitCountLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame)+width/2.0+5, CGRectGetMaxY(_titleLabel.frame), width/4.0-5, 30);
    _collectCountLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame)+width/4.0*3+5, CGRectGetMaxY(_titleLabel.frame), width/4.0-5, 30);
}

+ (CGFloat)getCellHeightWith:(NewsInfo *)newsInfo {
    return 100.0;
}

@end
