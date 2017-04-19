//
//  AccountManageViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AccountManageViewController.h"
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "GlobalFile.h"
#import "AccountInfo.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "AccountNetWorkEngine.h"
#import "AccountTableCell.h"
#import "AddAccountNumberViewController.h"
#import "AddAccountViewController.h"

@interface AccountManageViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) BOOL isPullToRefresh;
@property (nonatomic, assign) BOOL isLoadMore;
@property (nonatomic, copy) SelectedAccountSucceedBlock selectedAccountSucceedBlock;
@property (nonatomic, assign) ViewType viewType;
@property (nonatomic, strong) AccountInfo *accountInfo;
@property (nonatomic, copy) DeleteAccountSucceedBlock deleteAccountSucceedBlock;

@end

@implementation AccountManageViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (instancetype)initWithViewType:(ViewType)viewType accountInfo:(AccountInfo *)accountInfo selectedAccountSucceedBlock:(SelectedAccountSucceedBlock)selectedAccountSucceedBlock deleteAccountSucceedBlock:(DeleteAccountSucceedBlock)deleteAccountSucceedBlock {
    if (self = [super init]) {
        self.viewType = viewType;
        self.selectedAccountSucceedBlock = selectedAccountSucceedBlock;
        self.accountInfo = accountInfo;
        self.deleteAccountSucceedBlock = deleteAccountSucceedBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的账户";
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"publish"] style:UIBarButtonItemStylePlain target:self action:@selector(walletRightBarButtonClickEvent)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.tintColor = [GlobalFile themeColor];
    [self loadData];
}

- (void)loadData {
    _pageSize = 30;
    _pageIndex = 1;
    _isLoadMore = NO;
    _isPullToRefresh = NO;
    
    //动画
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    //获取账户列表
    [self getMyAccountListWithUserID:[UserInfoEngine getUserInfo].userID page:_pageIndex pageSize:_pageSize];
}

#pragma mark --- 获取账户列表
- (void)getMyAccountListWithUserID:(NSInteger)userID
                              page:(NSInteger)page
                          pageSize:(NSInteger)pageSize {
    self.op = [[[AccountNetWorkEngine alloc] init] getMyAccountListWithUserID:userID page:page pageSize:pageSize successed:^(NSInteger code, NSMutableArray *arrData) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        [self hideLoadingView];
        switch (code) {
            case 100: {
                if (_arrData == nil) {
                    _arrData = [[NSMutableArray alloc] init];
                }
                if (self.pageIndex==1) {
                    [self.arrData removeAllObjects];
                }
                [self.arrData addObjectsFromArray:arrData];
                
                if (!_dataTableView) {
                    [self.view addSubview:self.dataTableView];
                }
                [_dataTableView reloadData];
                
                if (!_isLoadMore&&!_isPullToRefresh) {
                    [self hideLoadingView];
                }else {
                    [_dataTableView stopAnimating];
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
                    [self hideLoadingView];
                    [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        //调接口
                        [self getMyAccountListWithUserID:userID page:page pageSize:pageSize];
                    }];
                }else {
                    [self showErrorView:@"没有更多数据啦"];
                }
                [_dataTableView stopAnimating];
                [_dataTableView setLoadMoreEnabled:NO];
            }
                break;
                
            default: {
                //失败
                if (!_isLoadMore && !_isPullToRefresh) {
                    [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                        //调接口
                        [self getMyAccountListWithUserID:userID page:page pageSize:pageSize];
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
        //失败
        [self hideLoadingView];
        self.navigationItem.rightBarButtonItem.enabled = YES;
        if (!_isLoadMore && !_isPullToRefresh) {
            [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadErrorImage] failTouch:^{
                [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                //调接口
                [self getMyAccountListWithUserID:userID page:page pageSize:pageSize];
            }];
        } else {
            [self showErrorView:[GlobalFile HHSoftUnableLinkNetWork]];
            if (_isLoadMore) {
                _pageIndex--;
            }
        }
        [_dataTableView stopAnimating];
    }];
}

#pragma mark --- 初始化TableView
- (HHSoftTableView *)dataTableView {
    if (_dataTableView == nil) {
        _dataTableView = [[HHSoftTableView alloc]initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStyleGrouped separatorColor:[UIColor clearColor]];
        __weak typeof(self) _weakself=self;
        [_dataTableView addPullToRefresh:^{
            _weakself.isPullToRefresh=YES;
            _weakself.isLoadMore=NO;
            _weakself.pageIndex=1;
            //调接口
            [_weakself getMyAccountListWithUserID:[UserInfoEngine getUserInfo].userID page:_weakself.pageIndex pageSize:_weakself.pageSize];
        }];
        [_dataTableView addLoadMore:^{
            _weakself.isPullToRefresh=NO;
            _weakself.isLoadMore=YES;
            _weakself.pageIndex+=1;
            //调接口
            [_weakself getMyAccountListWithUserID:[UserInfoEngine getUserInfo].userID page:_weakself.pageIndex pageSize:_weakself.pageSize];
        }];
    }
    return _dataTableView;
}

#pragma mark --- TableView的代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountInfo *accountInfo = _arrData[indexPath.section];
    return [AccountTableCell getCellHeightWith:accountInfo];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *menuCell = @"AccountTableCell";
    AccountTableCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCell];
    if (!cell) {
        cell = [[AccountTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCell];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.accountInfo = _arrData[indexPath.section];
    //设置默认账户
    cell.setDefaultAccountBlock = ^(){
        AccountInfo *accountInfo = _arrData[indexPath.section];
        [self showWaitView:@"请稍等..."];
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.view.userInteractionEnabled = NO;
        [self setDefaultAccountWithUserAccountID:accountInfo.accountID];
    };
    //删除
    cell.deleteAccountBlock = ^(){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该账户？" preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            AccountInfo *accountInfo = _arrData[indexPath.section];
            [self showWaitView:@"请稍等..."];
            self.navigationItem.rightBarButtonItem.enabled = NO;
            self.view.userInteractionEnabled = NO;
            [self deleteAccountWithUserAccountID:accountInfo.accountID UserID:[UserInfoEngine getUserInfo].userID IndexPath:indexPath];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AccountInfo *accountInfo = _arrData[indexPath.section];
    if (_viewType == ViewTypeWithWithdrawal) {
        if (_selectedAccountSucceedBlock) {
            _selectedAccountSucceedBlock(accountInfo);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark --- 添加按钮点击事件
- (void)walletRightBarButtonClickEvent {
    AddAccountViewController *addAccountViewController = [[AddAccountViewController alloc]initWithAddAccountSuccessedBlock:^{
        [self loadData];
    }];
    [self.navigationController pushViewController:addAccountViewController animated:YES];
}

#pragma mark --- 设置默认账户接口
- (void)setDefaultAccountWithUserAccountID:(NSInteger)accountID {
    self.op = [[[AccountNetWorkEngine alloc] init] setDefaultAccountWithUserAccountID:accountID successed:^(NSInteger code) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100: {
                [self showSuccessView:@"设置成功"];
                [self loadData];
            }
                break;
                
            case 101: {
                [self showErrorView:@"设置失败"];
            }
                break;
                
            default: {
                [self showErrorView:@"网络连接异常，请稍后重试"];
            }
                break;
        }
    } failed:^(NSError *error) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络连接失败，请稍后重试"];
    }];
}

#pragma mark --- 删除账户接口
- (void)deleteAccountWithUserAccountID:(NSInteger)accountID UserID:(NSInteger)userID IndexPath:(NSIndexPath *)indexPath {
    self.op = [[[AccountNetWorkEngine alloc] init] deleteAccountWithUserAccountID:accountID userID:userID successed:^(NSInteger code) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100: {
                [self showSuccessView:@"删除成功"];
                [self.arrData removeObjectAtIndex:indexPath.section];
                [_dataTableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
                [_dataTableView reloadData];
                if (_accountInfo.accountID == accountID) {
                    if (_deleteAccountSucceedBlock) {
                        _deleteAccountSucceedBlock();
                    }
                }
                if (_arrData.count == 0) {
                    [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                    }];
                }
            }
                break;
                
            case 101: {
                [self showErrorView:@"删除失败"];
            }
                break;
                
            default: {
                [self showErrorView:@"网络连接异常，请稍后重试"];
            }
                break;
        }
    } failed:^(NSError *error) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络连接失败，请稍后重试"];
    }];
}

@end
