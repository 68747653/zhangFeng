//
//  AdvertBottomView.m
//  FullHelp
//
//  Created by hhsoft on 17/2/9.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AdvertBottomView.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftButton.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "AdvertInfo.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "MenuInfo.h"

@interface AdvertBottomView ()
@property (nonatomic,strong) HHSoftButton *collectButton,*praiseButton,*commentButton;
@property (nonatomic,strong) UIImageView *telImageView,*redImageView;
@property (nonatomic,strong) HHSoftLabel *telLabel,*redLabel;
@property (nonatomic,copy) BottomCollectAdvertBlock collectAdvertBlock;
@property (nonatomic,copy) BottomPraiseAdvertBlock praiseAdvertBlock;
@property (nonatomic,copy) BottomCommentAdvertBlock commentAdvertBlock;
@property (nonatomic,copy) BottomTelAdvertBlock telAdvertBlock;
@property (nonatomic,copy) BottomRedAdvertBlock redAdvertBlock;
@end

@implementation AdvertBottomView
-(instancetype)initWithFrame:(CGRect)frame BottomCollectAdvertBlock:(BottomCollectAdvertBlock)collectAdvertBlock BottomPraiseAdvertBlock:(BottomPraiseAdvertBlock)praiseAdvertBlock BottomCommentAdvertBlock:(BottomCommentAdvertBlock)commentAdvertBlock BottomTelAdvertBlock:(BottomTelAdvertBlock)telAdvertBlock BottomRedAdvertBlock:(BottomRedAdvertBlock)redAdvertBlock{
    if(self = [super initWithFrame:frame]){
        _collectAdvertBlock = collectAdvertBlock;
        _praiseAdvertBlock = praiseAdvertBlock;
        _commentAdvertBlock = commentAdvertBlock;
        _telAdvertBlock = telAdvertBlock;
        _redAdvertBlock = redAdvertBlock;
        [self initAdvertBottomView];
    }
    return self;
}
-(void)initAdvertBottomView{
    self.backgroundColor = [GlobalFile backgroundColor];
    //关注
    _collectButton = [[HHSoftButton alloc] initWithFrame:CGRectMake(0, 0, 49, 50) innerImage:[UIImage imageNamed:@"advert_collect_unselect.png"] innerImageRect:CGRectMake(14.5, 5, 20, 20) descTextRect:CGRectMake(0, 25, 49, 25) descText:@"关注" textColor:[HHSoftAppInfo defaultDeepSystemColor] textFont:[UIFont systemFontOfSize:12.0] textAligment:NSTextAlignmentCenter];
    _collectButton.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectButton];
    [_collectButton addTarget:self action:@selector(collectAdvertButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //点赞
    _praiseButton = [[HHSoftButton alloc] initWithFrame:CGRectMake(50, 0, 49, 50) innerImage:[UIImage imageNamed:@"advert_praise_unselect.png"] innerImageRect:CGRectMake(14.5, 5, 20, 20) descTextRect:CGRectMake(0, 25, 49, 25) descText:@"点赞" textColor:[HHSoftAppInfo defaultDeepSystemColor] textFont:[UIFont systemFontOfSize:12.0] textAligment:NSTextAlignmentCenter];
    _praiseButton.backgroundColor = [UIColor whiteColor];
    [self addSubview:_praiseButton];
    [_praiseButton addTarget:self action:@selector(praiseAdvertButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //评价
    _commentButton = [[HHSoftButton alloc] initWithFrame:CGRectMake(100, 0, 49, 50) innerImage:[UIImage imageNamed:@"advert_comment.png"] innerImageRect:CGRectMake(14.5, 5, 20, 20) descTextRect:CGRectMake(0, 25, 49, 25) descText:@"评价" textColor:[HHSoftAppInfo defaultDeepSystemColor] textFont:[UIFont systemFontOfSize:12.0] textAligment:NSTextAlignmentCenter];
    _commentButton.backgroundColor = [UIColor whiteColor];
    [self addSubview:_commentButton];
    [_commentButton addTarget:self action:@selector(commentAdvertButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //电话咨询
    _telImageView = [[UIImageView alloc] initWithFrame:CGRectMake(149, 0, ([HHSoftAppInfo AppScreen].width-149)*0.45, 50)];
    _telImageView.backgroundColor = [GlobalFile themeColor];
    _telImageView.userInteractionEnabled = YES;
    [self addSubview:_telImageView];
    //文字
    _telLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(0, 0, ([HHSoftAppInfo AppScreen].width-149)*0.45, 50) fontSize:13.0 text:@"电话咨询\n（有红包哦）" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter numberOfLines:2];
    _telLabel.userInteractionEnabled = YES;
    [_telImageView addSubview:_telLabel];
    NSRange telRangeText=[_telLabel.text rangeOfString:@"（有红包哦）"];
    NSMutableAttributedString *telTextStr=[[NSMutableAttributedString alloc] initWithString:_telLabel.text attributes:nil];
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=6.0) {
        NSDictionary *fontDic=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:10.0],NSFontAttributeName, nil];
        [telTextStr addAttributes:fontDic range:telRangeText];
        _telLabel.attributedText =telTextStr;
    }else{
        _telLabel.text=telTextStr.string;
    }
    UITapGestureRecognizer *telTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(telAdvertTapAction)];
    [_telLabel addGestureRecognizer:telTap];
    //领取红包
    _redImageView = [[UIImageView alloc] initWithFrame:CGRectMake(149+([HHSoftAppInfo AppScreen].width-149)*0.45, 0, ([HHSoftAppInfo AppScreen].width-149)*0.55, 50)];
    _redImageView.backgroundColor = [UIColor redColor];
    _redImageView.userInteractionEnabled = YES;
    [self addSubview:_redImageView];
    //文字
    _redLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(0, 0, ([HHSoftAppInfo AppScreen].width-149)*0.55, 50) fontSize:13.0 text:@"" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter numberOfLines:2];
    _redLabel.userInteractionEnabled = YES;
    [_redImageView addSubview:_redLabel];
    UITapGestureRecognizer *redTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(redAdvertTapAction)];
    [_redLabel addGestureRecognizer:redTap];
}
-(void)setAdvertInfo:(AdvertInfo *)advertInfo{
    _advertInfo = advertInfo;
    //关注
    if (_advertInfo.isCollect) {
        [_collectButton setSelectImage:[UIImage imageNamed:@"advert_collect_select.png"] descText:@"关注" textColor:[HHSoftAppInfo defaultDeepSystemColor] textFont:[UIFont systemFontOfSize:12.0]];
    }else{
        [_collectButton setSelectImage:[UIImage imageNamed:@"advert_collect_unselect.png"] descText:@"关注" textColor:[HHSoftAppInfo defaultDeepSystemColor] textFont:[UIFont systemFontOfSize:12.0]];
    }
    //点赞
    if (_advertInfo.isPraise) {
        [_praiseButton setSelectImage:[UIImage imageNamed:@"advert_praise_select.png"] descText:@"点赞" textColor:[HHSoftAppInfo defaultDeepSystemColor] textFont:[UIFont systemFontOfSize:12.0]];
    }else{
        [_praiseButton setSelectImage:[UIImage imageNamed:@"advert_praise_unselect.png"] descText:@"点赞" textColor:[HHSoftAppInfo defaultDeepSystemColor] textFont:[UIFont systemFontOfSize:12.0]];
    }
    if ([UserInfoEngine getUserInfo].userType == 1) {
        //商家
        //评价
        _commentButton.hidden = NO;
        //电话咨询
        _telImageView.frame = CGRectMake(149, 0, ([HHSoftAppInfo AppScreen].width-149)*0.45, 50);
        _telImageView.backgroundColor = [GlobalFile themeColor];
        _telLabel.frame = CGRectMake(0, 0, _telImageView.frame.size.width, 50);
        
        //广告类型【类型（1：现金红包 2：专场红包）】
        if (_advertInfo.redAdvertType == 1) {
            //领取红包
            _redImageView.frame = CGRectMake(149+([HHSoftAppInfo AppScreen].width-149)*0.45, 0, ([HHSoftAppInfo AppScreen].width-149)*0.55, 50);
            if (_advertInfo.isOpenApplyRed) {
                //已开通红包打赏功能
                _redImageView.backgroundColor = [UIColor redColor];
            }else{
                _redImageView.backgroundColor = [UIColor lightGrayColor];
            }
            //文字
            _redLabel.frame = CGRectMake(0, 0, _redImageView.frame.size.width, 50);
            _redLabel.text = @"申请红包打赏";
        }else{
            //领取红包
            _redImageView.frame = CGRectMake(149+([HHSoftAppInfo AppScreen].width-149)*0.45, 0, ([HHSoftAppInfo AppScreen].width-149)*0.55, 50);
            _redImageView.backgroundColor = [UIColor redColor];
            //文字
            _redLabel.frame = CGRectMake(0, 0, _redImageView.frame.size.width, 50);
            _redLabel.text = [NSString stringWithFormat:@"领取专场红包\n（%@人已领）",[NSString stringByReplaceNullString:_advertInfo.advertSpecialCount]];
            NSRange redRangeText=[_redLabel.text rangeOfString:[NSString stringWithFormat:@"（%@人已领）",[NSString stringByReplaceNullString:_advertInfo.advertSpecialCount]]];
            NSMutableAttributedString *redTextStr=[[NSMutableAttributedString alloc] initWithString:_redLabel.text attributes:nil];
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue]>=6.0) {
                NSDictionary *fontDic=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:10.0],NSFontAttributeName, nil];
                [redTextStr addAttributes:fontDic range:redRangeText];
                _redLabel.attributedText =redTextStr;
            }else{
                _redLabel.text=redTextStr.string;
            }
        }
    }else{
        //供货商
        //评价
        _commentButton.hidden = YES;
        //电话咨询
        _telImageView.frame = CGRectMake(99, 0, ([HHSoftAppInfo AppScreen].width-99)*0.45, 50);
        _telLabel.frame = CGRectMake(0, 0, _telImageView.frame.size.width, 50);
        //广告类型【类型（1：现金红包 2：专场红包）】
        if (_advertInfo.redAdvertType == 1) {
            //领取红包
            _redImageView.frame = CGRectMake(99+([HHSoftAppInfo AppScreen].width-99)*0.45, 0, ([HHSoftAppInfo AppScreen].width-99)*0.55, 50);
            _redImageView.backgroundColor = [UIColor lightGrayColor];
            //文字
            _redLabel.frame = CGRectMake(0, 0, _redImageView.frame.size.width, 50);
            _redLabel.text = @"申请红包打赏";
        }else{
            //领取红包
            _redImageView.frame = CGRectMake(99+([HHSoftAppInfo AppScreen].width-99)*0.45, 0, ([HHSoftAppInfo AppScreen].width-99)*0.55, 50);
            _redImageView.backgroundColor = [UIColor lightGrayColor];
            //文字
            _redLabel.frame = CGRectMake(0, 0, _redImageView.frame.size.width, 50);
            _redLabel.text = [NSString stringWithFormat:@"领取专场红包\n（%@人已领）",[NSString stringByReplaceNullString:_advertInfo.advertSpecialCount]];
            NSRange redRangeText=[_redLabel.text rangeOfString:[NSString stringWithFormat:@"（%@人已领）",[NSString stringByReplaceNullString:_advertInfo.advertSpecialCount]]];
            NSMutableAttributedString *redTextStr=[[NSMutableAttributedString alloc] initWithString:_redLabel.text attributes:nil];
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue]>=6.0) {
                NSDictionary *fontDic=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:10.0],NSFontAttributeName, nil];
                [redTextStr addAttributes:fontDic range:redRangeText];
                _redLabel.attributedText =redTextStr;
            }else{
                _redLabel.text=redTextStr.string;
            }
        }
    }
}
#pragma mark -- 收藏按钮点击事件
-(void)collectAdvertButtonClick{
    if (_advertInfo.isCollect) {
        if (_collectAdvertBlock) {
            _collectAdvertBlock(0);
        }
    }else{
        if (_collectAdvertBlock) {
            _collectAdvertBlock(1);
        }
    }
}
#pragma mark -- 点赞按钮点击事件
-(void)praiseAdvertButtonClick{
    if (_advertInfo.isPraise) {
        if (_praiseAdvertBlock) {
            _praiseAdvertBlock(0);
        }
    }else{
        if (_praiseAdvertBlock) {
            _praiseAdvertBlock(1);
        }
    }
}
#pragma mark -- 评价按钮点击事件
-(void)commentAdvertButtonClick{
    if (_commentAdvertBlock) {
        _commentAdvertBlock();
    }
}
#pragma mark -- 拨打电话按钮点击事件
-(void)telAdvertTapAction{
    if (_telAdvertBlock) {
        _telAdvertBlock();
    }
}
#pragma mark -- 申请红包按钮点击事件
-(void)redAdvertTapAction{
    if (_redAdvertBlock) {
        _redAdvertBlock();
    }
}
@end
