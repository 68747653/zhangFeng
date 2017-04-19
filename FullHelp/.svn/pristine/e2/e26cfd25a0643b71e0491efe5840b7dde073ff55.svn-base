//
//  MyRedViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/13.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "MyRedViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import "GlobalFile.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "AccountNetWorkEngine.h"
#import "AccountChangeInfo.h"
#import "RedTableCell.h"
#import "MenuInfo.h"

@interface MyRedViewController () <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *arrData, *arrRedTypeData;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
/**
 *  是否支持下拉刷新
 */
@property (nonatomic, assign) BOOL isPullToRefresh;
/**
 *  是否支持加载更多
 */
@property (nonatomic, assign) BOOL isLoadMore;
@property (nonatomic, strong) UserInfo *userInfo;
@property (nonatomic, assign) NSInteger mark, redType;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic, strong) HHSoftLabel *redTypeLabel;
@property (nonatomic, strong) UIControl *hideDatePickerContorl;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIToolbar *dateToolbar;

@end

@implementation MyRedViewController

- (instancetype)initWithMark:(NSInteger)mark {
    if (self = [super init]) {
        self.mark = mark;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    if (_mark == 1) {
        self.navigationItem.title = @"我收到的红包";
    } else if (_mark == 2) {
        self.navigationItem.title = @"我发出的红包";
    }
    [self loadData];
}

- (void)loadData {
    _redType = 0;
    _arrRedTypeData = [self getMyRedData];
    _pageIndex = 1;
    _pageSize = 30;
    _isPullToRefresh = NO;
    _isLoadMore = NO;
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    [self getUserRedRecordListWithUserID:[UserInfoEngine getUserInfo].userID page:_pageIndex pageSize:_pageSize mark:_mark redType:_redType];
}

- (void)getUserRedRecordListWithUserID:(NSInteger)userID page:(NSInteger)page pageSize:(NSInteger)pageSize mark:(NSInteger)mark redType:(NSInteger)redType {
    self.op = [[[AccountNetWorkEngine alloc] init] getUserRedRecordListWithUserID:userID page:page pageSize:pageSize mark:mark redType:redType successed:^(NSInteger code, UserInfo *userInfo) {
        [self hideLoadingView];
        if (!self.view.userInteractionEnabled) {
            [self hideWaitView];
            self.view.userInteractionEnabled = YES;
        }
        switch (code) {
            case 100: {
                if (!_arrData) {
                    _arrData = [NSMutableArray arrayWithCapacity:0];
                }
                if (_pageIndex == 1) {
                    _userInfo = userInfo;
                    [self.arrData removeAllObjects];
                }
                [self.arrData addObjectsFromArray:userInfo.userArrRedRecord];
                if (!_dataTableView) {
                    [self.view addSubview:self.dataTableView];
                }
                [self.dataTableView reloadData];
                
                if (!_isLoadMore && !_isPullToRefresh) {
                    [self hideLoadingView];
                } else {
                    [self.dataTableView stopAnimating];
                }
                
                if (_arrData.count == _pageIndex * _pageSize) {
                    [_dataTableView setLoadMoreEnabled:YES];
                } else {
                    [_dataTableView setLoadMoreEnabled:NO];
                }
            }
                break;
                
            case 101: {
                //没有数据
                if (!_isLoadMore && !_isPullToRefresh) {
                    [_arrData removeAllObjects];
                    [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                        _isLoadMore = NO;
                        _isPullToRefresh = NO;
                        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        [self getUserRedRecordListWithUserID:userID page:page pageSize:pageSize mark:mark redType:redType];
                    }];
                } else {
                    [self showErrorView:@"没有更多数据啦"];
                }
                [_dataTableView stopAnimating];
                [_dataTableView setLoadMoreEnabled:NO];
            }
                break;
                
            default: {
                if (!_isLoadMore && !_isPullToRefresh) {
                    [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                        _isLoadMore = NO;
                        _isPullToRefresh = NO;
                        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        [self getUserRedRecordListWithUserID:userID page:page pageSize:pageSize mark:mark redType:redType];
                    }];
                } else {
                    [self showErrorView:[GlobalFile HHSoftLoadError]];
                }
                [_dataTableView stopAnimating];
                [_dataTableView setLoadMoreEnabled:NO];
            }
                break;
        }
    } failed:^(NSError *error) {
        [self hideLoadingView];
        if (!self.view.userInteractionEnabled) {
            [self hideWaitView];
            self.view.userInteractionEnabled = YES;
        }
        if (!_isLoadMore && !_isPullToRefresh) {
            [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftUnableLinkNetWork] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                _isLoadMore = NO;
                _isPullToRefresh = NO;
                [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                [self getUserRedRecordListWithUserID:userID page:page pageSize:pageSize mark:mark redType:redType];
            }];
        } else {
            [self showErrorView:[GlobalFile HHSoftUnableLinkNetWork]];
            if (_isLoadMore == YES) {
                _pageIndex--;
            }
        }
        [_dataTableView stopAnimating];
    }];
}

/**
 初始化dataTableView
 
 @return dataTableView
 */
- (HHSoftTableView *)dataTableView {
    if (!_dataTableView) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height - 64) dataSource:self delegate:self style:UITableViewStylePlain];
        __weak typeof(self) _weakself = self;
        //下拉刷新
        [_dataTableView addPullToRefresh:^{
            _weakself.isPullToRefresh = YES;
            _weakself.isLoadMore = NO;
            _weakself.pageIndex = 1;
            [_weakself getUserRedRecordListWithUserID:[UserInfoEngine getUserInfo].userID page:_weakself.pageIndex pageSize:_weakself.pageSize mark:_weakself.mark redType:_weakself.redType];
        }];
        //加载更多
        [_dataTableView addLoadMore:^{
            _weakself.isPullToRefresh = NO;
            _weakself.isLoadMore = YES;
            _weakself.pageIndex ++;
            [_weakself getUserRedRecordListWithUserID:[UserInfoEngine getUserInfo].userID page:_weakself.pageIndex pageSize:_weakself.pageSize mark:_weakself.mark redType:_weakself.redType];
        }];
        _dataTableView.tableHeaderView = self.headerView;
    }
    return _dataTableView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].width/4.0*3)];
        
        UIView *leftTopView = [[UIView alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width - 100, 20, 90, 40)];
        _redTypeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(0, 0, 90, 30) fontSize:14.0 text:@"全部" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
        _redTypeLabel.userInteractionEnabled = YES;
        [leftTopView addSubview:_redTypeLabel];
        
        UIImageView *typeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(38, 30, 14, 8)];
        typeImgView.layer.masksToBounds = YES;
        typeImgView.userInteractionEnabled = YES;
        typeImgView.contentMode = UIViewContentModeScaleAspectFill;
        typeImgView.image = [UIImage imageNamed:@"redRecord_redType"];
        [leftTopView addSubview:typeImgView];
        //手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taplLeftTopViewClick)];
        [leftTopView addGestureRecognizer:tap];
        [_headerView addSubview:leftTopView];
        
        //头像
        UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(([HHSoftAppInfo AppScreen].width-[HHSoftAppInfo AppScreen].width/2.0/2)/2.0, 40, [HHSoftAppInfo AppScreen].width/2.0/2, [HHSoftAppInfo AppScreen].width/2.0/2)];
        headImageView.layer.cornerRadius = headImageView.frame.size.width/2.0;
        headImageView.layer.masksToBounds = YES;
        headImageView.userInteractionEnabled = YES;
        headImageView.contentMode = UIViewContentModeScaleAspectFill;
        headImageView.tag = 258;
        [_headerView addSubview:headImageView];
        
        HHSoftLabel *redInfoLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(headImageView.frame), [HHSoftAppInfo AppScreen].width - 20, [HHSoftAppInfo AppScreen].width/4.0*3 - CGRectGetMaxY(headImageView.frame)) fontSize:16.0 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentCenter numberOfLines:0];
        redInfoLabel.tag = 259;
        [_headerView addSubview:redInfoLabel];
    }
//    NSTextAttachment *atta = [[NSTextAttachment alloc] init];
//    atta.image = [UIImage imageNamed:@"redRecord_redType"];
//    atta.bounds = CGRectMake(30, 60, 30, 15);
//    NSAttributedString *attri = [NSAttributedString attributedStringWithAttachment:atta];
//    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"全部\n"]];
//    [attr appendAttributedString:attri];
//    _redTypeLabel.attributedText = attr;
    //头像
    UIImageView *headImageView = (UIImageView *)[_headerView viewWithTag:258];
    [headImageView sd_setImageWithURL:[NSURL URLWithString:_userInfo.userHeadImg] placeholderImage:[GlobalFile avatarImage]];
    HHSoftLabel *redInfoLabel = (HHSoftLabel *)[_headerView viewWithTag:259];
    NSString *str1 = @"";
    if (_mark == 1) {
        str1 = @"共收到";
    } else if (_mark == 2) {
        str1 = @"共发出";
    }
    NSString *str2 = [NSString stringWithFormat:@"%@元", [GlobalFile stringFromeFloat:_userInfo.userFees decimalPlacesCount:2]];
    NSString *str3 = [NSString stringWithFormat:@"%@", @(_userInfo.userRedNum)];
    NSString *str4 = @"";
    if (_mark == 1) {
        str4 = [NSString stringWithFormat:@"收到的红包总数%@个", str3];
    } else if (_mark == 2) {
        str4 = [NSString stringWithFormat:@"发出红包总数%@个", str3];
    }
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@\n%@", str1, str2, str4]];
    [attributed addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:50.0] range:NSMakeRange(str1.length+1, str2.length-1)];
    [attributed addAttribute:NSForegroundColorAttributeName value:[GlobalFile themeColor] range:NSMakeRange(str1.length+1, str2.length)];
    [attributed addAttribute:NSForegroundColorAttributeName value:[GlobalFile themeColor] range:NSMakeRange(attributed.length-str3.length-1, str3.length)];
    redInfoLabel.attributedText = attributed;
    return _headerView;
}

- (void)taplLeftTopViewClick {
    self.hideDatePickerContorl.frame = CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height);
    [UIView animateWithDuration:0.3 animations:^{
        self.dateToolbar.frame = CGRectMake(0, [HHSoftAppInfo AppScreen].height - 194, [HHSoftAppInfo AppScreen].width, 44);
        [self.pickerView selectRow:_redType inComponent:0 animated:YES];
        self.pickerView.frame = CGRectMake(0, [HHSoftAppInfo AppScreen].height - 150, [HHSoftAppInfo AppScreen].width, 150);
    }];
}

#pragma mark --- UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountChangeInfo *accountChangeInfo = _arrData[indexPath.row];
    return [RedTableCell getCellHeightWith:accountChangeInfo];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountChangeInfo *accountChangeInfo = _arrData[indexPath.row];
    static NSString *identifier = @"RedTableCell";
    RedTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[RedTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.accountChangeInfo = accountChangeInfo;
    return cell;
}

/**
 初始化hideDatePickerContorl
 
 @return UIControl
 */
- (UIControl *)hideDatePickerContorl {
    if (!_hideDatePickerContorl) {
        _hideDatePickerContorl = [[UIControl alloc] initWithFrame:CGRectMake(0, [HHSoftAppInfo AppScreen].height, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height)];
        _hideDatePickerContorl.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [_hideDatePickerContorl addTarget:self action:@selector(hideDatePickerContorlPress) forControlEvents:UIControlEventTouchUpInside];
        [[UIApplication sharedApplication].keyWindow addSubview:_hideDatePickerContorl];
    }
    return _hideDatePickerContorl;
}

- (void)hideDatePickerContorlPress {
    self.hideDatePickerContorl.frame = CGRectMake(0, [HHSoftAppInfo AppScreen].height, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height);
    [UIView animateWithDuration:0.3 animations:^{
        self.dateToolbar.frame = CGRectMake(0, [HHSoftAppInfo AppScreen].height, [HHSoftAppInfo AppScreen].width, 44);
        self.pickerView.frame = CGRectMake(0, [HHSoftAppInfo AppScreen].height+44, [HHSoftAppInfo AppScreen].width, 150);
    }];
}

/**
 初始化UIDatePicker

 @return UIPickerView
 */
- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, [HHSoftAppInfo AppScreen].height+150, [HHSoftAppInfo AppScreen].width, 150)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [[UIApplication sharedApplication].keyWindow addSubview:_pickerView];
    }
    return _pickerView;
}

- (UIToolbar *)dateToolbar {
    if (!_dateToolbar) {
        _dateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, [HHSoftAppInfo AppScreen].height + 44, [HHSoftAppInfo AppScreen].width, 44)];
        //设置工具条的颜色
        _dateToolbar.barTintColor = [UIColor whiteColor];
        //给工具条添加按钮
        UIBarButtonItem *cancleItem = [[UIBarButtonItem alloc] initWithTitle:@"  取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleItemPressed) ];
        [cancleItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[HHSoftAppInfo defaultLightSystemColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc]initWithTitle:@"确定  " style:UIBarButtonItemStylePlain target:self action:@selector(confirmItemPressed)];
        [confirmItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[GlobalFile themeColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [_dateToolbar setItems:[NSArray arrayWithObjects:cancleItem, flexSpace, confirmItem, nil] animated:YES];
        [[UIApplication sharedApplication].keyWindow addSubview:_dateToolbar];
    }
    return _dateToolbar;
}

- (void)confirmItemPressed {
    [self hideDatePickerContorlPress];
    for (MenuInfo *menuInfo in self.arrRedTypeData) {
        if (_redType == menuInfo.menuID) {
//            NSTextAttachment *atta = [[NSTextAttachment alloc] init];
//            atta.image = [UIImage imageNamed:@"redRecord_redType"];
//            atta.bounds = CGRectMake(30, 40, 30, 15);
//            NSAttributedString *attri = [NSAttributedString attributedStringWithAttachment:atta];
//            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n", menuInfo.menuName]];
//            [attr appendAttributedString:attri];
//            _redTypeLabel.attributedText = attr;
            _redTypeLabel.text = menuInfo.menuName;
        }
    }
    [self showWaitView:@"请稍等..."];
    self.view.userInteractionEnabled = NO;
    //调接口
    [self getUserRedRecordListWithUserID:[UserInfoEngine getUserInfo].userID page:1 pageSize:30 mark:_mark redType:_redType];
}

- (void)cancleItemPressed {
    [self hideDatePickerContorlPress];
}

#pragma mark --- UIPickerViewDataSource & UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _arrRedTypeData.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    MenuInfo *menuInfo = _arrRedTypeData[row];
    return menuInfo.menuName;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    MenuInfo *menuInfo = _arrRedTypeData[row];
    _redType = menuInfo.menuID;
}

/**
 红包类型
 
 @return arrData
 */
- (NSMutableArray *)getMyRedData {
    MenuInfo *menuInfo0 = [[MenuInfo alloc] initWithMenuID:0 menuName:@"全部"];
    MenuInfo *menuInfo1 = [[MenuInfo alloc] initWithMenuID:1 menuName:@"今日红包"];
    MenuInfo *menuInfo2 = [[MenuInfo alloc] initWithMenuID:2 menuName:@"口令红包"];
    MenuInfo *menuInfo3 = [[MenuInfo alloc] initWithMenuID:3 menuName:@"需求红包"];
    MenuInfo *menuInfo4 = [[MenuInfo alloc] initWithMenuID:4 menuName:@"游戏红包"];
    MenuInfo *menuInfo5 = [[MenuInfo alloc] initWithMenuID:5 menuName:@"登录红包"];
    MenuInfo *menuInfo6 = [[MenuInfo alloc] initWithMenuID:6 menuName:@"专场红包"];
    MenuInfo *menuInfo7 = [[MenuInfo alloc] initWithMenuID:7 menuName:@"电话红包"];
    MenuInfo *menuInfo8 = [[MenuInfo alloc] initWithMenuID:8 menuName:@"申请打赏红包"];
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:menuInfo0, menuInfo1, menuInfo2, menuInfo3, menuInfo4, menuInfo5, menuInfo6, menuInfo7, menuInfo8, nil];
    
    return arr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
