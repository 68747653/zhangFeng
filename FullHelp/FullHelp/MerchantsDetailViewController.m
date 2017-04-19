//
//  MerchantsDetailViewController.m
//  FullHelp
//
//  Created by hhsoft on 17/2/14.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "MerchantsDetailViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "UserCenterNetWorkEngine.h"
#import "MenuInfo.h"
#import "AddressInfo.h"
#import "AdvertDetailLocationViewController.h"

@interface MerchantsDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,strong) UserInfo *userInfo;
@property (nonatomic,assign) NSInteger merchantUserID;
@end

@implementation MerchantsDetailViewController
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(instancetype)initWithMerchantUserID:(NSInteger)merchantUserID{
    if(self = [super init]){
        _merchantUserID = merchantUserID;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商家信息";
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    //调接口
    [self getUserInfoWithUserID:_merchantUserID];
}
- (void)getUserInfoWithUserID:(NSInteger)userID {
    self.op = [[[UserCenterNetWorkEngine alloc] init] getUserInfoWithUserID:userID successed:^(NSInteger code, UserInfo *userInfo) {
        [self hideLoadingView];
        switch (code) {
            case 100: {
                _userInfo = userInfo;
                _arrData = [self getArrMenuData];
                [self.view addSubview:self.dataTableView];
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
    }
    return _dataTableView;
}
#pragma mark --- TableView的代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strCell = @"strCell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:strCell];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    MenuInfo *menuInfo = _arrData[indexPath.row];
    cell.textLabel.text = menuInfo.menuName;
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.textColor = [HHSoftAppInfo defaultDeepSystemColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
    cell.detailTextLabel.textColor = [HHSoftAppInfo defaultLightSystemColor];
    
    switch (menuInfo.menuID) {
        case 0:{
            //姓名
            cell.detailTextLabel.text = [NSString stringByReplaceNullString:_userInfo.userRealName];
        }
            break;
        case 1:{
            //店名
            cell.detailTextLabel.text = [NSString stringByReplaceNullString:_userInfo.userMerchantName];
        }
            break;
        case 2:{
            //地址
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@", [NSString stringByReplaceNullString:_userInfo.userMerchantAddressInfo.addressDetail], [NSString stringByReplaceNullString:_userInfo.userMerchantAddressInfo.addressHouseNumber]];
            NSTextAttachment *atta = [[NSTextAttachment alloc] init];
            atta.image = [UIImage imageNamed:@"usercenter_address"];
            atta.bounds = CGRectMake(2, -2, 15, 15);
            NSAttributedString *attri = [NSAttributedString attributedStringWithAttachment:atta];
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:cell.detailTextLabel.text];
            [attr appendAttributedString:attri];
            [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(0, attr.length)];
            cell.detailTextLabel.attributedText = attr;
        }
            break;
        case 3:{
            //手机号
            cell.detailTextLabel.text = [NSString stringByReplaceNullString:_userInfo.userLoginName];
        }
            break;
        default:
            break;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuInfo *menuInfo = _arrData[indexPath.row];
    if (menuInfo.menuID == 2) {
        AdvertDetailLocationViewController *advertDetailLocationViewController = [[AdvertDetailLocationViewController alloc] initWithLatitude:_userInfo.userMerchantAddressInfo.addressLatitude Longitude:_userInfo.userMerchantAddressInfo.addressLongitude];
        [self.navigationController pushViewController:advertDetailLocationViewController animated:YES];
    }
}
#pragma mark -- 初始化数据
- (NSMutableArray *)getArrMenuData{
    MenuInfo *menuInfo0 = [[MenuInfo alloc] initWithMenuID:0 menuName:@"姓名"];
    MenuInfo *menuInfo1 = [[MenuInfo alloc] initWithMenuID:1 menuName:@"店名"];
    MenuInfo *menuInfo2 = [[MenuInfo alloc] initWithMenuID:2 menuName:@"地址"];
    MenuInfo *menuInfo3 = [[MenuInfo alloc] initWithMenuID:3 menuName:@"手机号"];
    
    return [NSMutableArray arrayWithObjects:menuInfo0, menuInfo1, menuInfo2,menuInfo3, nil];
}



@end
