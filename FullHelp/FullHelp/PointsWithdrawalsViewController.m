//
//  PointsWithdrawalsViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/9.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "PointsWithdrawalsViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import "GlobalFile.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "UserCenterNetWorkEngine.h"

@interface PointsWithdrawalsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, assign) NSInteger points;
@property (nonatomic, strong) UITextField *pointsTextField;
@property (nonatomic, strong) UIView *footerView;

@end

@implementation PointsWithdrawalsViewController

- (instancetype)initWithPoints:(NSInteger)points {
    if (self = [super init]) {
        self.points = points;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"金币提现";
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    [self.view addSubview:self.dataTableView];
}

#pragma mark --- 初始化dataTableView
- (HHSoftTableView *)dataTableView {
    if (_dataTableView == nil) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStyleGrouped];
        _dataTableView.tableFooterView = self.footerView;
    }
    return _dataTableView;
}

#pragma mark --- 添加尾部视图
- (UIView *)footerView {
    if (_footerView==nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 100)];
        _footerView.backgroundColor = [GlobalFile backgroundColor];
        //提交
        UIButton *commitButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, [HHSoftAppInfo AppScreen].width-20, 40)];
        commitButton.backgroundColor = [GlobalFile themeColor];
        [commitButton setTitle:@"提交" forState:UIControlStateNormal];
        [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        commitButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        commitButton.layer.cornerRadius = 3.0;
        commitButton.layer.masksToBounds = YES;
        [commitButton addTarget:self action:@selector(commitButtonPress) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:commitButton];
        
    }
    return _footerView;
}

#pragma mark --- TableView的代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 30.0;
    }
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 30)];
        HHSoftLabel *promptLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 0, [HHSoftAppInfo AppScreen].width - 30, 30) fontSize:12.0 text:@"*200金币可以提现1元" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
        [headerView addSubview:promptLabel];
        return headerView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section) {
        static NSString *strCell = @"PointsInfoCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            HHSoftLabel *nameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 0, 50, 44) fontSize:15.0 text:@"金币：" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
            [cell addSubview:nameLabel];
            //输入框
            _pointsTextField = [[UITextField alloc] initWithFrame:CGRectMake(70, 0, [HHSoftAppInfo AppScreen].width-140, 44)];
            _pointsTextField.textColor = [HHSoftAppInfo defaultDeepSystemColor];
            _pointsTextField.font = [UIFont systemFontOfSize:14.0];
            [cell addSubview:_pointsTextField];

            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_pointsTextField.frame)+1, 0, 1, 44)];
            lineView.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
            [cell addSubview:lineView];
            
            HHSoftLabel *countLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_pointsTextField.frame)+1, 0, 69, 44) fontSize:15.0 text:@"x200" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
            [cell addSubview:countLabel];
        }
        _pointsTextField.placeholder = @"请输入提现金币";
        _pointsTextField.keyboardType = UIKeyboardTypeNumberPad;
        return cell;
    } else {
        static NSString *strCell = @"PointsCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:14.0];
            cell.textLabel.textColor = [HHSoftAppInfo defaultDeepSystemColor];
        }
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"可提现金币：%@", @(_points)]];
        [attr addAttribute:NSForegroundColorAttributeName value:[GlobalFile themeColor] range:NSMakeRange(6, attr.length - 6)];
        cell.textLabel.attributedText = attr;
        return cell;
    }
}

#pragma mark --- 点击提交按钮
- (void)commitButtonPress {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (![_pointsTextField.text integerValue] || !_pointsTextField.text.length) {
        [self showErrorView:@"请输入提现金币"];
        return;
    }
    if ([_pointsTextField.text integerValue]*200 > _points) {
        [self showErrorView:@"可提现金币不足"];
        return;
    }
    [self showWaitView:@"请稍等..."];
    self.view.userInteractionEnabled = NO;
    [self addPointsWithdrawalsWithUserID:[UserInfoEngine getUserInfo].userID points:[_pointsTextField.text integerValue]*200];
}

- (void)addPointsWithdrawalsWithUserID:(NSInteger)userID points:(NSInteger)points {
    self.op = [[[UserCenterNetWorkEngine alloc] init] addPointsWithdrawalsWithUserID:userID points:(NSInteger)points successed:^(NSInteger code) {
            self.view.userInteractionEnabled = YES;
            switch (code) {
                case 100: {
                    [self.navigationController popViewControllerAnimated:YES];
                    [SVProgressHUD showSuccessWithStatus:@"提现成功"];
                }
                    break;

                case 101: {
                    [self showErrorView:@"提现失败"];
                }
                    break;
                    
                case 103: {
                    [self showErrorView:@"金币不足"];
                }
                    break;

                default: {
                    [self showErrorView:@"网络连接异常，请稍后重试"];
                }
                    break;
            }
        } failed:^(NSError *error) {
            self.view.userInteractionEnabled = YES;
            [self showErrorView:@"网络连接异常,请稍后重试"];
        }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
