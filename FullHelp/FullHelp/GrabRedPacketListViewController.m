//
//  GrabRedPacketListViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "GrabRedPacketListViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import "GlobalFile.h"
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "AdvertInfo.h"
#import "RedPacketAdvertNetWorkEngine.h"
#import "RedPacketAdvertCell.h"
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import "NSMutableAttributedString+hhsoft.h"
#import "IndustryInfo.h"
@interface GrabRedPacketListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, assign)  CGFloat headerViewH;
@property (nonatomic, assign) BOOL isPullToRefresh;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) BOOL isLoadMore;
@property (nonatomic, copy) NSString *hour;
@property (nonatomic, copy) NSString *minute;
@property (nonatomic, copy) NSString *second;
@property (nonatomic, strong) NSTimer *countDownTimer;
@property (nonatomic, copy) NSString *countDownStr;
@property (nonatomic, strong) HHSoftLabel *countDownLabel;
/**
 活动剩余时间
 */
@property (nonatomic, assign) NSInteger restTime;
@end

@implementation GrabRedPacketListViewController
- (instancetype) init {
    if (self = [super init]) {
        
        _pageIndex = 1;
        _pageSize = 30;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationItem];
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    [self getGrabRedPacketList];
}
- (void)getGrabRedPacketList {
    [[[RedPacketAdvertNetWorkEngine alloc] init] getGrabRedPacketListWithIndustryID:[IndustryInfo getIndustryInfo].industryID page:_pageIndex pageSize:_pageSize successed:^(NSInteger code, NSInteger endSecond, NSMutableArray *arrData) {
        switch (code) {
            case 100:
            {
                if (_pageIndex == 1) {
                    [self.arrData removeAllObjects];
                }
                _restTime = endSecond;
                if (_restTime>0) {
                    _headerViewH = 100;
                }
                else {
                    _headerViewH = 60;
                }
                [self.arrData addObjectsFromArray:arrData];
                if (!_dataTableView) {
                    [self.view addSubview:self.dataTableView];
                }else {
                    [self.dataTableView reloadData];
                }
                if (!_isLoadMore&&!_isPullToRefresh) {
                    [self hideLoadingView];
                }else {
                    [_dataTableView stopAnimating];
                }
                _dataTableView.showsInfiniteScrolling=_arrData.count==_pageIndex*_pageSize?YES:NO;
            }
                break;
            case 101: {
                if (!_isLoadMore&&!_isPullToRefresh) {
                    [self hideLoadingView];
                    [self showLoadDataFailViewInView:self.view WithText:@"暂无数据" failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                        [self hideLoadingView];
                        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        [self getGrabRedPacketList];
                    }];
                }else {
                    [self showErrorView:@"暂无数据"];
                }
                [_dataTableView stopAnimating];
                [_dataTableView setShowsInfiniteScrolling:NO];
            }
                break;
            default: {
                if (!_isLoadMore&&!_isPullToRefresh) {
                    [self hideLoadingView];
                    [self showLoadDataFailViewInView:self.view WithText:@"网络异常" failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                        [self hideLoadingView];
                        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        [self getGrabRedPacketList];
                    }];
                }else {
                    [self showErrorView:@"网络异常"];
                }
            }
                break;
        }
    } failed:^(NSError *error) {
        if (!_isLoadMore&&!_isPullToRefresh) {
            [self hideLoadingView];
            [self showLoadDataFailViewInView:self.view WithText:@"网络异常" failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                [self hideLoadingView];
                [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                [self getGrabRedPacketList];
            }];
        }else {
            [self showErrorView:@"网络异常"];
            if (_isLoadMore) {
                _pageIndex--;
            }
            [_dataTableView stopAnimating];
        }
    }];
     
}
#pragma mark ------ 设置导航栏
- (void)setNavigationItem {
    self.navigationItem.title = @"限时活动";
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
}
#pragma mark ------ headerView
- (UIView *)headerView {
    if (!_headerView) {
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, _headerViewH)];
        HHSoftLabel *hintLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(10, 20, [HHSoftAppInfo AppScreen].width-20, 20) fontSize:16 text:@"•  每天11点开抢  •" textColor:[GlobalFile themeColor] textAlignment:1 numberOfLines:1];
        [_headerView addSubview:hintLabel];
        NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:@"•  每天11点开抢  •"];
        [attributed changeStr:@"每天11点开抢" changeFont:hintLabel.font changeColor:[UIColor lightGrayColor]];
        hintLabel.attributedText = attributed;
        
        _countDownLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(hintLabel.frame)+20, [HHSoftAppInfo AppScreen].width-20, 25) fontSize:14 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
        [_headerView addSubview:_countDownLabel];
        
        
        _countDownStr = [NSString stringWithFormat:@"%@",[self timeformatFromSeconds:_restTime]];
        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startTimeCountDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_countDownTimer forMode:UITrackingRunLoopMode];
        [_countDownTimer fire];
    }
    return _headerView;
}
#pragma mark ------ 倒计时
- (void)startTimeCountDown {
    if (_restTime>0) {
        _restTime--;
        _countDownStr = [NSString stringWithFormat:@"距离活动开始还有  %@",[self timeformatFromSeconds:_restTime]];
        _countDownLabel.attributedText = [self changeCountDownLabelTextWithStr:_countDownStr];
        if (_restTime == 0) {
            [_countDownTimer invalidate];
            _countDownTimer = nil;
        }
    }
    else {
        [_countDownTimer invalidate];
        _countDownTimer = nil;
    }
}

#pragma mark ----------------- tableView
-(HHSoftTableView *)dataTableView{
    if (_dataTableView==nil) {
        _dataTableView=[[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStylePlain separatorColor:[UIColor clearColor]];
        _dataTableView.tableHeaderView = self.headerView;
        _dataTableView.backgroundColor = self.view.backgroundColor;
        __weak typeof(self) _weakself=self;
        [_dataTableView addPullToRefresh:^{
            _weakself.pageIndex = 1;
            _weakself.isPullToRefresh=YES;
            _weakself.isLoadMore = NO;
            [_weakself getGrabRedPacketList];
        }];
        [_dataTableView addLoadMore:^{
            _weakself.pageIndex += 1;
            _weakself.isPullToRefresh=NO;
            _weakself.isLoadMore = YES;
            [_weakself getGrabRedPacketList];
        }];
    }
    return _dataTableView;
}
#pragma mark--UITableViewDelegate
#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ([HHSoftAppInfo AppScreen].width-20)/2+40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *string=@"Identifier";
    RedPacketAdvertCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
    if (!cell) {
        cell=[[RedPacketAdvertCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string cellType:CellTypeGrabAdvert];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    cell.advertInfo = self.arrData[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark ------ 根据秒计算天时分秒
-(NSString*)timeformatFromSeconds:(NSInteger)seconds
{
    _hour = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%02ld",seconds/3600%24]];
    _minute = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%02ld",(seconds%3600)/60]];
    _second = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%02ld",seconds%60]];
    NSString *time = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@ : %@ : %@",_hour,_minute,_second]];
    return time;
}
- (NSMutableAttributedString *)changeCountDownLabelTextWithStr:(NSString *)str {
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange hourRange = NSMakeRange(10, 2);
    NSDictionary *dicHour = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[GlobalFile themeColor],NSBackgroundColorAttributeName, nil];
    [attributed addAttributes:dicHour range:hourRange];
    
    NSRange minuteRange = NSMakeRange(15, 2);
    NSDictionary *minuteHour = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[GlobalFile themeColor],NSBackgroundColorAttributeName, nil];
    [attributed addAttributes:minuteHour range:minuteRange];
    
    NSRange secondRange = NSMakeRange(20, 2);
    NSDictionary *secondHour = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[GlobalFile themeColor],NSBackgroundColorAttributeName, nil];
    [attributed addAttributes:secondHour range:secondRange];
    
    _countDownLabel.attributedText = attributed;
    return  attributed;
}
- (NSMutableArray *)arrData {
    if (!_arrData) {
        _arrData = [NSMutableArray array];
    }
    return _arrData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
