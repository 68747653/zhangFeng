//
//  RedPacketAdvertDetailViewController.m
//  FullHelp
//
//  Created by hhsoft on 17/2/7.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "RedPacketAdvertDetailViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import <HHSoftFrameWorkKit/HHSoftPhotoBrowser.h>
#import <HHSoftFrameWorkKit/UIDevice+DeviceInfo.h>
#import "GlobalFile.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "AdvertInfo.h"
#import "ImageInfo.h"
#import "MenuInfo.h"
#import "RedPacketAdvertNetWorkEngine.h"
#import "AdvertDetailHeaderView.h"
#import "AddressInfo.h"
#import "NSMutableAttributedString+hhsoft.h"
#import "AdvertCommentViewCell.h"
#import "CommentInfo.h"
#import "ImpressInfo.h"
#import "RedPacketAdvertDetailWebViewController.h"
#import "WKWebViewController.h"
#import "ProductLabelViewCell.h"
#import "ProductLabelView.h"
#import "ImpressViewCell.h"
#import "ImpressLabelView.h"
#import "AdvertDetailLocationViewController.h"
#import "RedAdvertCommentListViewController.h"
#import "AdvertBottomView.h"
#import "AttentionNetWorkEngine.h"
#import "RedPacketView.h"
#import "OpenRedPacketInfoViewController.h"
#import "RedPacketInfo.h"
#import "MerchantInfo.h"
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>
#import <CallKit/CallKit.h>
#import <CallKit/CXCallObserver.h>
#import <CallKit/CXCall.h>
#import "AddAdvertCommentViewController.h"
#import "UserCenterNetWorkEngine.h"
//分享
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "HHSoftShareTool.h"

@interface RedPacketAdvertDetailViewController ()<UITableViewDelegate,UITableViewDataSource,CXCallObserverDelegate>
@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic,strong) AdvertInfo *advertInfo;
@property (nonatomic,assign) NSInteger redPacketAdvertID;
@property (nonatomic,strong) AdvertDetailHeaderView *headerView;
@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) UIView *tailBackgroundView;
@property (nonatomic,strong) UIScrollView *tailScrollView;
@property (nonatomic,assign) CGFloat labelRowHeight,impressRowHeight;
@property (nonatomic,strong) ProductLabelView *productLabelView;
@property (nonatomic,strong) ImpressLabelView *impressLabelView;
@property (nonatomic,strong) AdvertBottomView *advertBottomView;
@property (nonatomic,assign) NSInteger timeLength;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) RedPacketView *redPacketView;
@property (nonatomic,strong) CXCallObserver *callObserver;
@property (nonatomic,assign) NSInteger isRedRecord;//是否已领取电话红包【0：否 1：是】
@property (nonatomic,assign) NSInteger hasConnected;

@end

@implementation RedPacketAdvertDetailViewController
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(instancetype)initWithRedPacketAdvertID:(NSInteger)redPacketAdvertID{
    if(self = [super init]){
        _redPacketAdvertID = redPacketAdvertID;
    }
    return self;
}
//页面将要进入前台，开启定时器
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //开启定时器
    [_timer setFireDate:[NSDate distantPast]];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"广告详情";
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    _labelRowHeight = 44.0;
    _impressRowHeight = 44.0;
    _timeLength = 0;
    _isRedRecord = 0;
    //拨打电话监听代理
    [self addCallUp];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLabelHeightSucceed:) name:@"GetLabelHeight" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getImpressLabelHeightSucceed:) name:@"GetImpressLabelHeight" object:nil];
    //分享
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"advert_share.png"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAdvertBarButtonAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [GlobalFile themeColor];
    //动画
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    //获取红包广告详情
    [self getRedPacketAdvertInfoWithRedAdvertID:_redPacketAdvertID UserID:[UserInfoEngine getUserInfo].userID];
}
#pragma mark -- 注册拨打电话监听
-(void)addCallUp{
    self.callObserver = [[CXCallObserver alloc] init];
    [self.callObserver setDelegate:self queue:nil];
}
#pragma mark -- 拨打电话监听代理
-(void)callObserver:(CXCallObserver *)callObserver callChanged:(CXCall *)call{
    if (call.hasEnded){
        NSLog(@"-----------------------------挂断");   //挂断
        if (_hasConnected == 1) {
            RedPacketInfo *redPacketInfo = [[RedPacketInfo alloc] init];
            redPacketInfo.sendUserInfo.userHeadImg = _advertInfo.userInfo.userHeadImg;
            redPacketInfo.sendUserInfo.userNickName = _advertInfo.userInfo.userNickName;
            redPacketInfo.redPacketMemo = @"电话红包";
            _redPacketView = [[RedPacketView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height) openRedPacket:^(NSString *amount) {
                _redPacketView.redPacketInfo.redPacketAmount = amount;
                OpenRedPacketInfoViewController *openRedPacketInfoViewController = [[OpenRedPacketInfoViewController alloc] initWithRedPacketInfo:_redPacketView.redPacketInfo];
                openRedPacketInfoViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:openRedPacketInfoViewController animated:YES];
                [_redPacketView removeFromSuperview];
            }];
            _redPacketView.redPacketType = RedPacketTypeAdvertTelRed;
            _redPacketView.redPacketInfo = redPacketInfo;
            _redPacketView.advertID = _advertInfo.advertID;
            _redPacketView.browseTime = _timeLength;
            [[UIApplication sharedApplication].keyWindow addSubview:_redPacketView];
        }
    }else if (call.hasConnected){
        NSLog(@"-----------------------------连通了"); //联通了
        _hasConnected = 1;
    }else if (call.onHold){
        NSLog(@"-----------------------------拨号");  //拨号
    }else{
        NSLog(@"Nothing is done");
    }
}
- (void)getLabelHeightSucceed:(NSNotification *)noti{
    _labelRowHeight = [noti.userInfo[@"LabelHeight"] floatValue];
    [self.dataTableView reloadData];
    [_productLabelView removeFromSuperview];
    _productLabelView = nil;
}
- (void)getImpressLabelHeightSucceed:(NSNotification *)noti{
    _impressRowHeight = [noti.userInfo[@"ImpressLabelHeight"] floatValue];
    [self.dataTableView reloadData];
    [_impressLabelView removeFromSuperview];
    _impressLabelView = nil;
}
#pragma mark -- 计算浏览时长
-(void)timeFireMethod{
    _timeLength++;
}
#pragma mark -- 获取红包广告详情
-(void)getRedPacketAdvertInfoWithRedAdvertID:(NSInteger)redAdvertID
                                      UserID:(NSInteger)userID{
    self.op = [[[RedPacketAdvertNetWorkEngine alloc] init] getRedPacketAdvertInfoWithRedAdvertID:redAdvertID UserID:userID Succeed:^(NSInteger code, AdvertInfo *advertInfoModel) {
        [self hideLoadingView];
        switch (code) {
            case 100:{
                _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
                
                _advertInfo = advertInfoModel;
                
                _productLabelView = [[ProductLabelView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
                [self.view addSubview:_productLabelView];
                _productLabelView.arrProductLabel = _advertInfo.arrRedAdvertLabelList;
                
                _impressLabelView = [[ImpressLabelView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
                [self.view addSubview:_impressLabelView];
                _impressLabelView.arrImpressLabel = _advertInfo.arrImpressList;
                
                if (!_dataTableView) {
                    [self.view addSubview:self.dataTableView];
                }else {
                    [_dataTableView reloadData];
                }
                //加载底部背景
                [self.view addSubview:self.tailBackgroundView];
                //加载底部控件
                [self.view addSubview:self.advertBottomView];
            }
                break;
            case 101:{
                [self hideLoadingView];
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    //调接口
                    //获取红包广告详情
                    [self getRedPacketAdvertInfoWithRedAdvertID:_redPacketAdvertID UserID:[UserInfoEngine getUserInfo].userID];
                }];
            }
                break;
            default:{
                [self hideLoadingView];
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    //调接口
                    //获取红包广告详情
                    [self getRedPacketAdvertInfoWithRedAdvertID:_redPacketAdvertID UserID:[UserInfoEngine getUserInfo].userID];
                }];
            }
                break;
        }
    } Failed:^(NSError *error) {
        [self hideLoadingView];
        [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
            [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
            //调接口
            //获取红包广告详情
            [self getRedPacketAdvertInfoWithRedAdvertID:_redPacketAdvertID UserID:[UserInfoEngine getUserInfo].userID];
        }];
    }];
}
#pragma mark -- 初始化dataTableView
-(HHSoftTableView *)dataTableView{
    if (_dataTableView == nil) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64-50) dataSource:self delegate:self style:UITableViewStyleGrouped separatorColor:[GlobalFile backgroundColor]];
        _dataTableView.tableHeaderView = [self headerView];
        _dataTableView.tableFooterView = [self footerView];
    }
    return _dataTableView;
}
#pragma mark -- 初始化headerView
-(AdvertDetailHeaderView *)headerView{
    if (_headerView == nil) {
        if (_advertInfo.redAdvertType == 1) {
            //现金红包,不显示倒计时
            _headerView = [[AdvertDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].width) AdvertInfo:_advertInfo AdvertDetailHeaderViewImageBlock:^(NSMutableArray *arrImage, NSInteger index) {
                //查看大图
                [[HHSoftPhotoBrowser shared] showPhotos:arrImage currentPhotoIndex:index inTargetController:self];
            }];
        }else{
            if (_advertInfo.countDown <= 0) {
                _headerView = [[AdvertDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].width) AdvertInfo:_advertInfo AdvertDetailHeaderViewImageBlock:^(NSMutableArray *arrImage, NSInteger index) {
                    //查看大图
                    [[HHSoftPhotoBrowser shared] showPhotos:arrImage currentPhotoIndex:index inTargetController:self];
                }];
            }else{
                _headerView = [[AdvertDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].width+50) AdvertInfo:_advertInfo AdvertDetailHeaderViewImageBlock:^(NSMutableArray *arrImage, NSInteger index) {
                    //查看大图
                    [[HHSoftPhotoBrowser shared] showPhotos:arrImage currentPhotoIndex:index inTargetController:self];
                }];
            }
        }
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}
#pragma mark -- 加载footerView
-(UIView *)footerView{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 60)];
        _footerView.backgroundColor = [GlobalFile backgroundColor];
        CGSize size = [@"继续滑动查看图文详情" boundingRectWithfont:[UIFont systemFontOfSize:14.0] maxTextSize:CGSizeMake(CGFLOAT_MAX, 30)];
        //左侧横线
        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (60-([HHSoftAppInfo AppScreen].width-30-size.width-10)/2.0/26)/2.0, ([HHSoftAppInfo AppScreen].width-30-size.width-10)/2.0, ([HHSoftAppInfo AppScreen].width-30-size.width-10)/2.0/26)];
        leftImageView.image = [UIImage imageNamed:@"advert_leftline.png"];
        [_footerView addSubview:leftImageView];
        //文字
        HHSoftLabel *textLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15+([HHSoftAppInfo AppScreen].width-30-size.width-10)/2.0+5, 15, size.width, 30) fontSize:14.0 text:@"继续滑动查看图文详情" textColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0] textAlignment:NSTextAlignmentCenter numberOfLines:1];
        textLabel.tag = 741;
        [_footerView addSubview:textLabel];
        //右侧横线
        UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15+([HHSoftAppInfo AppScreen].width-30-size.width-10)/2.0+5+size.width+5, (60-([HHSoftAppInfo AppScreen].width-30-size.width-10)/2.0/26)/2.0, ([HHSoftAppInfo AppScreen].width-30-size.width-10)/2.0, ([HHSoftAppInfo AppScreen].width-30-size.width-10)/2.0/26)];
        rightImageView.image = [UIImage imageNamed:@"advert_rightline.png"];
        [_footerView addSubview:rightImageView];
        
    }
    return _footerView;
}
#pragma mark -- 底部的背景view 用于存放scrollView 和 标题按钮
- (UIView *)tailBackgroundView {
    if (!_tailBackgroundView) {
        _tailBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, [HHSoftAppInfo AppScreen].height, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64-50)];
        _tailBackgroundView.backgroundColor = [GlobalFile themeColor];
        [_tailBackgroundView addSubview:self.tailScrollView];
    }
    return _tailBackgroundView;
}
#pragma mark -- 底部的scrollView
-(UIScrollView*)tailScrollView{
    if (_tailScrollView==nil) {
        [self setupChildsViewControllers];
        _tailScrollView=[[UIScrollView alloc]init];
        _tailScrollView.frame=CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, CGRectGetHeight(self.tailBackgroundView.frame));
        _tailScrollView.delegate=self;
        _tailScrollView.tag=200;
        _tailScrollView.pagingEnabled = YES;
        _tailScrollView.backgroundColor = [GlobalFile backgroundColor];
        _tailScrollView.contentSize = CGSizeMake([HHSoftAppInfo AppScreen].width*self.childViewControllers.count, 0);
        [self scrollViewDidEndScrollingAnimation:_tailScrollView];
    }
    return _tailScrollView;
}
#pragma mark -- 加载子控制器
- (void)setupChildsViewControllers {
    RedPacketAdvertDetailWebViewController *redPacketAdvertDetailWebViewController = [[RedPacketAdvertDetailWebViewController alloc] initWithWebURL:_advertInfo.linkUrl DropDownBlock:^{
        [self dropDownbackMainView];
    }];
    [self addChildViewController:redPacketAdvertDetailWebViewController];
}
#pragma mark -- TableView的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:{
            if (_advertInfo.redAdvertType == 1) {
                return 4;
            }else{
                return 3;
            }
        }
            break;
        case 1:{
            if (_advertInfo.arrRedAdvertLabelList.count) {
                return 2;
            }else{
                return 1;
            }
        }
            break;
        case 2:{
            if (_advertInfo.arrImpressList.count) {
                return 2;
            }else{
                return 1;
            }
        }
            break;
        case 3:{
            return _advertInfo.arrCommentList.count+1;
        }
            break;
        default:
            return 0;
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            if (indexPath.row == 0) {
                CGSize size;
                if (_advertInfo.isCert) {
                    //已认证
                    size = [[NSString stringByReplaceNullString:_advertInfo.merchantName] boundingRectWithfont:[UIFont systemFontOfSize:14.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-45-40, CGFLOAT_MAX)];
                }else{
                    size = [_advertInfo.merchantName boundingRectWithfont:[UIFont systemFontOfSize:14.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-15-40, CGFLOAT_MAX)];
                }
                if (size.height<30) {
                    return 30+14;
                }else{
                    return size.height+14;
                }
            }else if (indexPath.row == 1){
                CGSize size = [[NSString stringByReplaceNullString:_advertInfo.addressInfo.addressDetail] boundingRectWithfont:[UIFont systemFontOfSize:14.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-45-40, CGFLOAT_MAX)];
                if (size.height<30) {
                    return 30+14;
                }else{
                    return size.height+14;
                }
            }else{
                return 44.0;
            }
        }
            break;
        case 1:{
            if (indexPath.row == 0) {
                return 44.0;
            }else{
                return _labelRowHeight;
            }
        }
            break;
        case 2:{
            if (indexPath.row == 0) {
                return 44.0;
            }else{
                return _impressRowHeight;
            }
        }
            break;
        case 3:{
            if (indexPath.row == 0) {
                return 44.0;
            }else{
                CommentInfo *commentInfo = _advertInfo.arrCommentList[indexPath.row-1];
                return [AdvertCommentViewCell cellHeightWithCommentInfo:commentInfo];
            }
        }
            break;
        default:
            return CGFLOAT_MIN;
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(void)viewDidLayoutSubviews{
    if ([_dataTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_dataTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([_dataTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_dataTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            if (indexPath.row == 0) {
                //名称
                static NSString *nameCell = @"nameCell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nameCell];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nameCell];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    //名称
                    HHSoftLabel *nameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(45, 7, [HHSoftAppInfo AppScreen].width-45-40, 30) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
                    nameLabel.tag = 961;
                    [cell.contentView addSubview:nameLabel];
                }
                //名称
                HHSoftLabel *nameLabel = (HHSoftLabel *)[cell.contentView viewWithTag:961];
                nameLabel.text = [NSString stringByReplaceNullString:_advertInfo.merchantName];
                
                //等级
                cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"level%@.png",[@(_advertInfo.levelValue) stringValue]]]];
                CGSize size;
                if (_advertInfo.isCert) {
                    //已认证
                    cell.imageView.image = [UIImage imageNamed:@"advert_cert.png"];
                    size = [nameLabel.text boundingRectWithfont:[UIFont systemFontOfSize:14.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-45-40, CGFLOAT_MAX)];
                    if (size.height<30) {
                        nameLabel.frame = CGRectMake(45, 7, [HHSoftAppInfo AppScreen].width-45-40, 30);
                    }else{
                        nameLabel.frame = CGRectMake(45, 7, [HHSoftAppInfo AppScreen].width-45-40, size.height);
                    }
                }else{
                    size = [nameLabel.text boundingRectWithfont:[UIFont systemFontOfSize:14.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-15-40, CGFLOAT_MAX)];
                    if (size.height<30) {
                        nameLabel.frame = CGRectMake(15, 7, [HHSoftAppInfo AppScreen].width-15-40, 30);
                    }else{
                        nameLabel.frame = CGRectMake(15, 7, [HHSoftAppInfo AppScreen].width-15-40, size.height);
                    }
                }
                
                return cell;
            }else if (indexPath.row == 1){
                //地址
                static NSString *addressCell = @"addressCell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCell];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addressCell];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    //地址
                    HHSoftLabel *addressLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(45, 7, [HHSoftAppInfo AppScreen].width-45-40, 30) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
                    addressLabel.tag = 962;
                    [cell.contentView addSubview:addressLabel];
                }
                //地址
                HHSoftLabel *addressLabel = (HHSoftLabel *)[cell.contentView viewWithTag:962];
                addressLabel.text = [NSString stringByReplaceNullString:_advertInfo.addressInfo.addressDetail];
                CGSize size = [addressLabel.text boundingRectWithfont:[UIFont systemFontOfSize:14.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-45-40, CGFLOAT_MAX)];
                if (size.height<30) {
                    addressLabel.frame = CGRectMake(45, 7, [HHSoftAppInfo AppScreen].width-45-40, 30);
                }else{
                    addressLabel.frame = CGRectMake(45, 7, [HHSoftAppInfo AppScreen].width-45-40, size.height);
                }
                
                cell.imageView.image = [UIImage imageNamed:@"advert_address.png"];
                
                return cell;
            }else if (indexPath.row == 2){
                //供货商简介
                static NSString *descCell = @"descCell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:descCell];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:descCell];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                cell.textLabel.text = @"供货商简介";
                cell.textLabel.textColor = [HHSoftAppInfo defaultDeepSystemColor];
                cell.textLabel.font = [UIFont systemFontOfSize:14.0];
                
                return cell;
            }else{
                //已打赏数量
                static NSString *applayCell = @"applayCell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:applayCell];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:applayCell];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    //打赏数量
                    HHSoftLabel *applyLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(45, 7, [HHSoftAppInfo AppScreen].width-45-15, 30) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
                    applyLabel.tag = 963;
                    [cell.contentView addSubview:applyLabel];
                }
                cell.imageView.image = [UIImage imageNamed:@"advert_applyamount.png"];
                //打赏数量
                HHSoftLabel *applyLabel = (HHSoftLabel *)[cell.contentView viewWithTag:963];
                applyLabel.text = [NSString stringWithFormat:@"已打赏%@人,赏金%@元",_advertInfo.advertApplyCount,_advertInfo.advertAmount];
                
                return cell;
            }
        }
            break;
        case 1:{
            if (indexPath.row == 0){
                //产品标签
                static NSString *labelCell = @"labelCell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:labelCell];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:labelCell];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    //产品标签
                    HHSoftLabel *labelStrLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(10, 12, [HHSoftAppInfo AppScreen].width-20, 20) fontSize:14 text:@"•  产品标签  •" textColor:[GlobalFile themeColor] textAlignment:1 numberOfLines:1];
                    [cell.contentView addSubview:labelStrLabel];
                    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:@"•  产品标签  •"];
                    [attributed changeStr:@"产品标签" changeFont:labelStrLabel.font changeColor:[HHSoftAppInfo defaultDeepSystemColor]];
                    labelStrLabel.attributedText = attributed;
                }
                
                return cell;
            }else{
                //标签
                static NSString *labelContentCell = @"labelContentCell";
                ProductLabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:labelContentCell];
                if (cell == nil) {
                    cell = [[ProductLabelViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:labelContentCell ArrProductLabel:_advertInfo.arrRedAdvertLabelList CellHeight:_labelRowHeight];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                cell.arrProductLabel = _advertInfo.arrRedAdvertLabelList;
                
                return cell;
            }
        }
            break;
        case 2:{
            if (indexPath.row == 0){
                //供货商印象
                static NSString *impressStrCell = @"impressStrCell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:impressStrCell];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:impressStrCell];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    //供货商印象
                    HHSoftLabel *impressStrLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(10, 12, [HHSoftAppInfo AppScreen].width-20, 20) fontSize:14 text:@"•  供应商印象  •" textColor:[GlobalFile themeColor] textAlignment:1 numberOfLines:1];
                    [cell.contentView addSubview:impressStrLabel];
                    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:@"•  供应商印象  •"];
                    [attributed changeStr:@"供应商印象" changeFont:impressStrLabel.font changeColor:[HHSoftAppInfo defaultDeepSystemColor]];
                    impressStrLabel.attributedText = attributed;
                }
                
                
                return cell;
            }else{
                //印象
                static NSString *impressCell = @"impressCell";
                ImpressViewCell *cell = [tableView dequeueReusableCellWithIdentifier:impressCell];
                if (cell == nil) {
                    cell = [[ImpressViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:impressCell AdvertInfo:_advertInfo CellHeight:_impressRowHeight];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                //印象点评
                cell.impressSelectBlock = ^(NSInteger index){
                    ImpressInfo *impressInfo = _advertInfo.arrImpressList[index];
                    [self showWaitView:@"请稍等..."];
                    self.view.userInteractionEnabled = NO;
                    [self addImpressCommentInfoWithUserID:[UserInfoEngine getUserInfo].userID ImpressID:impressInfo.impressID IndexPath:indexPath];
                };
                
                
                return cell;
            }
        }
            break;
        case 3:{
            if (indexPath.row == 0){
                //查看更多评论
                static NSString *commentStrCell = @"commentStrCell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commentStrCell];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:commentStrCell];
                }
                
                cell.textLabel.text = [NSString stringWithFormat:@"评价(%@)",[@(_advertInfo.advertCommentCount) stringValue]];
                cell.textLabel.textColor = [HHSoftAppInfo defaultDeepSystemColor];
                cell.textLabel.font = [UIFont systemFontOfSize:14.0];
                cell.detailTextLabel.text = @"查看更多>>";
                cell.detailTextLabel.textColor = [GlobalFile themeColor];
                cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
                
                return cell;
            }else{
                //评论
                static NSString *listImageCell = @"listImageCell";
                static NSString *listNoImageCell = @"listNoImageCell";
                
                CommentInfo *commentInfo = _advertInfo.arrCommentList[indexPath.row-1];
                AdvertCommentViewCell *cell;
                if (commentInfo.arrCommentGallery.count) {
                    cell = [AdvertCommentViewCell AdvertCommentViewCellWithTableView:tableView identifier:listImageCell];
                }else{
                    cell = [AdvertCommentViewCell AdvertCommentViewCellWithTableView:tableView identifier:listNoImageCell];
                }
                cell.commentInfo = commentInfo;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.seeImgViewBlock = ^(NSMutableArray *arrImage,NSInteger indexPath){
                    //查看大图
                    [[HHSoftPhotoBrowser shared] showPhotos:arrImage currentPhotoIndex:indexPath inTargetController:self];
                };
                return cell;
            }
        }
            break;
        default:{
            static NSString *strCell = @"strCell";
            
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:strCell];
            if(cell==nil){
                cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            return cell;
        }
            break;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            AdvertDetailLocationViewController *advertDetailLocationViewController = [[AdvertDetailLocationViewController alloc] initWithLatitude:_advertInfo.addressInfo.addressLatitude Longitude:_advertInfo.addressInfo.addressLongitude];
            [self.navigationController pushViewController:advertDetailLocationViewController animated:YES];
        }else if (indexPath.row == 2){
            WKWebViewController *wkWebViewController = [[WKWebViewController alloc] initWithUrl:_advertInfo.merchantURL WkWebType:WKWebTypeWithAdvertType MessageTitle:@"供货商简介"];
            [self.navigationController pushViewController:wkWebViewController animated:YES];
        }
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            //评价列表
            RedAdvertCommentListViewController *redAdvertCommentListViewController = [[RedAdvertCommentListViewController alloc] initWithMerchantUserID:_advertInfo.userInfo.userID];
            [self.navigationController pushViewController:redAdvertCommentListViewController animated:YES];
        }
    }
}
#pragma mark -- UIScrollViewDelegate
/**
 * 当滚动动画完毕的时候调用（通过代码setContentOffset:animated:让scrollView滚动完毕后，就会调用这个方法）
 * 如果执行完setContentOffset:animated:后，scrollView的偏移量并没有发生改变的话，就不会调用scrollViewDidEndScrollingAnimation:方法
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView.tag == 200) {
        // 取出对应的子控制器
        int index = scrollView.contentOffset.x / scrollView.frame.size.width;
        UIViewController *willShowChildVc = self.childViewControllers[index];
        
        // 如果控制器的view已经被创建过，就直接返回
        if (willShowChildVc.isViewLoaded)
            return;
        // 添加子控制器的view到scrollView身上
        willShowChildVc.view.frame = scrollView.bounds;
        [scrollView addSubview:willShowChildVc.view];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _dataTableView) {
        CGFloat offsetY = scrollView.contentOffset.y;
        // 能触发翻页的理想值:tableView整体的高度减去屏幕本身的高度
        CGFloat valueNum = _dataTableView.contentSize.height-[HHSoftAppInfo AppScreen].height;
        
        HHSoftLabel *label = (HHSoftLabel *)[_footerView viewWithTag:741];
        if ((offsetY - valueNum) < 200) {
            label.text = @"继续滑动查看图文详情";
        }else if ((offsetY - valueNum) > 200){
            label.text = @"停止滑动查看图文详情";
        }
    }
}
#pragma mark -- 设置上提多少进入详情
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView == _dataTableView) {
        CGFloat offsetY = scrollView.contentOffset.y;
        // 能触发翻页的理想值:tableView整体的高度减去屏幕本身的高度
        CGFloat valueNum = _dataTableView.contentSize.height-[HHSoftAppInfo AppScreen].height;
        
        if ((offsetY - valueNum) > 200){
            [UIView animateWithDuration:0.35 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                self.dataTableView.frame = CGRectMake(0, -[HHSoftAppInfo AppScreen].height, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64-50);
                self.tailBackgroundView.frame = CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64-50);
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}
#pragma mark -- 下拉返回服务详情
- (void)dropDownbackMainView {
    [UIView animateWithDuration:0.35 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.dataTableView.frame = CGRectMake(0, 0,[HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64-50) ;
        self.tailBackgroundView.frame = CGRectMake(0, [HHSoftAppInfo AppScreen].height, [HHSoftAppInfo AppScreen].width,[HHSoftAppInfo AppScreen].height-64-50);
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark -- 印象点评接口
-(void)addImpressCommentInfoWithUserID:(NSInteger)userID
                             ImpressID:(NSInteger)impressID
                             IndexPath:(NSIndexPath *)indexPath{
    self.op = [[[RedPacketAdvertNetWorkEngine alloc] init] addImpressCommentInfoWithUserID:userID ImpressID:impressID Succeed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100:{
                [self showSuccessView:@"评价成功"];
                for (ImpressInfo *impressInfo in _advertInfo.arrImpressList) {
                    if (impressInfo.impressID == impressID) {
                        impressInfo.impressIsComment = 1;
                        impressInfo.impressCommentCount += 1;
                    }
                }
                [_dataTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
                break;
            case 101:{
                [self showErrorView:@"评价失败"];
            }
                break;
            case 103:{
                [self showErrorView:@"已评价"];
                /*for (ImpressInfo *impressInfo in _advertInfo.arrImpressList) {
                    if (impressInfo.impressID == impressID) {
                        impressInfo.impressIsComment = 1;
                        break;
                    }
                }
                [_dataTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];*/
            }
                break;
            default:
                [self showErrorView:@"网络接连异常,请稍后重试"];
                break;
        }
    } Failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络接连异常,请稍后重试"];
    }];
}
#pragma mark --------------------------------------- 广告详情、红包详情，底部View和相应的操作
#pragma mark -- 初始化广告详情底部的View
-(UIView *)advertBottomView{
    if (_advertBottomView == nil) {
        _advertBottomView = [[AdvertBottomView alloc] initWithFrame:CGRectMake(0, [HHSoftAppInfo AppScreen].height-64-50, [HHSoftAppInfo AppScreen].width, 50) BottomCollectAdvertBlock:^(NSInteger isCollect) {
            //关注
            [self showWaitView:@"请稍等..."];
            self.view.userInteractionEnabled = NO;
            //关注接口
            [self addCollectOrCancelCollectWithUserID:[UserInfoEngine getUserInfo].userID collectType:3 keyID:_advertInfo.advertID];
        } BottomPraiseAdvertBlock:^(NSInteger isPraise) {
            //点赞
            [self showWaitView:@"请稍等..."];
            self.view.userInteractionEnabled = NO;
            //点赞接口
            [self addPraiseAndCancelPraiseInfoWithUserID:[UserInfoEngine getUserInfo].userID redAdvertID:_advertInfo.advertID];
        } BottomCommentAdvertBlock:^{
            //评价
            if (_advertInfo.userInfo.userLevel < 3) {
                [self showErrorView:@"LV3级别以上的用户可以评论"];
                return;
            }
            //添加评论
            AddAdvertCommentViewController *addAdvertCommentViewController = [[AddAdvertCommentViewController alloc] initWithMerchantUserID:_advertInfo.userInfo.userID AddCommentSucceedBlock:^{
                _advertInfo.advertCommentCount = _advertInfo.advertCommentCount+1;
                [_dataTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:3]] withRowAnimation:UITableViewRowAnimationNone];
            }];
            [self.navigationController pushViewController:addAdvertCommentViewController animated:YES];
        } BottomTelAdvertBlock:^{
            //咨询电话
            [self showSuccessView:[NSString stringWithFormat:@"满足浏览时长%@秒，且第一次拨打电话会有红包哦！",[@(_advertInfo.advertBrowseTime) stringValue]]];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            for (MerchantInfo *merchantInfo in _advertInfo.arrMerchantTelList) {
                [alertController addAction:[UIAlertAction actionWithTitle:[NSString stringByReplaceNullString:merchantInfo.merchantTel] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //电话咨询接口
                    [self addConsultRecordInfoWithUserID:[UserInfoEngine getUserInfo].userID RedAdvertID:_advertInfo.advertID BrowseTime:_timeLength TelPhone:merchantInfo.merchantTel];
                }]];
            }
            //给字体设置为黑色
            alertController.view.tintColor = [HHSoftAppInfo defaultDeepSystemColor];
            [self presentViewController:alertController animated:YES completion:nil];
            
        } BottomRedAdvertBlock:^{
            //申请红包
            if ([UserInfoEngine getUserInfo].userType == 1) {
                //商家
                if (_advertInfo.redAdvertType == 1) {
                    //现金红包
                    if (_advertInfo.isOpenApplyRed) {
                        //已开通红包打赏功能
                        if (_timeLength<_advertInfo.advertBrowseTime) {
                            [self showErrorView:@"浏览时长不足，不能申请打赏"];
                            return;
                        }
                        [self showWaitView:@"请稍等..."];
                        self.view.userInteractionEnabled = NO;
                        //申请打赏接口
                        [self addApplyRedInfoWithUserID:[UserInfoEngine getUserInfo].userID RedAdvertID:_advertInfo.advertID];
                    }
                }else{
                    //专场红包
                    if (_advertInfo.isReceive) {
                        //已领取
                        [self showErrorView:@"您已领取过该红包"];
                        return;
                    }else{
                        RedPacketInfo *redPacketInfo = [[RedPacketInfo alloc] init];
                        redPacketInfo.sendUserInfo.userHeadImg = _advertInfo.userInfo.userHeadImg;
                        redPacketInfo.sendUserInfo.userNickName = _advertInfo.userInfo.userNickName;
                        redPacketInfo.redPacketMemo = @"专场红包";
                        _redPacketView = [[RedPacketView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height) openRedPacket:^(NSString *amount) {
                            _advertInfo.isReceive = 1;
                            _advertInfo.advertSpecialCount = [@([_advertInfo.advertSpecialCount integerValue]+1) stringValue];
                            [self.advertBottomView reloadInputViews];
                            
                            _redPacketView.redPacketInfo.redPacketAmount = amount;
                            OpenRedPacketInfoViewController *openRedPacketInfoViewController = [[OpenRedPacketInfoViewController alloc] initWithRedPacketInfo:_redPacketView.redPacketInfo];
                            openRedPacketInfoViewController.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:openRedPacketInfoViewController animated:YES];
                            [_redPacketView removeFromSuperview];
                        }];
                        _redPacketView.redPacketType = RedPacketTypeAdvertRed;
                        _redPacketView.redPacketInfo = redPacketInfo;
                        _redPacketView.advertID = _advertInfo.advertID;
                        [[UIApplication sharedApplication].keyWindow addSubview:_redPacketView];
                    }
                }
            }else{
                [self showErrorView:@"供应商不能领取该红包"];
            }
        }];
    }
    _advertBottomView.advertInfo = _advertInfo;
    
    return _advertBottomView;
}
#pragma mark -- 收藏接口
-(void)addCollectOrCancelCollectWithUserID:(NSInteger)userID
                               collectType:(NSInteger)collectType
                                     keyID:(NSInteger)keyID{
    self.op = [[[AttentionNetWorkEngine alloc] init] addCollectOrCancelCollectWithUserID:userID collectType:collectType keyID:keyID successed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100:{
                [self showSuccessView:@"关注成功"];
                _advertInfo.isCollect = 1;
                [self.advertBottomView reloadInputViews];
            }
                break;
            case 101:{
                [self showErrorView:@"关注失败"];
                _advertInfo.isCollect = 0;
                [self.advertBottomView reloadInputViews];
            }
                break;
            case 103:{
                [self showSuccessView:@"取消关注成功"];
                _advertInfo.isCollect = 0;
                [self.advertBottomView reloadInputViews];
            }
                break;
            case 104:{
                [self showErrorView:@"取消关注失败"];
                _advertInfo.isCollect = 1;
                [self.advertBottomView reloadInputViews];
            }
                break;
            default:
                [self showErrorView:@"网络接连异常,请稍后重试"];
                break;
        }
    } failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络接连异常,请稍后重试"];
    }];
}
#pragma mark -- 点赞接口
-(void)addPraiseAndCancelPraiseInfoWithUserID:(NSInteger )userID
                                  redAdvertID:(NSInteger)redAdvertID{
    self.op = [[[RedPacketAdvertNetWorkEngine alloc] init] addPraiseAndCancelPraiseInfoWithUserID:userID redAdvertID:redAdvertID Succeed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100:{
                [self showSuccessView:@"点赞成功"];
                _advertInfo.isPraise = 1;
                [self.advertBottomView reloadInputViews];
            }
                break;
            case 101:{
                [self showErrorView:@"点赞失败"];
                _advertInfo.isPraise = 0;
                [self.advertBottomView reloadInputViews];
            }
                break;
            case 103:{
                [self showSuccessView:@"取消点赞成功"];
                _advertInfo.isPraise = 0;
                [self.advertBottomView reloadInputViews];
            }
                break;
            case 104:{
                [self showErrorView:@"取消点赞失败"];
                _advertInfo.isPraise = 1;
                [self.advertBottomView reloadInputViews];
            }
                break;
            default:
                [self showErrorView:@"网络接连异常,请稍后重试"];
                break;
        }
    } Failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络接连异常,请稍后重试"];
    }];
}
#pragma mark -- 申请红包打赏
-(void)addApplyRedInfoWithUserID:(NSInteger)userID
                     RedAdvertID:(NSInteger)redAdvertID{
    self.op = [[[RedPacketAdvertNetWorkEngine alloc] init] addApplyRedInfoWithUserID:userID RedAdvertID:redAdvertID Succeed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100:{
                [self showSuccessView:@"申请成功,等待供应商同意"];
            }
                break;
            case 101:{
                [self showErrorView:@"申请打赏失败"];
            }
                break;
            case 103:{
                [self showErrorView:@"红包已抢完"];
            }
                break;
            case 104:{
                [self showErrorView:@"商家未咨询供货商"];
            }
                break;
            case 105:{
                [self showErrorView:@"商家信息未完善"];
            }
                break;
            case 106:{
                [self showErrorView:@"供货商未开通红包打赏"];
            }
                break;
            case 107:{
                [self showErrorView:@"供货商不能申请红包打赏"];
            }
                break;
            case 108:{
                [self showErrorView:@"不是本行业不能申请红包打赏"];
            }
                break;
            case 109:{
                [self showErrorView:@"数量限制，不能申请红包打赏"];
            }
                break;
            case 110:{
                [self showErrorView:@"一天同一个供货商只能申请一次"];
            }
                break;
            default:
                [self showErrorView:@"网络接连异常,请稍后重试"];
                break;
        }
    } Failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络接连异常,请稍后重试"];
    }];
}
#pragma mark -- 电话咨询接口
-(void)addConsultRecordInfoWithUserID:(NSInteger)userID
                          RedAdvertID:(NSInteger)redAdvertID
                           BrowseTime:(NSInteger)browseTime
                             TelPhone:(NSString *)telPhone{
    self.op = [[[RedPacketAdvertNetWorkEngine alloc] init] addConsultRecordInfoWithUserID:userID RedAdvertID:redAdvertID BrowseTime:browseTime TelPhone:telPhone Succeed:^(NSInteger code, NSInteger isRedRecord) {
        switch (code) {
            case 100:{
                _isRedRecord = isRedRecord;
                [UIDevice callUp:telPhone];
            }
                break;
            case 101:{
                [self showErrorView:@"网络接连异常,请稍后重试"];
            }
                break;
            case 103:{
                [self showErrorView:@"浏览时长不足，不能电话咨询"];
            }
                break;
            default:
                [self showErrorView:@"网络接连异常,请稍后重试"];
                break;
        }
    } Failed:^(NSError *error) {
        [self showErrorView:@"网络接连异常,请稍后重试"];
    }];
}
#pragma mark -- 分享按钮点击事件
-(void)shareAdvertBarButtonAction{
    [self showWaitView:@"请稍等..."];
    self.view.userInteractionEnabled = NO;
    self.op = [[[UserCenterNetWorkEngine alloc] init] getShareAddressSuccessed:^(NSInteger code, NSString *shareAddress) {
        [self hideWaitView];
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100: {
                //分享
                NSString *title = [NSString stringByReplaceNullString:_advertInfo.advertTitle];
                NSString *description = [NSString stringByReplaceNullString:_advertInfo.advertTitle];
                UIImage *image;
                NSData *imageData;
                if (self.advertInfo.arrRedAdvertGalleryList.count) {
                    ImageInfo *imageInfo = self.advertInfo.arrRedAdvertGalleryList[0];
                    if (imageInfo.imageBig) {
                        imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageInfo.imageBig]];
                        image = [UIImage imageWithData:imageData];
                    }else{
                        image = [UIImage imageNamed:@"Icon60@3x.png"];
                    }
                }else{
                    image = [UIImage imageNamed:@"Icon60@3x.png"];
                }
                NSString *linkUrl = shareAddress;
                
                SharePlatFormType sharePlatFormType;
                if ([WXApi isWXAppInstalled]&&[TencentOAuth iphoneQQInstalled]) {
                    sharePlatFormType = SharePlatFormSinaWeiBo|SharePlatFormWXFriend|SharePlatFormWXSpace|SharePlatFormQQFriend| SharePlatFormQQSpace;
                }else if ([TencentOAuth iphoneQQInstalled]) {
                    sharePlatFormType = SharePlatFormSinaWeiBo|SharePlatFormQQFriend|SharePlatFormQQSpace;
                }else if ([WXApi isWXAppInstalled]) {
                    sharePlatFormType = SharePlatFormSinaWeiBo|SharePlatFormWXFriend|SharePlatFormWXSpace;
                }else{
                    sharePlatFormType=SharePlatFormSinaWeiBo;
                }
                [self showShareViewWithShareType:sharePlatFormType shareButtonPressed:^(SharePlatFormType sharePlatFormType) {
                    [[HHSoftShareTool sharedHHSoftShareTool] shareLinkContentWithTitle:title description:description thumgImage:image linkUrl:linkUrl shareplatForm:sharePlatFormType shareResponse:^(ShareResponseCode responseCode, SharePlatFormType sharePlatFormType) {
                        if (responseCode == ShareSuccess) {
                            [self showSuccessView:@"分享成功"];
                        }else if (responseCode == ShareError) {
                            [self showErrorView:@"分享错误"];
                        }else if (responseCode == ShareCancel) {
                            [self showErrorView:@"分享取消"];
                        }else if (responseCode == ShareFail) {
                            [self showErrorView:@"分享失败"];
                        }
                    }];
                } shareCancelButtonTitle:@"取消" shareCancelButtonPressed:^{
                    
                }];
            }
                break;
                
            case 101: {
                [self showErrorView:@"获取失败"];
            }
                break;
                
            default: {
                [self showErrorView:@"网络连接异常，请稍后重试"];
            }
                break;
        }
    } failed:^(NSError *error) {
        [self hideWaitView];
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络连接失败，请稍后重试"];
    }];
    
}
@end
