//
//  RedPacketView.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/7.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "RedPacketView.h"
#import "GlobalFile.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import "UserInfo.h"
#import "RedPacketInfo.h"
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import "RedPacketAdvertNetWorkEngine.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import <HHSoftFrameWorkKit/SVProgressHUD.h>
#import "RedPacketView.h"
#import "HHSoftHeader.h"
@interface RedPacketView ()
@property (nonatomic, copy)  OpenRedPacket openRedPacket;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIImageView *redPacketImgView;
@property (nonatomic, strong) UIImageView *avatarImgView,*coinImgView;
@property (nonatomic, strong) HHSoftLabel *nameLabel,*hintLabel,*amountLabel;
@end

@implementation RedPacketView

- (instancetype)initWithFrame:(CGRect)frame openRedPacket:(OpenRedPacket)openRedPacket {
    self = [super initWithFrame:frame];
    if (self) {
        self.openRedPacket = openRedPacket;
        [self setUpUI];
    }
    return self;
}
#pragma mark ------ 拆红包
- (void)openRedPacketNet {
    self.userInteractionEnabled = NO;
    [[[RedPacketAdvertNetWorkEngine alloc] init] openRedPacketWithUserID:[UserInfoEngine getUserInfo].userID successed:^(NSInteger code, NSString *amount) {
        self.userInteractionEnabled = YES;
        if (code==100) {
                if (_openRedPacket) {
                    _openRedPacket(amount);
            
                }
        }
        else if (code==103) {
            [SVProgressHUD showErrorWithStatus:@"不是第一次登录，不能领取"];
            [self stopAnimation];
        }
        else if (code==104) {
            [SVProgressHUD showErrorWithStatus:@"领取红包超出限额"];
            [self stopAnimation];
        }
        else {
            [SVProgressHUD showErrorWithStatus:@"网络异常"];
            [self stopAnimation];
        }
    } failed:^(NSError *error) {
        self.userInteractionEnabled = YES;
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
        [self stopAnimation];
    }];
}
#pragma mark ------ 拆红包
- (void)openNeedsRedPacketNet {
    self.userInteractionEnabled = NO;
    [[[RedPacketAdvertNetWorkEngine alloc] init] openNeedsRedPacketWithUserID:[UserInfoEngine getUserInfo].userID demandID:self.demandID successed:^(NSInteger code, NSString *amount) {
        self.userInteractionEnabled = YES;
        code = 100;
        if (code==100) {
            if (_openRedPacket) {
                _openRedPacket(amount);
            }
        }
        else if (code==103) {
            [SVProgressHUD showErrorWithStatus:@"每周需求超过三条不能领取红包"];
            [self stopAnimation];
        }
        else {
            [SVProgressHUD showErrorWithStatus:@"网络异常"];
            [self stopAnimation];
        }
    } failed:^(NSError *error) {
        self.userInteractionEnabled = YES;
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
        [self stopAnimation];
    }];

}
- (void)openGameRedAdvertInfoWithUserID:(NSInteger)userID
                        RedAdvertID:(NSInteger)redAdvertID{
                        self.userInteractionEnabled = NO;
    [[[RedPacketAdvertNetWorkEngine alloc] init] openGameRedAdvertInfoWithUserID:userID RedAdvertID:redAdvertID Succeed:^(NSInteger code, NSString *redAmount) {
    self.userInteractionEnabled = YES;
        switch (code) {
            case 100:{
                [[NSNotificationCenter defaultCenter] postNotificationName:GetGameRedpacketNotification object:[NSNumber numberWithInteger:redAdvertID]];
                if (_openRedPacket) {
                    _openRedPacket(redAmount);
                }
            }
            break;
            case 103:{
                [SVProgressHUD showErrorWithStatus:@"红包已领完"];
                [self stopAnimation];
            }
            break;
            case 104:{
                [SVProgressHUD showErrorWithStatus:@"不是本行业，不能领取"];
                [self stopAnimation];
            }
            break;
            case 105:{
                [SVProgressHUD showErrorWithStatus:@"红包已领完"];
                [self stopAnimation];
            }
            break;
            case 106:{
                [SVProgressHUD showErrorWithStatus:@"一个游戏一天最多领三个红包，超出三个不能领取"];
                [self stopAnimation];
            }
            break;
            case 107:{
                [SVProgressHUD showErrorWithStatus:@"已领取"];
                [self stopAnimation];
            }
                break;
            default:{
                [SVProgressHUD showErrorWithStatus:@"网络接连异常,请稍后重试"];
                [self stopAnimation];
            }
            break;
        }
    } Failed:^(NSError *error) {
        self.userInteractionEnabled = YES;
        [SVProgressHUD showErrorWithStatus:@"网络接连异常,请稍后重试"];
        [self stopAnimation];
    }];
}
#pragma mark -- 拆专场红包
-(void)openRedAdvertInfoWithUserID:(NSInteger)userID
                       RedAdvertID:(NSInteger)redAdvertID{
    self.userInteractionEnabled = NO;
    [[[RedPacketAdvertNetWorkEngine alloc] init] openRedAdvertInfoWithUserID:userID RedAdvertID:redAdvertID Succeed:^(NSInteger code, NSString *redAmount) {
        self.userInteractionEnabled = YES;
        switch (code) {
            case 100:{
                [[NSNotificationCenter defaultCenter] postNotificationName:GetSpecialRedpacketNotification object:[NSNumber numberWithInteger:redAdvertID]];
                if (_openRedPacket) {
                    _openRedPacket(redAmount);
                }
            }
                break;
            case 101:{
                [SVProgressHUD showErrorWithStatus:@"领取失败"];
                [self stopAnimation];
            }
                break;
            case 103:{
                [SVProgressHUD showErrorWithStatus:@"超出活动时间"];
                [self stopAnimation];
            }
                break;
            case 104:{
                [SVProgressHUD showErrorWithStatus:@"不是本行业，不能领取"];
                [self stopAnimation];
            }
                break;
            case 105:{
                [SVProgressHUD showErrorWithStatus:@"红包已领完"];
                [self stopAnimation];
            }
                break;
            case 106:{
                [SVProgressHUD showErrorWithStatus:@"该行业红包已领完"];
                [self stopAnimation];
            }
                break;
            case 107:{
                [SVProgressHUD showErrorWithStatus:@"已领取"];
                [self stopAnimation];
            }
                break;
            case 108:{
                [SVProgressHUD showErrorWithStatus:@"未点评供货商印象，不能领取"];
                [self stopAnimation];
            }
                break;
            case 109:{
                [SVProgressHUD showErrorWithStatus:@"供货商不能领取专场红包"];
                [self stopAnimation];
            }
                break;
            default:{
                [SVProgressHUD showErrorWithStatus:@"网络接连异常,请稍后重试"];
                [self stopAnimation];
            }
                break;
        }
    } Failed:^(NSError *error) {
        self.userInteractionEnabled = YES;
        [SVProgressHUD showErrorWithStatus:@"网络接连异常,请稍后重试"];
        [self stopAnimation];
    }];
}
#pragma mark -- 拆电话红包
-(void)openTelRedAdvertInfoWithUserID:(NSInteger)userID
                          RedAdvertID:(NSInteger)redAdvertID
                           BrowseTime:(NSInteger)browseTime{
    [[[RedPacketAdvertNetWorkEngine alloc] init] openTelRedAdvertInfoWithUserID:userID RedAdvertID:redAdvertID BrowseTime:browseTime Succeed:^(NSInteger code, NSString *redAmount) {
        self.userInteractionEnabled = YES;
        switch (code) {
            case 100:{
                if (_openRedPacket) {
                    _openRedPacket(redAmount);
                }
            }
                break;
            case 103:{
                [SVProgressHUD showErrorWithStatus:@"浏览时长不足"];
                [self stopAnimation];
            }
                break;
            case 104:{
                [SVProgressHUD showErrorWithStatus:@"不是本行业，不能领取"];
                [self stopAnimation];
            }
                break;
            case 105:{
                [SVProgressHUD showErrorWithStatus:@"红包已领完"];
                [self stopAnimation];
            }
                break;
            case 106:{
                [SVProgressHUD showErrorWithStatus:@"已领取"];
                [self stopAnimation];
            }
                break;
            case 107:{
                [SVProgressHUD showErrorWithStatus:@"供货商不能领取电话红包"];
                [self stopAnimation];
            }
                break;
            default:{
                [SVProgressHUD showErrorWithStatus:@"网络接连异常,请稍后重试"];
                [self stopAnimation];
            }
                break;
        }
    } Failed:^(NSError *error) {
        self.userInteractionEnabled = YES;
        [SVProgressHUD showErrorWithStatus:@"网络接连异常,请稍后重试"];
        [self stopAnimation];
    }];
}
#pragma mark -- 拆今日红包
-(void)openTodayRedpacketInfoWithUserID:(NSInteger)userID
                       RedAdvertID:(NSInteger)redAdvertID{
    self.userInteractionEnabled = NO;
    [[[RedPacketAdvertNetWorkEngine alloc] init] openTodayInfoWithUserID:userID RedAdvertID:redAdvertID Succeed:^(NSInteger code, NSString *redAmount) {
        switch (code) {
            case 100:{
                if (_openRedPacket) {
                    _openRedPacket(redAmount);
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:GetTodayRedpacketNotification object:_redPacketInfo];
            }
            break;
            case 103:{
                [SVProgressHUD showErrorWithStatus:@"超出活动时间"];
                [self stopAnimation];
            }
            break;
            case 104:{
                [SVProgressHUD showErrorWithStatus:@"不是本行业，不能领取"];
                [self stopAnimation];
            }
            break;
            case 105:{
                [SVProgressHUD showErrorWithStatus:@"红包已领完"];
                [self stopAnimation];
            }
            break;
            case 106:{
                [SVProgressHUD showErrorWithStatus:@"该行业红包已领完"];
                [self stopAnimation];
            }
            break;
            case 107:{
                [SVProgressHUD showErrorWithStatus:@"已领取"];
                [self stopAnimation];
            }
            break;
            default:{
                [SVProgressHUD showErrorWithStatus:@"网络接连异常,请稍后重试"];
                [self stopAnimation];
            }
            break;
        }
    } Failed:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络接连异常,请稍后重试"];
        [self stopAnimation];
    }];
}
#pragma mark ------ 拆场景红包
- (void)openSceneRedAdvertInfoWithUserID:(NSInteger)userID
                             RedAdvertID:(NSInteger)redAdvertID {
    [[[RedPacketAdvertNetWorkEngine alloc] init] openSceneRedAdvertInfoWithUserID:userID RedAdvertID:redAdvertID Succeed:^(NSInteger code, NSString *redAmount) {
        switch (code) {
            case 100:{
                if (_openRedPacket) {
                    _openRedPacket(redAmount);
                }
            }
            break;
            case 103:{
                [SVProgressHUD showErrorWithStatus:@"超出活动时间"];
                [self stopAnimation];
            }
            break;
            case 104:{
                [SVProgressHUD showErrorWithStatus:@"不是本行业，不能领取"];
                [self stopAnimation];
            }
            break;
            case 105:{
                [SVProgressHUD showErrorWithStatus:@"红包已领完"];
                [self stopAnimation];
            }
            break;
            case 106:{
                [SVProgressHUD showErrorWithStatus:@"该行业红包已领完"];
                [self stopAnimation];
            }
            break;
            
            default:{
                [SVProgressHUD showErrorWithStatus:@"网络接连异常,请稍后重试"];
                [self stopAnimation];
            }
            break;
        }
    } Failed:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络接连异常,请稍后重试"];
        [self stopAnimation];
    }];
}
- (void)setUpUI {
    
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    CGFloat width = 280;
    CGFloat height = 280*1.36;
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(([HHSoftAppInfo AppScreen].width-280)/2, ([HHSoftAppInfo AppScreen].height-height)/2, width, height)];
//    self.backgroundView.backgroundColor = [UIColor redColor];

    [self addSubview:self.backgroundView];
    
    self.redPacketImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.backgroundView.frame.size.width, self.backgroundView.frame.size.height)];
    self.redPacketImgView.image = [UIImage imageNamed:@"redPacket_background.png"];
    [self.backgroundView addSubview:_redPacketImgView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 20, 15, 15);
    [button setBackgroundImage:[UIImage imageNamed:@"redPacket_close.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(colseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundView addSubview:button];

    _avatarImgView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.backgroundView.frame)-45)/2, CGRectGetMaxY(button.frame)+10, 45, 45)];
    _avatarImgView.layer.cornerRadius = 5.0f;
    _avatarImgView.layer.masksToBounds = YES;
//    _avatarImgView.backgroundColor = [UIColor greenColor];
    [self.backgroundView addSubview:_avatarImgView];
    
    _nameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_avatarImgView.frame)+10, width-20, 20) fontSize:14 text:@"" textColor:[GlobalFile colorWithRed:255 green:226 blue:177 alpha:1] textAlignment:NSTextAlignmentCenter numberOfLines:1];
    [self.backgroundView addSubview:_nameLabel];
    
    _hintLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_nameLabel.frame)+5, width-20, 20) fontSize:14 text:@"给你发了一个红包" textColor:[GlobalFile colorWithRed:255 green:226 blue:177 alpha:1] textAlignment:NSTextAlignmentCenter numberOfLines:1];
    [self.backgroundView addSubview:_hintLabel];
    
    _amountLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_hintLabel.frame)+30, width-20, 35) fontSize:16 text:@"" textColor:[GlobalFile colorWithRed:247 green:236 blue:198 alpha:2] textAlignment:NSTextAlignmentCenter numberOfLines:2];
    
    [self.backgroundView addSubview:_amountLabel];
    
    _coinImgView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.backgroundView.frame)-85)/2, width*0.978-85/2, 85, 85)];
    _coinImgView.userInteractionEnabled = YES;
    _coinImgView.image = [UIImage imageNamed:@"coin_open.png"];
    [self.backgroundView addSubview:_coinImgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coinTap)];
    [_coinImgView addGestureRecognizer:tap];
    
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.backgroundView.layer addAnimation:animation forKey:nil];
}
- (void)setRedPacketInfo:(RedPacketInfo *)redPacketInfo {
    _redPacketInfo = redPacketInfo;
    if ([_redPacketInfo.sendUserInfo.userHeadImg containsString:@"http"]) {
        [_avatarImgView sd_setImageWithURL:[NSURL URLWithString:_redPacketInfo.sendUserInfo.userHeadImg] placeholderImage:[GlobalFile avatarImage]];
    }
    else {
        _avatarImgView.image = [UIImage imageNamed:_redPacketInfo.sendUserInfo.userHeadImg];
    }
    
    _nameLabel.text = _redPacketInfo.sendUserInfo.userNickName;
    _amountLabel.text = _redPacketInfo.redPacketMemo;

}
-(void)setAdvertID:(NSInteger)advertID{
    _advertID = advertID;
}
#pragma mark ------ 开红包事件
- (void) coinTap {
    NSMutableArray  *arrayM=[NSMutableArray array];
    for (NSInteger i=1; i<7; i++) {
        [arrayM addObject:[UIImage imageNamed:[NSString stringWithFormat:@"coin%@.png",[@(i) stringValue]]]];
    }
    
    [_coinImgView setAnimationImages:arrayM];
    [_coinImgView setAnimationRepeatCount:100];
    [_coinImgView setAnimationDuration:0.75];
    [_coinImgView startAnimating];
    [self openPacket];
}
- (void)openPacket {
    if (self.redPacketType == RedPacketTypeRegister) {
        [self openRedPacketNet];
    }
    else if (self.redPacketType == RedPacketTypePublishDemand) {
        [self openNeedsRedPacketNet];
    }else if (self.redPacketType == RedPacketTypeAdvertRed){
        //拆专场红包接口
        [self openRedAdvertInfoWithUserID:[UserInfoEngine getUserInfo].userID RedAdvertID:_advertID];
    }else if (self.redPacketType == RedPacketTypeAdvertTelRed){
        //电话红包
    }else if (self.redPacketType == RedPacketTypeToday) {
        //今日红包
        [self openTodayRedpacketInfoWithUserID:[UserInfoEngine getUserInfo].userID RedAdvertID:_redPacketInfo.redPacketID];
    }else if (self.redPacketType == RedPacketTypeGame) {
        [self openGameRedAdvertInfoWithUserID:[UserInfoEngine getUserInfo].userID RedAdvertID:_advertID];
    }
    else if (self.redPacketType == RedPacketTypeScene) {
        [self openSceneRedAdvertInfoWithUserID:[UserInfoEngine getUserInfo].userID RedAdvertID:_advertID];
    }
    

}
- (void)colseButtonClick {
    [self removeFromSuperview];
}
- (void)stopAnimation {
    [_coinImgView stopAnimating];
}
@end
