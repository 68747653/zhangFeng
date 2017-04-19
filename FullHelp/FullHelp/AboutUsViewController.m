//
//  AboutUsViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/8.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AboutUsViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import <HHSoftFrameWorkKit/UIDevice+DeviceInfo.h>
#import "MenuInfo.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "GlobalFile.h"
#import "WKWebViewController.h"
#import "HHSoftShareTool.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "UserCenterNetWorkEngine.h"

@interface AboutUsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *headerView, *footerView;
@property (nonatomic, strong) UIImageView *logoImgView;
@property (nonatomic, strong) HHSoftLabel *nameVersionLabel;
@property (nonatomic, strong) HHSoftLabel *chineseCopyrightLabel;
@property (nonatomic, strong) HHSoftLabel *englishCopyrightLabel;
@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *arrData;

@end

@implementation AboutUsViewController

#pragma mark --- 视图加载完成
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    self.navigationItem.title = @"关于我们";
    [self.navigationItem setBackBarButtonItemTitle:@""];
    [self loadData];
}
#pragma mark --- 数据加载
- (void)loadData {
    self.arrData = [self getArrMenuData];
    self.dataTableView.tableHeaderView = self.headerView;
    self.dataTableView.tableFooterView = self.footerView;
    _nameVersionLabel.text = [NSString stringWithFormat:@"%@ %@", [NSString stringByReplaceNullString:[HHSoftAppInfo AppName]], [HHSoftAppInfo AppVersion]];
}
#pragma mark --- 初始化界面
- (HHSoftTableView *)dataTableView {
    if (!_dataTableView) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height - 64) dataSource:self delegate:self style:UITableViewStylePlain];
        [self.view addSubview:_dataTableView];
    }
    return _dataTableView;
}
#pragma mark --- 头部视图
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].width * 2 / 3)];
        //LOGO背景
        _logoImgView = [[UIImageView alloc]initWithFrame:CGRectMake(([HHSoftAppInfo AppScreen].width - 80)/ 2 , (_headerView.frame.size.height - 80) / 2 , 80, 80)];
        _logoImgView.layer.cornerRadius = 5.f;
        _logoImgView.layer.masksToBounds = YES;
        _logoImgView.image = [UIImage imageNamed:@"Icon.png"];
        [_headerView addSubview:_logoImgView];
        //名称 版本
        _nameVersionLabel = [[HHSoftLabel alloc]initWithFrame:CGRectMake(0, (_headerView.frame.size.height - 80) / 2 + 90, [HHSoftAppInfo AppScreen].width, 20) fontSize:16.f text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
        [_headerView addSubview:_nameVersionLabel];
    }
    return _headerView;
}
#pragma mark --- 底部视图
- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height - 64 - [HHSoftAppInfo AppScreen].width * 2 / 3 - 44*3)];
        _chineseCopyrightLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(0, _footerView.frame.size.height - 70, [HHSoftAppInfo AppScreen].width, 20) fontSize:13.0 text:@"郑州鼎利相助网络科技有限公司版权所有" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
        [_footerView addSubview:_chineseCopyrightLabel];
        _englishCopyrightLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(0, _footerView.frame.size.height - 40, [HHSoftAppInfo AppScreen].width, 20) fontSize:13.0 text:@"Copyright©All Rights Reserved" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
        [_footerView addSubview:_englishCopyrightLabel];
    }
    return _footerView;
}
#pragma mark --- UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuInfo *menuInfo = self.arrData[indexPath.row];
    static NSString *aboutIdentifier = @"AboutInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:aboutIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aboutIdentifier];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.text = menuInfo.menuName;
    cell.textLabel.textColor = [HHSoftAppInfo defaultDeepSystemColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma mark --- 点击cell的处理
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MenuInfo *menuInfo = self.arrData[indexPath.row];
    switch (menuInfo.menuID) {
        case 0: {//版本更新
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[GlobalFile uploadSoftVersion]]];
        }
            break;
            
        case 1: {//关于
            WKWebViewController *wkWebViewController = [[WKWebViewController alloc] initWithUrl:@"" WkWebType:WKWebTypeWithAboutOur MessageTitle:@"关于我们"];
            [self.navigationController pushViewController:wkWebViewController animated:YES];
        }
            break;
            
        case 3: {//使用帮助
            WKWebViewController *wkWebViewController = [[WKWebViewController alloc] initWithUrl:@"" WkWebType:WKWebTypeWithHelp MessageTitle:@"使用帮助"];
            [self.navigationController pushViewController:wkWebViewController animated:YES];
        }
            break;
            
        case 2: {//分享
            self.view.userInteractionEnabled = NO;
            [self getShareAddress];
        }
            break;
            
        case 4: {//去评分
            [UIDevice openSafari:[GlobalFile uploadAppStorePath]];
        }
            
        default:
            break;
    }
}

#pragma mark --- 分享
- (void)getShareAddress {
    self.op = [[[UserCenterNetWorkEngine alloc] init] getShareAddressSuccessed:^(NSInteger code, NSString *shareAddress) {
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100: {
                //分享
                NSString *title = @"看不看广告都有红包";
                NSString *description = @"这里到处都是红包，十几种红包无偿放送，看不看广告，现金红包都不停，红包即可提现..... ";
                UIImage *image = [UIImage imageNamed:@"Icon60"];
                NSString *linkUrl = shareAddress;
                SharePlatFormType sharePlatFormType;
                if ([WXApi isWXAppInstalled] && [TencentOAuth iphoneQQInstalled]) {
                    sharePlatFormType = SharePlatFormSinaWeiBo | SharePlatFormWXFriend | SharePlatFormWXSpace | SharePlatFormQQFriend | SharePlatFormQQSpace;
                } else if ([TencentOAuth iphoneQQInstalled]) {
                    sharePlatFormType = SharePlatFormSinaWeiBo | SharePlatFormQQFriend | SharePlatFormQQSpace;
                } else if ([WXApi isWXAppInstalled]) {
                    sharePlatFormType = SharePlatFormSinaWeiBo | SharePlatFormWXFriend | SharePlatFormWXSpace;
                } else {
                    sharePlatFormType = SharePlatFormSinaWeiBo;
                }
                [self showShareViewWithShareType:sharePlatFormType shareButtonPressed:^(SharePlatFormType sharePlatFormType) {
                    [[HHSoftShareTool sharedHHSoftShareTool] shareLinkContentWithTitle:title description:description thumgImage:image linkUrl:linkUrl shareplatForm:sharePlatFormType shareResponse:^(ShareResponseCode responseCode, SharePlatFormType sharePlatFormType) {
                        if (responseCode == ShareSuccess) {
                            [self showSuccessView:@"分享成功"];
                        } else if (responseCode == ShareError) {
                            [self showErrorView:@"分享错误"];
                        } else if (responseCode == ShareCancel) {
                            [self showErrorView:@"分享取消"];
                        } else if (responseCode == ShareFail) {
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
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络连接失败，请稍后重试"];
    }];
}

- (NSMutableArray *)getArrMenuData {
    MenuInfo *menuInfoScore = [[MenuInfo alloc]initWithMenuID:4 menuName:@"去评分"];
//    MenuInfo *menuInfoGrade = [[MenuInfo alloc]initWithMenuID:0 menuName:@"版本更新"];
    MenuInfo *menuInfoAbout = [[MenuInfo alloc]initWithMenuID:1 menuName:@"关于我们"];
//    MenuInfo *menuInfoHelp = [[MenuInfo alloc]initWithMenuID:3 menuName:@"使用帮助"];
    MenuInfo *menuInfoShare = [[MenuInfo alloc]initWithMenuID:2 menuName:[NSString stringWithFormat:@"分享%@", [NSString stringByReplaceNullString:[HHSoftAppInfo AppName]]]];
    NSMutableArray *arr =[NSMutableArray arrayWithObjects:menuInfoScore, menuInfoAbout, menuInfoShare, nil];
    return arr;
}
#pragma mark --- DidReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
