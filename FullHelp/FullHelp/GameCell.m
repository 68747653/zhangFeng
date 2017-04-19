//
//  GameCell.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/13.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "GameCell.h"
#import "GameInfo.h"
#import "GlobalFile.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import "UserInfo.h"
@interface GameCell ()
@property (nonatomic, strong) UIImageView *avatarImgView;
@property (nonatomic, strong) HHSoftLabel *nameLabel,*timeLabel,*merchantLabel;
@end

@implementation GameCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    _avatarImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    _avatarImgView.layer.cornerRadius = _avatarImgView.frame.size.height/2;
    _avatarImgView.layer.masksToBounds = YES;
    [self addSubview:_avatarImgView];
    
    _nameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_avatarImgView.frame)+10, 10, [HHSoftAppInfo AppScreen].width-CGRectGetMaxX(_avatarImgView.frame)-20, 20) fontSize:16 text:@"" textColor:nil textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [self addSubview:_nameLabel];
    
    _timeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_nameLabel.frame), 30, [HHSoftAppInfo AppScreen].width-CGRectGetMaxX(_avatarImgView.frame)-20, 20) fontSize:12 text:@"" textColor:[UIColor lightGrayColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [self addSubview:_timeLabel];
    
    _merchantLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_nameLabel.frame), 50, [HHSoftAppInfo AppScreen].width-CGRectGetMaxX(_avatarImgView.frame)-20, 20) fontSize:14 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [self addSubview:_merchantLabel];
}
- (void)setGameInfo:(GameInfo *)gameInfo {
    _gameInfo = gameInfo;
    [_avatarImgView sd_setImageWithURL:[NSURL URLWithString:_gameInfo.gameThumImg] placeholderImage:[GlobalFile HHSoftDefaultImg1_1]];
    _nameLabel.text = _gameInfo.gameName;
    _timeLabel.text = [NSString stringWithFormat:@"浏览%@秒可领取红包",[@(_gameInfo.gameBrowseTime) stringValue]];
    _merchantLabel.text = _gameInfo.userInfo.userMerchantName;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
