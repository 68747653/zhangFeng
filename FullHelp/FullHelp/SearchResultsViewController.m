//
//  SearchResultsViewController.m
//  FullHelp
//
//  Created by hhsoft on 17/2/14.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "SearchResultsViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftDefaults.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "HHSoftBarButtonItem.h"
#import "IndustryInfo.h"
#import "RedPacketAdvertNetWorkEngine.h"
#import "RedPacketAdvertCell.h"
#import "AdvertInfo.h"
#import "RedPacketAdvertDetailViewController.h"

@interface SearchResultsViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,copy) NSString *keyWord;
@property (nonatomic,assign) NSInteger pageIndex,pageSize;
@property (nonatomic,assign) BOOL isPullToRefresh;
@property (nonatomic,assign) BOOL isLoadMore;
@property (nonatomic,strong) NSMutableArray *arrHistory;
@property (nonatomic,copy) NSString *key;
@property (nonatomic,strong) HHSoftDefaults *hhosftDefaults;
@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,assign) NSInteger mark;

@end

@implementation SearchResultsViewController
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(instancetype)initWithKey:(NSString *)key KeyWord:(NSString *)keyWord ArrHistory:(NSMutableArray *)arrHistory{
    if(self = [super init]){
        _key = key;
        _keyWord = keyWord;
        _arrHistory = arrHistory;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    self.navigationItem.titleView = [self titleView];
    self.navigationItem.leftBarButtonItem = [[HHSoftBarButtonItem alloc] initBackButtonWithBackBlock:^{
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
    _pageSize = 30;
    _pageIndex = 1;
    _isLoadMore = NO;
    _isPullToRefresh = NO;
    _mark = 2;
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    //获取搜索结果
    [self getNewRedPacketListWithIndustryID:[IndustryInfo getIndustryInfo].industryID page:_pageIndex pageSize:_pageSize mark:_mark keyWordds:_keyWord];
}
#pragma mark -- 获取搜索结果
-(void)getNewRedPacketListWithIndustryID:(NSInteger)industryID
                                    page:(NSInteger)page
                                pageSize:(NSInteger)pageSize
                                    mark:(NSInteger)mark
                               keyWordds:(NSString *)keyWords{
    self.op = [[[RedPacketAdvertNetWorkEngine alloc] init] getNewRedPacketListWithIndustryID:industryID page:page pageSize:pageSize mark:mark keyWordds:keyWords successed:^(NSInteger code, NSMutableArray *arrData) {
        [self hideLoadingView];
        switch (code) {
            case 100:{
                if (!_arrData) {
                    _arrData = [NSMutableArray array];
                }
                if (_pageIndex == 1) {
                    [self.arrData removeAllObjects];
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
                        //获取搜索结果
                        [self getNewRedPacketListWithIndustryID:industryID page:page pageSize:pageSize mark:mark keyWordds:keyWords];
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
                        //获取搜索结果
                        [self getNewRedPacketListWithIndustryID:industryID page:page pageSize:pageSize mark:mark keyWordds:keyWords];
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
                //获取搜索结果
                [self getNewRedPacketListWithIndustryID:industryID page:page pageSize:pageSize mark:mark keyWordds:keyWords];
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
#pragma mark ----------------- tableView
-(HHSoftTableView *)dataTableView{
    if (_dataTableView==nil) {
        _dataTableView=[[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStylePlain separatorColor:[UIColor clearColor]];
        _dataTableView.backgroundColor = self.view.backgroundColor;
        __weak typeof(self) _weakself=self;
        [_dataTableView addPullToRefresh:^{
            _weakself.pageIndex = 1;
            _weakself.isPullToRefresh=YES;
            _weakself.isLoadMore = NO;
            //获取搜索结果
            [_weakself getNewRedPacketListWithIndustryID:[IndustryInfo getIndustryInfo].industryID page:_weakself.pageIndex pageSize:_weakself.pageSize mark:_weakself.mark keyWordds:_weakself.keyWord];
        }];
        [_dataTableView addLoadMore:^{
            _weakself.pageIndex += 1;
            _weakself.isPullToRefresh=NO;
            _weakself.isLoadMore = YES;
            //获取搜索结果
            [_weakself getNewRedPacketListWithIndustryID:[IndustryInfo getIndustryInfo].industryID page:_weakself.pageIndex pageSize:_weakself.pageSize mark:_weakself.mark keyWordds:_weakself.keyWord];
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
    return ([HHSoftAppInfo AppScreen].width-20)/2+65;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *string=@"Identifier";
    RedPacketAdvertCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
    if (!cell) {
        cell=[[RedPacketAdvertCell alloc] initWithNewAdvertStyle:UITableViewCellStyleDefault reuseIdentifier:string cellType:CellTypeNew];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    cell.advertInfo = self.arrData[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AdvertInfo *advertInfo = self.arrData[indexPath.row];
    //广告详情
    RedPacketAdvertDetailViewController *redPacketAdvertDetailViewController = [[RedPacketAdvertDetailViewController alloc] initWithRedPacketAdvertID:advertInfo.advertID];
    redPacketAdvertDetailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:redPacketAdvertDetailViewController animated:YES];
}
#pragma mark -- 初始化搜索
-(UIView *)titleView{
    if (_titleView == nil) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width-80, 30)];
        _titleView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
        _titleView.layer.cornerRadius = 3.0;
        //输入框
        UITextField *searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width-80, 30)];
        searchTextField.placeholder = @"搜索广告、供应商、关键词";
        searchTextField.text = _keyWord;
        searchTextField.delegate = self;
        searchTextField.font = [UIFont systemFontOfSize:14.0];
        searchTextField.returnKeyType =UIReturnKeySearch;
        searchTextField.clearButtonMode = UITextFieldViewModeAlways;
        searchTextField.tintColor = [UIColor lightGrayColor];
        searchTextField.tag = 333;
        [_titleView addSubview:searchTextField];
        UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7.5, 30, 15)];
        searchImageView.image = [UIImage imageNamed:@"search.png"];
        searchImageView.contentMode = UIViewContentModeCenter;
        searchTextField.leftViewMode = UITextFieldViewModeAlways;
        searchTextField.leftView = searchImageView;
    }
    return _titleView;
}
#pragma mark ------ UIScrollViewDelegate
#pragma mark --- 拖拽时的代理（手动滚动时）
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
#pragma mark ------ 搜索按钮监听
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    textField.text = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [textField resignFirstResponder];
    _keyWord = textField.text;
    if (_keyWord.length == 0 ||[[_keyWord stringByTrimingWhitespace] isEqualToString:@""]) {
        //获取数据
        //获取搜索结果
        [self getNewRedPacketListWithIndustryID:[IndustryInfo getIndustryInfo].industryID page:_pageIndex pageSize:_pageSize mark:_mark keyWordds:_keyWord];
    }else{
        if (![_arrHistory containsObject:_keyWord]) {
            [_arrHistory insertObject:_keyWord atIndex:0];
            _hhosftDefaults = [[HHSoftDefaults alloc] init];
            [_hhosftDefaults saveObject:_arrHistory forKey:_key];
        }
        //获取数据
        //获取搜索结果
        [self getNewRedPacketListWithIndustryID:[IndustryInfo getIndustryInfo].industryID page:_pageIndex pageSize:_pageSize mark:_mark keyWordds:_keyWord];
    }
    return YES;
}
@end
