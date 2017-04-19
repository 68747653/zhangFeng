//
//  MyWalletViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/8.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "MyWalletViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import "GlobalFile.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "MenuInfo.h"
#import "UserCenterNetWorkEngine.h"
#import "AccountChangeViewController.h"
#import "WithdrawalViewController.h"
#import "AccountManageViewController.h"
#import "RechargeViewController.h"
#import "RechargeRecordViewController.h"
#import "AccountNetWorkEngine.h"
#import "AccountInfo.h"
#import "SetWithdrawalPwdViewController.h"
#import "MerchantsRewardApplyViewController.h"
#import "SupplierRewardApplyViewController.h"
#import "MyRedViewController.h"

@interface MyWalletViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) AccountInfo *accountInfo;

@end

@implementation MyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的钱包";
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    [self getUserAccountInfoWithUserID:[UserInfoEngine getUserInfo].userID];
    _arrData = [self getSettingsData];
}

- (void)getUserAccountInfoWithUserID:(NSInteger)userID {
    self.op = [[[AccountNetWorkEngine alloc] init] getUserAccountInfoWithUserID:userID successed:^(NSInteger code, AccountInfo *accountInfo) {
        [self hideLoadingView];
        switch (code) {
            case 100: {
                _accountInfo = accountInfo;
                if (!_dataTableView) {
                    [self.view addSubview:self.dataTableView];
                }
            }
                break;
                
            case 101: {
                [self showErrorView:@"获取失败"];
            }
                break;
                
            default: {
                [self showErrorView:[GlobalFile HHSoftLoadError]];
            }
                break;
        }
        [self.dataTableView reloadData];
    } failed:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorView:[GlobalFile HHSoftUnableLinkNetWork]];
        [self.dataTableView reloadData];
    }];
}

#pragma mark --- 初始化dataTableView
- (HHSoftTableView *)dataTableView {
    if (_dataTableView == nil) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStyleGrouped];
    }
    return _dataTableView;
}

#pragma mark --- TableView的代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arrData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_arrData[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuInfo *menuInfo = [_arrData[indexPath.section] objectAtIndex:indexPath.row];
    static NSString *strCell = @"UserWalletInfoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.textColor = [HHSoftAppInfo defaultDeepSystemColor];
    }
    cell.textLabel.text = menuInfo.menuName;
    if (menuInfo.menuID == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@：￥%@", menuInfo.menuName, [GlobalFile stringFromeFloat:_accountInfo.accountFees decimalPlacesCount:2]]];
        [attr addAttribute:NSForegroundColorAttributeName value:[GlobalFile themeColor] range:NSMakeRange(menuInfo.menuName.length+1, attr.length - menuInfo.menuName.length - 1)];
        cell.textLabel.attributedText = attr;
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MenuInfo *menuInfo = [_arrData[indexPath.section] objectAtIndex:indexPath.row];
    switch (menuInfo.menuID) {
        case 0: {
        }
            break;
            
        case 1: {//我收到的红包
            MyRedViewController *myRedViewController = [[MyRedViewController alloc] initWithMark:1];
            [self.navigationController pushViewController:myRedViewController animated:YES];
        }
            break;
            
        case 2: {//我发出的红包
            MyRedViewController *myRedViewController = [[MyRedViewController alloc] initWithMark:2];
            [self.navigationController pushViewController:myRedViewController animated:YES];
        }
            break;
            
        case 3: {//我的打赏申请
            if ([UserInfoEngine getUserInfo].userType == 1) {
                //商家打赏申请
                MerchantsRewardApplyViewController *merchantsRewardApplyViewController = [[MerchantsRewardApplyViewController alloc] initWithInfoID:0];
                [self.navigationController pushViewController:merchantsRewardApplyViewController animated:YES];
            }else{
                //供货商打赏申请
                SupplierRewardApplyViewController *supplierRewardApplyViewController = [[SupplierRewardApplyViewController alloc] initWithInfoID:0];
                [self.navigationController pushViewController:supplierRewardApplyViewController animated:YES];
            }
        }
            break;
            
        case 4: {//资金流水
            AccountChangeViewController *accountChangeViewController = [[AccountChangeViewController alloc] init];
            [self.navigationController pushViewController:accountChangeViewController animated:YES];
        }
            break;
            
        case 5: {//余额充值
            RechargeViewController *rechargeViewController = [[RechargeViewController alloc] initWithRechargeSuccessedBlock:^{
                [self getUserAccountInfoWithUserID:[UserInfoEngine getUserInfo].userID];
            }];
            [self.navigationController pushViewController:rechargeViewController animated:YES];
        }
            break;
            
        case 6: {//充值记录
            RechargeRecordViewController *rechargeRecordViewController = [[RechargeRecordViewController alloc] init];
            [self.navigationController pushViewController:rechargeRecordViewController animated:YES];
        }
            break;
            
        case 7: {//提现
            if (_accountInfo.accountIsSetPayPassword) {
                WithdrawalViewController *withdrawalViewController = [[WithdrawalViewController alloc] initWithViewType:0 withdrawalSuccessedBlock:^{
                    [self getUserAccountInfoWithUserID:[UserInfoEngine getUserInfo].userID];
                }];
                [self.navigationController pushViewController:withdrawalViewController animated:YES];
            } else {
                SetWithdrawalPwdViewController *setWithdrawalPwdViewController = [[SetWithdrawalPwdViewController alloc] initWithViewType:0 setWithdrawalPwdSuccessed:^{
                    [self getUserAccountInfoWithUserID:[UserInfoEngine getUserInfo].userID];
                }];
                [self.navigationController pushViewController:setWithdrawalPwdViewController animated:YES];
            }
        }
            break;
            
        case 8: {//我的账户
            AccountManageViewController *accountManageViewController = [[AccountManageViewController alloc] initWithViewType:ViewTypeWithMyWallet accountInfo:nil selectedAccountSucceedBlock:nil deleteAccountSucceedBlock:nil];
            [self.navigationController pushViewController:accountManageViewController animated:YES];
        }
            break;
            
        default:
            break;
    }
}

/**
 我的钱包
 
 @return arrData
 */
- (NSMutableArray *)getSettingsData {
    MenuInfo *menuInfo0 = [[MenuInfo alloc] initWithMenuID:0 menuName:@"当前余额"];
    NSMutableArray *arr0 = [NSMutableArray arrayWithObjects:menuInfo0, nil];
    
    MenuInfo *menuInfo1 = [[MenuInfo alloc] initWithMenuID:1 menuName:@"我收到的红包"];
    MenuInfo *menuInfo2 = [[MenuInfo alloc] initWithMenuID:2 menuName:@"我发出的红包"];
    MenuInfo *menuInfo3 = [[MenuInfo alloc] initWithMenuID:3 menuName:@"我的打赏申请"];
    NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:menuInfo1, menuInfo2, menuInfo3, nil];
    
    MenuInfo *menuInfo4 = [[MenuInfo alloc] initWithMenuID:4 menuName:@"资金流水"];
    MenuInfo *menuInfo5 = [[MenuInfo alloc] initWithMenuID:5 menuName:@"余额充值"];
    MenuInfo *menuInfo6 = [[MenuInfo alloc] initWithMenuID:6 menuName:@"充值记录"];
    NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:menuInfo4, menuInfo5, menuInfo6, nil];
    
    MenuInfo *menuInfo7 = [[MenuInfo alloc] initWithMenuID:7 menuName:@"提现"];
    MenuInfo *menuInfo8 = [[MenuInfo alloc] initWithMenuID:8 menuName:@"我的账户"];
    NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:menuInfo7, menuInfo8, nil];
    
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:arr0, arr1, arr2, arr3, nil];
    return arr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
