//
//  TodayCell.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "TodayCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import "NSMutableAttributedString+hhsoft.h"
#import "RedPacketInfo.h"
#import "GlobalFile.h"
#import "CirclePorgressView.h"
#import "RedPacketView.h"
#import "OpenRedPacketInfoViewController.h"
#import "MainTabBarController.h"
#import "MainNavgationController.h"
#import "HHSoftHeader.h"
@interface TodayCell ()
@property (nonatomic, strong) UIView *bgView,*shadowImgView,*bottomView;
@property (nonatomic, strong) UIImageView *advertImg,*redPacketImg,*stateImg;
@property (nonatomic, strong) HHSoftLabel *titleLabel,*lastTimeHintLabel;
@property (nonatomic, copy) NSString *hour;
@property (nonatomic, copy) NSString *minute;
@property (nonatomic, copy) NSString *second;
@property (nonatomic, strong) NSTimer *countDownTimer;
@property (nonatomic, copy) NSString *countDownStr;
@property (nonatomic, strong) HHSoftLabel *countDownLabel;
@property (nonatomic, strong)CirclePorgressView *circlePorgressView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) RedPacketView *redPacketView;
    
    /**
     cellType = 1 专场红包   cellType = 0 今日红包
     */
    @property (nonatomic, assign) NSInteger cellType;
@end

@implementation TodayCell

- (void)dealloc {
    if (self.countDownTimer.isValid) {
        [self.countDownTimer invalidate];
        self.countDownTimer = nil;
    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellAccessoryNone;
        [self setUI];
    }
    return self;
}
- (instancetype)initSpecialRedpacketCellWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [self initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellType = 1;
    }
    return self;
}
- (void)setUI {
    self.backgroundColor = [UIColor clearColor];
    _shadowImgView = [[UIView alloc] initWithFrame:CGRectZero];
//    _shadowImgView.backgroundColor = [UIColor redColor];
    _shadowImgView.layer.shadowColor = [UIColor blackColor].CGColor;
    _shadowImgView.layer.shadowOffset = CGSizeMake(1, 1);
    _shadowImgView.layer.shadowOpacity = 0.3;
    _shadowImgView.layer.shadowRadius = 5.0f;
    [self addSubview:_shadowImgView];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _bgView.layer.cornerRadius = 5.0f;
    _bgView.layer.masksToBounds = YES;
    _bgView.backgroundColor = [UIColor whiteColor];
    [_shadowImgView addSubview:_bgView];
    
    _advertImg = [[UIImageView alloc] init];
//    _advertImg.backgroundColor = [UIColor brownColor];
    [_bgView addSubview:_advertImg];
    
    _redPacketImg = [[UIImageView alloc] init];
    _redPacketImg.image = [UIImage imageNamed:@"today_redPacket.png"];
    _redPacketImg.userInteractionEnabled = YES;
    [_bgView addSubview:_redPacketImg];
    
    
    _stateImg = [[UIImageView alloc] init];
    [_redPacketImg addSubview:_stateImg];
    
    _titleLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:16 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:2];
    [_bgView addSubview:_titleLabel];
    
    _lastTimeHintLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:12 text:@"距开奖还剩" textColor:[UIColor whiteColor] textAlignment:1 numberOfLines:1];
    [_redPacketImg addSubview:_lastTimeHintLabel];
    
    _countDownLabel = [[HHSoftLabel alloc] initWithFrame:CGRectZero fontSize:12 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
    [_redPacketImg addSubview:_countDownLabel];
    
    
    CirclePorgressView *circlePorgressView = [[CirclePorgressView alloc] init];
    
    circlePorgressView.backgroundColor = [UIColor clearColor];
    [_redPacketImg addSubview:circlePorgressView];
    self.circlePorgressView = circlePorgressView;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.cornerRadius = 3.0f;
    button.layer.masksToBounds = YES;
    
    [button setTitle:@" 点击领取 " forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [_redPacketImg addSubview:button];
    self.button = button;
}
- (void)buttonClick {
    [[NSNotificationCenter defaultCenter] postNotificationName:GetTodayRedpacketNotification object:_redPacketInfo];
    _redPacketView = [[RedPacketView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height) openRedPacket:^(NSString *amount) {
        _redPacketView.redPacketInfo.redPacketAmount = amount;
        _redPacketInfo.state = 2;
        OpenRedPacketInfoViewController*openRedPacketInfoViewController = [[OpenRedPacketInfoViewController alloc] initWithRedPacketInfo:_redPacketView.redPacketInfo];
        openRedPacketInfoViewController.hidesBottomBarWhenPushed = YES;
        MainTabBarController *mainTabBarController = (MainTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        MainNavgationController *nav = mainTabBarController.viewControllers[mainTabBarController.selectedIndex];
        [nav pushViewController:openRedPacketInfoViewController animated:YES];
        [_redPacketView removeFromSuperview];
        
    }];
    _redPacketView.redPacketInfo = _redPacketInfo;
    _redPacketView.advertID  = _redPacketInfo.redPacketID;
    if (self.cellType == 1) {
        _redPacketView.redPacketType = RedPacketTypeAdvertRed;
    }
    else {
        _redPacketView.redPacketType = RedPacketTypeToday;
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:_redPacketView];
}
#pragma mark ------ 倒计时
- (void)startTimeCountDown {
    if (_redPacketInfo.startTime>0) {
        _redPacketInfo.startTime--;
        _countDownStr = [NSString stringWithFormat:@"%@",[self timeformatFromSeconds:_redPacketInfo.startTime]];
        
        _countDownLabel.attributedText = [self changeCountDownLabelTextWithStr:_countDownStr];
        if (_redPacketInfo.startTime == 0) {
//            [_countDownTimer invalidate];
//            _countDownTimer = nil;
        }
    }
    else {
//        [_countDownTimer invalidate];
//        _countDownTimer = nil;

    }
}
- (void)setRedPacketInfo:(RedPacketInfo *)redPacketInfo {
    _redPacketInfo = redPacketInfo;
    [_advertImg sd_setImageWithURL:[NSURL URLWithString:_redPacketInfo.redPacketImg] placeholderImage:[GlobalFile HHSoftDefaultImg2_1]];
    _titleLabel.text = _redPacketInfo.redPacketTitle;
//     状态 0：疯抢中，1：已结束， 2：已领取 ，3：已抢光 4：未开始
    _stateImg.hidden = YES;
    _lastTimeHintLabel.hidden = YES;
    _countDownLabel.hidden = YES;
    _circlePorgressView.hidden = YES;
    _button.hidden = YES;
//    _redPacketInfo.sendCount = 200;
//    _redPacketInfo.redPacketCount = 1000;
    CGFloat sendCount = _redPacketInfo.sendCount;
    CGFloat redPacketCount = _redPacketInfo.redPacketCount;
    CGFloat progress = sendCount/redPacketCount;
    _circlePorgressView.progress = progress;
    if (_redPacketInfo.state==0) {
        _circlePorgressView.hidden = NO;
        _button.hidden = NO;
    }
    else if (_redPacketInfo.state==1) {
        _stateImg.image = [UIImage imageNamed:@"redPacket_over.png"];
        _stateImg.hidden = NO;
    }
    else if (_redPacketInfo.state==2) {
        _stateImg.image = [UIImage imageNamed:@"redPacket_found.png"];
        _stateImg.hidden = NO;
    }
    else if (_redPacketInfo.state==3) {
        _stateImg.image = [UIImage imageNamed:@"redPacket_finish.png"];
        _stateImg.hidden = NO;
    }
    else if (_redPacketInfo.state==4) {
        _lastTimeHintLabel.hidden = NO;
        _countDownLabel.hidden = NO;
        
    }
    if (!_countDownTimer) {
        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startTimeCountDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_countDownTimer forMode:UITrackingRunLoopMode];
        [_countDownTimer fire];
    }
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = [HHSoftAppInfo AppScreen].width-20;
    CGFloat height = width/3;
    _shadowImgView.frame = CGRectMake(10, 5, width, self.frame.size.height-10);
    _bgView.frame = CGRectMake(0, 0, width, CGRectGetHeight(_shadowImgView.frame));
    _advertImg.frame = CGRectMake(0, 0, width/21*15, height);
    _redPacketImg.frame = CGRectMake(CGRectGetMaxX(_advertImg.frame), 0, width/21*6, height);
    CGFloat stateImgWidth = CGRectGetWidth(_redPacketImg.frame)-25;
    CGFloat stateImgHeight = stateImgWidth;
    _stateImg.frame = CGRectMake((CGRectGetWidth(_redPacketImg.frame)-stateImgWidth)/2+4, (CGRectGetHeight(_redPacketImg.frame)-stateImgHeight)/2,stateImgWidth , stateImgHeight);
    _titleLabel.frame = CGRectMake(10, CGRectGetMaxY(_advertImg.frame), width-20, 40);
    _lastTimeHintLabel.frame = CGRectMake(6, CGRectGetHeight(_redPacketImg.frame)/2-20, CGRectGetWidth(_redPacketImg.frame)-6, 20);
    _countDownLabel.frame = CGRectMake(6, CGRectGetHeight(_redPacketImg.frame)/2, CGRectGetWidth(_redPacketImg.frame)-6, 20);
    _circlePorgressView.frame = CGRectMake(CGRectGetMinX(_stateImg.frame), 10, stateImgWidth+5, stateImgWidth+5);
    _button.frame = CGRectMake(CGRectGetMinX(_stateImg.frame), CGRectGetMaxY(_circlePorgressView.frame), stateImgWidth, 15);
}
#pragma mark ------ 根据秒计算天时分秒
-(NSString*)timeformatFromSeconds:(NSInteger)seconds
{
    _hour = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%02ld",seconds/3600%24]];
    _minute = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%02ld",(seconds%3600)/60]];
    _second = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%02ld",seconds%60]];
    NSString *time = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@:%@:%@",_hour,_minute,_second]];
    return time;
}
- (NSMutableAttributedString *)changeCountDownLabelTextWithStr:(NSString *)str {
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange hourRange = NSMakeRange(0, 2);
    NSDictionary *dicHour = [NSDictionary dictionaryWithObjectsAndKeys:[HHSoftAppInfo defaultDeepSystemColor],NSForegroundColorAttributeName,[UIColor whiteColor],NSBackgroundColorAttributeName, nil];
    [attributed addAttributes:dicHour range:hourRange];
    
    NSRange minuteRange = NSMakeRange(3, 2);
    [attributed addAttributes:dicHour range:minuteRange];
    
    NSRange secondRange = NSMakeRange(6, 2);
    [attributed addAttributes:dicHour range:secondRange];
    
    _countDownLabel.attributedText = attributed;
    return  attributed;
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
