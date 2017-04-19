//
//  EditUserInfoViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "EditUserInfoViewController.h"
#import "GlobalFile.h"
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "UserCenterNetWorkEngine.h"

@interface EditUserInfoViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic,strong) UITextField *nameTextField;
@property (nonatomic,strong) EditUserInfoBlock editUserInfoBlock;
@property (nonatomic,copy ) NSString *userInfoStr;
@property (nonatomic,strong) UIView *footerView;
@property (nonatomic, assign) NSInteger mark;

@end

@implementation EditUserInfoViewController

- (instancetype)initWithUserInfoStr:(NSString *)userInfoStr editUserInfoBlock:(EditUserInfoBlock)editUserInfoBlock mark:(NSInteger)mark {
    if (self = [super init]) {
        self.userInfoStr = userInfoStr;
        self.editUserInfoBlock = editUserInfoBlock;
        self.mark = mark;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    if (_mark == 2) {
        self.navigationItem.title = @"昵称";
    } else if (_mark == 3) {
        self.navigationItem.title = @"姓名";
    } else if (_mark == 5) {
        self.navigationItem.title = @"店名";
    }
    [self.navigationItem setBackBarButtonItemTitle:@""];
    [self.view addSubview:self.dataTableView];
}
#pragma mark --- 初始化TableView
- (HHSoftTableView *)dataTableView {
    if (_dataTableView == nil) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStyleGrouped separatorColor:[GlobalFile backgroundColor]];
        _dataTableView.tableFooterView = [self footerView];
    }
    return _dataTableView;
}
#pragma mark -- 初始化footerView
- (UIView *)footerView {
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 100)];
        //确定修改
        UIButton *sureEditButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 40, [HHSoftAppInfo AppScreen].width-20, 40)];
        [sureEditButton setBackgroundColor:[GlobalFile themeColor]];
        [sureEditButton setTitle:@"确定" forState:UIControlStateNormal];
        [sureEditButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureEditButton.layer.cornerRadius = 3.0;
        sureEditButton.layer.masksToBounds = YES;
        [_footerView addSubview:sureEditButton];
        [sureEditButton addTarget:self action:@selector(sureEditUserInfoButtonPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}
#pragma mark --- TableView的代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *strCell = @"EditUserInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        //输入框
        _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, [HHSoftAppInfo AppScreen].width-20, 44)];
        _nameTextField.textAlignment = NSTextAlignmentLeft;
        _nameTextField.font = [UIFont systemFontOfSize:14.0];
        _nameTextField.textColor = [HHSoftAppInfo defaultDeepSystemColor];
        if (_mark == 2) {
            _nameTextField.placeholder = @"请输入昵称";
        } else if (_mark == 3) {
            _nameTextField.placeholder = @"请输入姓名";
        } else if (_mark == 5) {
            _nameTextField.placeholder = @"请输入店名";
        }
        _nameTextField.text = _userInfoStr;
//        _nameTextField.delegate = self;
        //        [_nameTextField becomeFirstResponder];
        [cell addSubview:_nameTextField];
    }
    return cell;
}
#pragma mark --- 修改按钮点击事件
- (void)sureEditUserInfoButtonPress {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (_nameTextField.text.length == 0) {
        if (_mark == 2) {
            [self showErrorView:@"请输入昵称"];
        } else if (_mark == 3) {
            [self showErrorView:@"请输入姓名"];
        } else if (_mark == 5) {
            [self showErrorView:@"请输入店名"];
        }
        return;
    }
    self.view.userInteractionEnabled = NO;
    [self showWaitView:@"请稍等..."];
    //调接口
    [self editUserInfoWithUserID:[UserInfoEngine getUserInfo].userID mark:_mark userInfoStr:_nameTextField.text];
}

#pragma mark --- 修改个人信息
- (void)editUserInfoWithUserID:(NSInteger)userID mark:(NSInteger)mark userInfoStr:(NSString *)userInfoStr {
    self.op = [[[UserCenterNetWorkEngine alloc] init] editUserInfoWithUserID:userID mark:mark userInfoStr:userInfoStr successed:^(NSInteger code, NSString *userHeadImg) {
        self.view.userInteractionEnabled = YES;
        switch (code) {//103：图片上传失败 104 ：未上传头像 ，105：该商家已存在
            case 100: {
                [self showSuccessView:@"修改成功"];
                if (_editUserInfoBlock) {
                    _editUserInfoBlock(userInfoStr);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
                break;
                
            case 101: {
                [self showErrorView:@"修改失败"];
            }
                break;
                
            case 103: {
                [self showErrorView:@"图片上传失败"];
            }
                break;
                
            case 104: {
                [self showErrorView:@"未上传头像"];
            }
                break;
                
            case 105: {
                [self showErrorView:@"该商家已存在"];
            }
                break;
                
            default: {
                [self showErrorView:@"网络接连异常，请稍后再试"];
            }
                break;
        }
    } failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络接连异常，请稍后再试"];
    }];
}
#pragma mark --- UITextViewDelegate
- (void)textFieldTextDidChange:(NSNotification *)noti {
    UITextField *field = noti.object;
    NSString *text = field.text;
    NSInteger length = 16-text.length;
    if (field.markedTextRange == nil) {
        if (length < 0) {
            [self showErrorView:@"最多输入16个字"];
            field.text=[text substringToIndex:16];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
