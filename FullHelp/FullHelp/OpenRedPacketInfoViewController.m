//
//  OpenRedPacketInfoViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/7.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "OpenRedPacketInfoViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import "UIViewController+NavigationBar.h"
#import "GlobalFile.h"
#import "HHSoftBarButtonItem.h"
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import "RedPacketInfo.h"
#import "UserInfo.h"
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import "NSMutableAttributedString+hhsoft.h"
#import <AudioToolbox/AudioToolbox.h>
@interface OpenRedPacketInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) RedPacketInfo *redPacketInfo;
@property (strong, nonatomic) CADisplayLink *displayLink;
@end
static CGFloat headerViewH = 1;
@implementation OpenRedPacketInfoViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [_displayLink invalidate];
    _displayLink =nil;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
-(instancetype)initWithRedPacketInfo:(RedPacketInfo *)redPacketInfo{
    if (self = [super init]) {
        self.redPacketInfo = redPacketInfo;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.dataTableView reloadData];
    [self.view addSubview:self.headerView];
    [self setNavigationItem];
    //播放金币掉落声音
    [self playCoinDropSound];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleAction:)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.displayLink.paused = NO;
    [self performSelector:@selector(stopDropCoinAnimation) withObject:nil afterDelay:2];
}
- (void)stopDropCoinAnimation {
    self.displayLink.paused = YES;
}
#pragma mark---根据帧率加载金币
- (void)handleAction:(CADisplayLink *)displayLink{
    
    UIImage *image = [UIImage imageNamed:@"drop_coin.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGFloat scale = arc4random_uniform(200) / 100;
    imageView.transform = CGAffineTransformMakeScale(scale, scale);
    CGSize winSize = self.view.bounds.size;
    CGFloat x = arc4random_uniform(winSize.width);
    CGFloat y = - imageView.frame.size.height;
    imageView.center = CGPointMake(x, y);
    
    [self.view addSubview:imageView];
    [UIView animateWithDuration:arc4random_uniform(3) animations:^{
        CGFloat toY = imageView.frame.size.height * 0.5 + winSize.height;
        imageView.center = CGPointMake(x, toY);
        imageView.transform = CGAffineTransformRotate(imageView.transform, arc4random_uniform(M_PI * 2));
        imageView.alpha = 0.5;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}
- (void)setNavigationItem {
    [self addLucencyNavigationBar];
    [self.hhsoftNavigationBar.subviews.firstObject setAlpha:1];
    [self.hhsoftNavigationBar setBackgroundImage:[GlobalFile imageWithColor:[GlobalFile colorWithRed:216 green:78 blue:66 alpha:1] size:CGSizeMake([HHSoftAppInfo AppScreen].width, 64)] forBarMetrics:UIBarMetricsDefault];
    NSMutableDictionary *textAttributesDict = [NSMutableDictionary dictionary];
    textAttributesDict[NSForegroundColorAttributeName] = [GlobalFile colorWithRed:255 green:226 blue:177 alpha:1];
    textAttributesDict[NSFontAttributeName] = [UIFont systemFontOfSize:18.f];
    [self.hhsoftNavigationBar setTitleTextAttributes:textAttributesDict];
    [self.hhsoftNavigationBar setTintColor:[HHSoftAppInfo defaultDeepSystemColor]];
    [self.hhsoftNavigationBar setShadowImage:[UIImage new]];
    self.hhsoftNaigationItem.title = @"红包";
    self.hhsoftNaigationItem.leftBarButtonItem = [[HHSoftBarButtonItem alloc] initBackButtonWithWhiteImgStr:@"back_gold.png" backBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
#pragma mark ------ headerView
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, headerViewH+64)];
        _headerView.backgroundColor = [GlobalFile colorWithRed:216 green:78 blue:66 alpha:1];
    }
    return _headerView;
}
#pragma mark ------ footerView
- (UIView *)footerView {
    if (!_footerView) {
        
        CGFloat width = [HHSoftAppInfo AppScreen].width-20;
        
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 70)];
        _footerView.backgroundColor = [UIColor whiteColor];
        UIImageView *redImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].width/3.58)];
        redImgView.image = [UIImage imageNamed:@"redPacket_bottom.png"];
        [_footerView addSubview:redImgView];
        
        UIImageView *avatarImgView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame)-45)/2, CGRectGetMaxY(redImgView.frame)-45/2, 45, 45)];
        avatarImgView.layer.cornerRadius = 5.0f;
        avatarImgView.layer.masksToBounds = YES;
        [_footerView addSubview:avatarImgView];
        if ([_redPacketInfo.sendUserInfo.userHeadImg containsString:@"http"]) {
            [avatarImgView sd_setImageWithURL:[NSURL URLWithString:_redPacketInfo.sendUserInfo.userHeadImg] placeholderImage:[GlobalFile avatarImage]];
        }
        else {
            avatarImgView.image = [UIImage imageNamed:_redPacketInfo.sendUserInfo.userHeadImg];
        }
        
        
        
        HHSoftLabel *nameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(avatarImgView.frame)+10, width, 20) fontSize:14 text:_redPacketInfo.sendUserInfo.userNickName textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
        [_footerView addSubview:nameLabel];
        
        HHSoftLabel *hintLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(nameLabel.frame)+5, width, 20) fontSize:14 text:_redPacketInfo.redPacketMemo textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
        [_footerView addSubview:hintLabel];
        
        
        NSString *amount = [NSString stringWithFormat:@"%@元",_redPacketInfo.redPacketAmount];
        
        HHSoftLabel *amountLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(hintLabel.frame)+20, width, 35) fontSize:16 text:nil textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentCenter numberOfLines:2];
        amountLabel.font = [UIFont boldSystemFontOfSize:24];
        [_footerView addSubview:amountLabel];
        
        NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:amount];
        [attributed changeStr:@"元" changeFont:[UIFont systemFontOfSize:16] changeColor:[HHSoftAppInfo defaultDeepSystemColor]];
        amountLabel.attributedText = attributed;
        
        
        HHSoftLabel *blueLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(amountLabel.frame)+10, width, 20) fontSize:14 text:@"已存入钱包,可直接提现" textColor:[GlobalFile colorWithRed:8 green:75 blue:137 alpha:1] textAlignment:NSTextAlignmentCenter numberOfLines:1];
        [_footerView addSubview:blueLabel];
        
        _footerView.frame = CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, CGRectGetMaxY(blueLabel.frame)+20);
    }
    return _footerView;
}
#pragma mark ----------------- dataTableView
-(HHSoftTableView *)dataTableView{
    if (_dataTableView==nil) {
        _dataTableView=[[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 64, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStylePlain];
        _dataTableView.contentInset = UIEdgeInsetsMake(headerViewH, 0, 0, 0);
        _dataTableView.tableFooterView = self.footerView;
        [self.view addSubview:_dataTableView];
    }
    return _dataTableView;
}
#pragma mark--UITableViewDelegate
#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *string=@"Identifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsety = scrollView.contentOffset.y+scrollView.contentInset.top;
    if (offsety <= 0) {
        //放大
        CGRect frame= _headerView.frame;
        frame.origin.y = 0;
        frame.size.height = headerViewH-offsety+64;
        _headerView.frame = frame;
    }
    else {
        CGRect frame= _headerView.frame;
        frame.origin.y = 0;
        frame.size.height = headerViewH-offsety+64;
        _headerView.frame = frame;
    }
    
}
#pragma mark ------ 播放金币掉落声音
- (void)playCoinDropSound {
    // 文件存储路径
    NSBundle *bundle = [NSBundle mainBundle];
    // 文件路径
    NSString *path = [bundle pathForResource:@"coin_play_sound" ofType:@"mp3"];
    NSURL *urlFile = [NSURL fileURLWithPath:path];
    // 声明需要播放的音频文件ID[unsigned long];
    SystemSoundID ID;
    // 创建系统声音，同时返回一个ID
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)urlFile, &ID);
    AudioServicesPlayAlertSound(ID);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
