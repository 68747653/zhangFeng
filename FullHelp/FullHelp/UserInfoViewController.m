//
//  UserInfoViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "UserInfoViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import <HHSoftFrameWorkKit/HHSoftPhotoPickerManager.h>
#import <HHSoftFrameWorkKit/HHSoftSandBox.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import "GlobalFile.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "UserCenterNetWorkEngine.h"
#import "MenuInfo.h"
#import "EditUserInfoViewController.h"
#import "EditTelphoneViewController.h"
#import "EditPasswordViewController.h"
#import "ApplyRedViewController.h"
#import "EditAddressViewController.h"
#import "AddressInfo.h"

@interface UserInfoViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic,strong) UIImageView *headerView;
@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) UserInfo *userInfo;
@property (nonatomic, strong) UIControl *hideDatePickerContorl;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIToolbar *dateToolbar;
@property (nonatomic, assign) CGFloat addressHeight;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息";
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    //调接口
    [self getUserInfoWithUserID:[UserInfoEngine getUserInfo].userID];
}

- (void)getUserInfoWithUserID:(NSInteger)userID {
    self.op = [[[UserCenterNetWorkEngine alloc] init] getUserInfoWithUserID:userID successed:^(NSInteger code, UserInfo *userInfo) {
        [self hideLoadingView];
        switch (code) {
            case 100: {
                _userInfo = userInfo;
                _arrData = [self getArrMenuDataWith:userInfo.userIsOpenRed];
                [self.view addSubview:self.dataTableView];
                if ([UserInfoEngine getUserInfo].userType == 2) {
                    self.dataTableView.tableFooterView = self.footerView;
                }
            }
                break;
                
            case 101: {
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    [self getUserInfoWithUserID:userID];
                }];
            }
                break;
                
            default: {
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    [self getUserInfoWithUserID:userID];
                }];
            }
                break;
        }
    } failed:^(NSError *error) {
        [self hideLoadingView];
        [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftUnableLinkNetWork] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
            [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
            [self getUserInfoWithUserID:userID];
        }];
    }];
}
#pragma mark --- 初始化dataTableView
- (HHSoftTableView *)dataTableView {
    if (_dataTableView == nil) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height - 64) dataSource:self delegate:self style:UITableViewStyleGrouped];
        _dataTableView.tableHeaderView = self.headerView;
    }
    return _dataTableView;
}
#pragma mark --- 初始化headerView
- (UIImageView *)headerView {
    if (_headerView == nil) {
        _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].width/2.0)];
        _headerView.image = [UIImage imageNamed:@"usercenter_headerimage"];
        _headerView.layer.masksToBounds = YES;
        _headerView.contentMode = UIViewContentModeScaleAspectFill;
        _headerView.userInteractionEnabled = YES;
        //头像
        UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(([HHSoftAppInfo AppScreen].width-[HHSoftAppInfo AppScreen].width/2.0/2)/2.0, ([HHSoftAppInfo AppScreen].width/2.0-[HHSoftAppInfo AppScreen].width/2.0/2)/2.0, [HHSoftAppInfo AppScreen].width/2.0/2, [HHSoftAppInfo AppScreen].width/2.0/2)];
        headImageView.layer.cornerRadius = headImageView.frame.size.width/2.0;
        headImageView.layer.masksToBounds = YES;
        headImageView.userInteractionEnabled = YES;
        headImageView.contentMode = UIViewContentModeScaleAspectFill;
        headImageView.tag = 258;
        [_headerView addSubview:headImageView];
        
        //手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeadImageViewClick)];
        [headImageView addGestureRecognizer:tap];
    }
    //头像
    UIImageView *headImageView = (UIImageView *)[_headerView viewWithTag:258];
    [headImageView sd_setImageWithURL:[NSURL URLWithString:_userInfo.userHeadImg] placeholderImage:[GlobalFile avatarImage]];
    
    return _headerView;
}
#pragma mark --- 添加尾部视图
- (UIView *)footerView {
    if (_footerView==nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 100)];
        _footerView.backgroundColor = [GlobalFile backgroundColor];
        //红包打赏
        UIButton *openRedButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, [HHSoftAppInfo AppScreen].width-20, 40)];
        openRedButton.backgroundColor = [GlobalFile themeColor];
        [openRedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        openRedButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        openRedButton.layer.cornerRadius = 3.0;
        openRedButton.layer.masksToBounds = YES;
        openRedButton.tag = 666;
        [_footerView addSubview:openRedButton];
        [openRedButton addTarget:self action:@selector(openRedButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIButton *openRedButton = (UIButton *)[_footerView viewWithTag:666];
    if (_userInfo.userIsOpenRed) {
        [openRedButton setTitle:@"关闭申请红包打赏" forState:UIControlStateNormal];
    } else {
        [openRedButton setTitle:@"开通申请红包打赏" forState:UIControlStateNormal];
    }
    return _footerView;
}

#pragma mark --- 点击红包打赏按钮
- (void)openRedButtonPress:(UIButton *)sender {
    if (!_userInfo.userRealName.length || !_userInfo.userMerchantName.length || !_userInfo.userMerchantAddressInfo.addressDetail.length) {
        [self showErrorView:@"请先完善资料"];
        return;
    }
    if (_userInfo.userIsOpenRed) {//关闭申请打赏红包
        [self showWaitView:@"请稍等..."];
        self.view.userInteractionEnabled = NO;
        [self userColseRedWithUserID:_userInfo.userID sender:sender];
    } else {//开通申请打赏红包
        ApplyRedViewController *applyRedViewController = [[ApplyRedViewController alloc] initWithUserApplyOpenRedBlock:^{
            _userInfo.userIsOpenRed = 1;
            _arrData = [self getArrMenuDataWith:1];
            [_dataTableView reloadData];
            [sender setTitle:@"关闭申请红包打赏" forState:UIControlStateNormal];
        } viewType:OpenRedViewType];
        [self.navigationController pushViewController:applyRedViewController animated:YES];
    }
}

- (void)userColseRedWithUserID:(NSInteger)userID sender:(UIButton *)sender {
    self.op = [[[UserCenterNetWorkEngine alloc] init] userColseRedWithUserID:userID successed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        if (code == 100) {
            [self showSuccessView:@"关闭申请打赏红包成功"];
            _userInfo.userIsOpenRed = 0;
            _arrData = [self getArrMenuDataWith:0];
            [_dataTableView reloadData];
            [sender setTitle:@"开通申请红包打赏" forState:UIControlStateNormal];
        } else if (code == 101) {
            [self showErrorView:@"关闭申请打赏红包失败"];
        } else {
            [self showErrorView:@"网络连接异常，请稍后重试"];
        }
    } failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络连接失败，请稍后重试"];
    }];
}
#pragma mark --- TableView的代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arrData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_arrData[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuInfo *menuInfo = [_arrData[indexPath.section] objectAtIndex:indexPath.row];
    if (menuInfo.menuID == 6) {
        NSString *address = [NSString stringWithFormat:@"%@%@", [NSString stringByReplaceNullString:_userInfo.userMerchantAddressInfo.addressDetail], [NSString stringByReplaceNullString:_userInfo.userMerchantAddressInfo.addressHouseNumber]];
        _addressHeight = [address boundingRectWithfont:[UIFont systemFontOfSize:12.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-151.5, CGFLOAT_MAX)].height+28;
        return _addressHeight;
    }
    return 44.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuInfo *menuInfo = [_arrData[indexPath.section] objectAtIndex:indexPath.row];
    if (menuInfo.menuID == 6) {
        static NSString *string = @"AddressIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
            
            HHSoftLabel *label = [[HHSoftLabel alloc] initWithFrame:CGRectMake(17.5, 0, 75, 44) fontSize:14.0 text:menuInfo.menuName textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
            label.tag = 6002;
            [cell addSubview:label];
            
            HHSoftLabel *addressLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(91.5, 0, [HHSoftAppInfo AppScreen].width-151.5, 44) fontSize:12.0 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
            [cell addSubview:addressLabel];
            addressLabel.tag = 5551;
            
            cell.selectionStyle = UITableViewCellAccessoryNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UIImageView *addressImageView = [[UIImageView alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width-50, 10, 20, 20/1.08)];
            addressImageView.image = [UIImage imageNamed:@"address"];
            addressImageView.tag = 540;
            [cell addSubview:addressImageView];
            
        }
        HHSoftLabel *label = [cell viewWithTag:6002];
        HHSoftLabel *addressLabel = [cell viewWithTag:5551];
        UIImageView *imageView = [cell viewWithTag:540];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:menuInfo.menuName];
        [attr addAttribute:NSForegroundColorAttributeName value:[GlobalFile themeColor] range:NSMakeRange(attr.length-1, 1)];
        label.attributedText = attr;
        NSString *addressStr = [NSString stringWithFormat:@"%@%@", [NSString stringByReplaceNullString:_userInfo.userMerchantAddressInfo.addressDetail], [NSString stringByReplaceNullString:_userInfo.userMerchantAddressInfo.addressHouseNumber]];
        addressLabel.text = addressStr;
        label.y = (_addressHeight-44)/2;
        addressLabel.height = _addressHeight;
        imageView.y = (_addressHeight-20/1.08)/2;
        return cell;
    }
    static NSString *strCell = @"UserInfoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strCell];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.textColor = [HHSoftAppInfo defaultDeepSystemColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
        cell.detailTextLabel.textColor = [HHSoftAppInfo defaultLightSystemColor];
    }
    if (menuInfo.menuID == 3 || menuInfo.menuID == 4) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = menuInfo.menuName;
    if (menuInfo.menuID == 1 || menuInfo.menuID == 5) {
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:menuInfo.menuName];
        [attr addAttribute:NSForegroundColorAttributeName value:[GlobalFile themeColor] range:NSMakeRange(attr.length-1, 1)];
        cell.textLabel.attributedText = attr;
    }
    switch (menuInfo.menuID) {
        case 0: {//昵称
            cell.detailTextLabel.text = [NSString stringByReplaceNullString:_userInfo.userNickName];
        }
            break;
            
        case 1: {//姓名
            cell.detailTextLabel.text = [NSString stringByReplaceNullString:_userInfo.userRealName];
        }
            break;
            
        case 2: {//生日
            cell.detailTextLabel.text = [NSString stringByReplaceNullString:_userInfo.userBirthday];
        }
            break;
            
        case 3: {//地区
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@%@", [NSString stringByReplaceNullString:_userInfo.userProvinceName], [NSString stringByReplaceNullString:_userInfo.userCityName], [NSString stringByReplaceNullString:_userInfo.userDistrictName]];
        }
            break;
            
        case 4: {//行业
            cell.detailTextLabel.text = [NSString stringByReplaceNullString:_userInfo.userIndustryName];
        }
            break;
            
        case 5: {//店名
            cell.detailTextLabel.text = [NSString stringByReplaceNullString:_userInfo.userMerchantName];
        }
            break;
            
        case 7: {//修改手机号
            cell.detailTextLabel.text = [NSString stringByReplaceNullString:_userInfo.userLoginName];
        }
            break;
            
        case 8:  //修改密码
        case 9: {//设置打赏红包
            cell.detailTextLabel.text = @"";
        }
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MenuInfo *menuInfo = [_arrData[indexPath.section] objectAtIndex:indexPath.row];
    switch (menuInfo.menuID) {
        case 0:  //修改昵称
        case 1:  //修改姓名
        case 5: {//修改店名
            NSString *userInfoNameStr;
            NSInteger mark = 0;
            if (menuInfo.menuID == 0) {
                mark = 2;
                userInfoNameStr = _userInfo.userNickName;
            } else if (menuInfo.menuID == 1) {
                mark = 3;
                userInfoNameStr = _userInfo.userRealName;
            } else if (menuInfo.menuID == 5) {
                mark = 5;
                userInfoNameStr = _userInfo.userMerchantName;
            }
            EditUserInfoViewController *editUserInfoViewController = [[EditUserInfoViewController alloc] initWithUserInfoStr:userInfoNameStr editUserInfoBlock:^(NSString *userInfoStr) {
                NSIndexPath *indexPath;
                if (menuInfo.menuID == 0) {
                    _userInfo.userNickName = userInfoStr;
                    indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                } else if (menuInfo.menuID == 1) {
                    _userInfo.userRealName = userInfoStr;
                    indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
                } else if (menuInfo.menuID == 5) {
                    _userInfo.userMerchantName = userInfoStr;
                    indexPath = [NSIndexPath indexPathForRow:2 inSection:1];
                }
                [_dataTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            } mark:mark];
            [self.navigationController pushViewController:editUserInfoViewController animated:YES];
        }
            break;
            
        case 2: {//生日
            self.hideDatePickerContorl.frame = CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height);
            [UIView animateWithDuration:0.3 animations:^{
                self.dateToolbar.frame = CGRectMake(0, [HHSoftAppInfo AppScreen].height - 194, [HHSoftAppInfo AppScreen].width, 44);
                self.datePicker.frame = CGRectMake(0, [HHSoftAppInfo AppScreen].height - 150, [HHSoftAppInfo AppScreen].width, 150);
            }];
        }
            break;
            
        case 6: {//地址
            EditAddressViewController *editAddressViewController = [[EditAddressViewController alloc] initWithAddressInfo:_userInfo.userMerchantAddressInfo editAddressBlock:^(AddressInfo *addressInfo) {
                _userInfo.userMerchantAddressInfo = addressInfo;
                [_dataTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:3 inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
            } viewType:EditAddressType];
            [self.navigationController pushViewController:editAddressViewController animated:YES];
        }
            break;
            
        case 7: {//修改手机号
            EditTelphoneViewController *editTelViewController = [[EditTelphoneViewController alloc] initWithEditTelphoneViewType:VerifyTelType];
            [self.navigationController pushViewController:editTelViewController animated:YES];
        }
            break;
            
        case 8: {//修改密码
            EditPasswordViewController *editPasswordViewController = [[EditPasswordViewController alloc] init];
            [self.navigationController pushViewController:editPasswordViewController animated:YES];
        }
            break;
            
        case 9: {//设置红包打赏
            ApplyRedViewController *applyRedViewController = [[ApplyRedViewController alloc] initWithUserApplyOpenRedBlock:nil viewType:SetRedViewType];
            [self.navigationController pushViewController:applyRedViewController animated:YES];
        }
            break;
            
        default:
            break;
    }
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
        self.datePicker.frame = CGRectMake(0, [HHSoftAppInfo AppScreen].height+44, [HHSoftAppInfo AppScreen].width, 150);
    }];
}

/**
 初始化UIDatePicker

 @return UIDatePicker
 */
- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, [HHSoftAppInfo AppScreen].height - 150, [HHSoftAppInfo AppScreen].width, 150)];
        //显示日期和时间。|UIDatePickerModeDate:不显示时间.|UIDatePickerModeTime:不显示日期。|UIDatePickerModeCountDownTimer:仅显示为倒计时器。|UIDatePickerModeDateAndTime:即显示时间又显示日期
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:0];
        //_datePicker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_cn"];//中文
        NSDateFormatter *showFormatter = [[NSDateFormatter alloc] init];
        showFormatter.dateFormat = @"yyyy-MM-dd";
        _datePicker.backgroundColor = [UIColor whiteColor];
        [[UIApplication sharedApplication].keyWindow addSubview:_datePicker];
    }
    return _datePicker;
}

- (UIToolbar *)dateToolbar {
    if (!_dateToolbar) {
        _dateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, [HHSoftAppInfo AppScreen].height - 194, [HHSoftAppInfo AppScreen].width, 44)];
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
    NSDateFormatter *showFormatter = [[NSDateFormatter alloc] init];
    showFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = _datePicker.date;
    NSString *showString = [showFormatter stringFromDate:date];
    [self showWaitView:@"请稍等..."];
    self.view.userInteractionEnabled = NO;
    //调接口
    [self editUserInfoWithUserID:[UserInfoEngine getUserInfo].userID mark:4 userInfoStr:showString];
}

- (void)cancleItemPressed {
    [self hideDatePickerContorlPress];
}

#pragma mark --- 修改头像按钮点击事件
- (void)tapHeadImageViewClick {
    [[HHSoftPhotoPickerManager shared] showRealityDrawingActionSheetInView:self.view fromController:self compressImageWidth:[HHSoftAppInfo AppScreen].width compressImageHeight:[HHSoftAppInfo AppScreen].width/3*2 compressclarity:1000.0 unionCompletion:^(UIImage *compressImage, UIImage *sourceImage) {
        //把图片数据存储到document
        NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/headimage.png"];
        [UIImagePNGRepresentation(compressImage)  writeToFile:pngPath atomically:YES];
        //取出图片的全路径
        NSString *documentsDirectory = [HHSoftSandBox PathOfDocuments];
        NSString *filePath =[documentsDirectory stringByAppendingPathComponent:@"headimage.png"];
        [self showWaitView:@"请稍等..."];
        self.view.userInteractionEnabled = NO;
        //调修改头像接口
        [self editUserInfoWithUserID:[UserInfoEngine getUserInfo].userID mark:1 userInfoStr:filePath];
    } cancelBlock:^{
        
    }];
}

#pragma mark --- 修改个人信息
- (void)editUserInfoWithUserID:(NSInteger)userID mark:(NSInteger)mark userInfoStr:(NSString *)userInfoStr {
    self.op = [[[UserCenterNetWorkEngine alloc] init] editUserInfoWithUserID:userID mark:mark userInfoStr:userInfoStr successed:^(NSInteger code, NSString *userHeadImg) {
        self.view.userInteractionEnabled = YES;
        switch (code) {//103：图片上传失败 104 ：未上传头像 ，105：该商家已存在
            case 100: {
                [self showSuccessView:@"修改成功"];
                if (mark == 1) {//修改头像
                    _userInfo.userHeadImg = userHeadImg;
                    [self.headerView reloadInputViews];
                } else if (mark == 4) {//出生日期
                    _userInfo.userBirthday = userInfoStr;
                    [_dataTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                }
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
        [self showErrorView:@"网络连接失败，请稍后重试"];
    }];
}

/**
 获取菜单数据
 
 @param userIsOpenRed 是否开通红包申请打赏【0：否 1：是】
 
 @return arr
 */
- (NSMutableArray *)getArrMenuDataWith:(NSInteger)userIsOpenRed {
    MenuInfo *menuInfo0 = [[MenuInfo alloc] initWithMenuID:0 menuName:@"昵称"];
    MenuInfo *menuInfo1 = [[MenuInfo alloc] initWithMenuID:1 menuName:@"姓名 *"];
    MenuInfo *menuInfo2 = [[MenuInfo alloc] initWithMenuID:2 menuName:@"生日"];
    NSMutableArray *arr0 = [NSMutableArray arrayWithObjects:menuInfo0, menuInfo1, menuInfo2, nil];
    
    MenuInfo *menuInfo3 = [[MenuInfo alloc] initWithMenuID:3 menuName:@"地区"];
    MenuInfo *menuInfo4 = [[MenuInfo alloc] initWithMenuID:4 menuName:@"行业"];
    MenuInfo *menuInfo5 = [[MenuInfo alloc] initWithMenuID:5 menuName:@"店名 *"];
    MenuInfo *menuInfo6 = [[MenuInfo alloc] initWithMenuID:6 menuName:@"地址 *"];
    NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:menuInfo3, menuInfo4, menuInfo5, menuInfo6, nil];
    
    MenuInfo *menuInfo7 = [[MenuInfo alloc] initWithMenuID:7 menuName:@"手机号"];
    MenuInfo *menuInfo8 = [[MenuInfo alloc] initWithMenuID:8 menuName:@"修改密码"];
    MenuInfo *menuInfo9 = [[MenuInfo alloc] initWithMenuID:9 menuName:@"设置红包打赏"];
    NSMutableArray *arr2;
    if (userIsOpenRed) {
        arr2 = [NSMutableArray arrayWithObjects:menuInfo7, menuInfo8, menuInfo9, nil];
    } else {
        arr2 = [NSMutableArray arrayWithObjects:menuInfo7, menuInfo8, nil];
    }
    
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:arr0, arr1, arr2, nil];
    return arr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
