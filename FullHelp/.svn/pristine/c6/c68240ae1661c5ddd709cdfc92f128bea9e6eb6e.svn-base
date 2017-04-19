//
//  UserCenterViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/4.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "UserCenterViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/HHSoftButton.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import "GlobalFile.h"
#import "UserInfoEngine.h"
#import "UserInfo.h"
#import "MenuInfo.h"
#import "UIButton+HHSoft.h"
#import "MyAttentionViewController.h"
#import "AppDelegate.h"
#import "UserCenterNetWorkEngine.h"
#import "UserInfoViewController.h"
#import "HeaderView.h"
#import "MyPublishViewController.h"
#import "ConsultingRecordsViewController.h"
#import "SettingsViewController.h"
#import "HotRedPacketListViewController.h"
#import "MyWalletViewController.h"
#import "AboutUsViewController.h"
#import "PointsViewController.h"
#import "SystemMassageViewController.h"
#import "ApplyRedViewController.h"
#import "MyAdvertViewController.h"
#import "WKWebViewController.h"

#define buttonWidth ([HHSoftAppInfo AppScreen].width - 3)/4.0

@interface UserCenterViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>

@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UserInfo *userInfo;

@end

@implementation UserCenterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //设置导航控制器的代理为self
    self.navigationController.delegate = self;
    [self getUserCenterWithUserID:[UserInfoEngine getUserInfo].userID];
}

#pragma mark --- 导航栏变成白色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark --- UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
}

- (void)getUserCenterWithUserID:(NSInteger)userID {
    self.op = [[[UserCenterNetWorkEngine alloc] init] getUserCenterWithUserID:userID successed:^(NSInteger code, UserInfo *userInfo) {
        [self hideLoadingView];
        switch (code) {
            case 100: {
                _userInfo = userInfo;
                _arrData = [self getArrMenuDataWith:userInfo];
            }
                break;
                
            case 103: {
                [self showErrorView:@"该账号已禁用"];
                [UserInfoEngine setUserInfo:nil];
                AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                appDelegate.window.rootViewController = [AppDelegate getRootViewController];
            }
                break;
                
            default: {
                _userInfo = [UserInfoEngine getUserInfo];
                _arrData = [self getArrMenuDataWith:_userInfo];
            }
                break;
        }
        [self.dataTableView reloadData];
        [self.headerView reloadInputViews];
    } failed:^(NSError *error) {
        [self hideLoadingView];
        _userInfo = [UserInfoEngine getUserInfo];
        _arrData = [self getArrMenuDataWith:_userInfo];
        [self.dataTableView reloadData];
        [self.headerView reloadInputViews];
    }];
}

/**
 初始化dataTableView
 
 @return dataTableView
 */
- (HHSoftTableView *)dataTableView {
    if (!_dataTableView) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height - 49) dataSource:self delegate:self style:UITableViewStylePlain separatorColor:[UIColor clearColor]];
        _dataTableView.tableHeaderView = self.headerView;
        [self.view addSubview:_dataTableView];
    }
    return _dataTableView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].width)];
        //背景
        UIImageView *headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].width/2.0)];
        headerImage.image = [UIImage imageNamed:@"usercenter_topbackimg"];
        headerImage.userInteractionEnabled = YES;
        headerImage.layer.masksToBounds = YES;
        headerImage.contentMode = UIViewContentModeScaleAspectFill;
        [_headerView addSubview:headerImage];
        //头像
        UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(([HHSoftAppInfo AppScreen].width-[HHSoftAppInfo AppScreen].width/2.0/2)/2.0, [HHSoftAppInfo AppScreen].width/2.0 -[HHSoftAppInfo AppScreen].width/2.0/2/2.0, [HHSoftAppInfo AppScreen].width/2.0/2, [HHSoftAppInfo AppScreen].width/2.0/2)];
        headImageView.layer.cornerRadius = headImageView.frame.size.width/2.0;
        headImageView.layer.masksToBounds = YES;
        headImageView.userInteractionEnabled = YES;
        headImageView.contentMode = UIViewContentModeScaleAspectFill;
        headImageView.tag = 258;
        [_headerView addSubview:headImageView];
        
        UIImageView *certImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame)-38/2, CGRectGetMaxY(headImageView.frame)-38/2, 38/2, 38/2)];
        certImgView.image = [UIImage imageNamed:@"usercenter_cert"];
        certImgView.layer.masksToBounds = YES;
        certImgView.contentMode = UIViewContentModeScaleAspectFill;
        [_headerView addSubview:certImgView];
        certImgView.hidden = !_userInfo.userIsCert;
        //手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeadImageViewClick)];
        [headImageView addGestureRecognizer:tap];
        
        UIImageView *levelImage = [[UIImageView alloc] initWithFrame:CGRectMake(([HHSoftAppInfo AppScreen].width/2.0 -[HHSoftAppInfo AppScreen].width/3.0/2)/2.0, [HHSoftAppInfo AppScreen].width/2.0 - [HHSoftAppInfo AppScreen].width/3.0/2/2.0, [HHSoftAppInfo AppScreen].width/3.0/2, [HHSoftAppInfo AppScreen].width/3.0/2)];
        levelImage.userInteractionEnabled = YES;
        levelImage.layer.masksToBounds = YES;
        levelImage.layer.cornerRadius = levelImage.frame.size.width/2.0;
        levelImage.contentMode = UIViewContentModeScaleAspectFill;
        levelImage.tag = 262;
        //手势
        UITapGestureRecognizer *levelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLevelImageViewClick)];
        [levelImage addGestureRecognizer:levelTap];
        [_headerView addSubview:levelImage];
        
        UIImageView *identityImage = [[UIImageView alloc] initWithFrame:CGRectMake(([HHSoftAppInfo AppScreen].width/2.0 -[HHSoftAppInfo AppScreen].width/3.0/2)/2.0 + [HHSoftAppInfo AppScreen].width/2.0, [HHSoftAppInfo AppScreen].width/2.0 - [HHSoftAppInfo AppScreen].width/3.0/2/2.0, [HHSoftAppInfo AppScreen].width/3.0/2, [HHSoftAppInfo AppScreen].width/3.0/2)];
        identityImage.userInteractionEnabled = YES;
        identityImage.layer.masksToBounds = YES;
        identityImage.layer.cornerRadius = identityImage.frame.size.width/2.0;
        identityImage.contentMode = UIViewContentModeScaleAspectFill;
        [_headerView addSubview:identityImage];
        
        switch (_userInfo.userType) {
            case 1: {
                identityImage.image = [UIImage imageNamed:@"usercenter_merchant"];
            }
                break;
                
            case 2: {
                identityImage.image = [UIImage imageNamed:@"usercenter_supplier"];
            }
                break;
                
            default:
                break;
        }
        
        //昵称
        HHSoftLabel *nickNameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(headImageView.frame) + 10, [HHSoftAppInfo AppScreen].width-30, 30) fontSize:16.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
        nickNameLabel.tag = 260;
        [_headerView addSubview:nickNameLabel];
        
        //我的钱包
        HHSoftLabel *walletLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, (CGRectGetHeight(_headerView.frame) - CGRectGetMaxY(nickNameLabel.frame))/2.0 - 30 + CGRectGetMaxY(nickNameLabel.frame), [HHSoftAppInfo AppScreen].width/2.0 - 30, 60) fontSize:16.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentCenter numberOfLines:0];
        walletLabel.tag = 259;
        [_headerView addSubview:walletLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width/2.0-0.5, CGRectGetMinY(walletLabel.frame)+10, 1, 40)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [_headerView addSubview:lineView];
        
        //我的金币
        HHSoftLabel *pointsLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width/2.0+15, CGRectGetMinY(walletLabel.frame), [HHSoftAppInfo AppScreen].width/2.0 - 30, 60) fontSize:16.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentCenter numberOfLines:0];
        pointsLabel.tag = 261;
        [_headerView addSubview:pointsLabel];
    }
    //头像
    UIImageView *headImageView = (UIImageView *)[_headerView viewWithTag:258];
    //等级
    UIImageView *levelImage = (UIImageView *)[_headerView viewWithTag:262];
    //昵称
    HHSoftLabel *nickNameLabel = (HHSoftLabel *)[_headerView viewWithTag:260];
    //我的钱包
    HHSoftLabel *walletLabel = (HHSoftLabel *)[_headerView viewWithTag:259];
    //我的金币
    HHSoftLabel *pointsLabel = (HHSoftLabel *)[_headerView viewWithTag:261];
    [headImageView sd_setImageWithURL:[NSURL URLWithString:_userInfo.userHeadImg] placeholderImage:[GlobalFile avatarImage]];
    NSString *levelImgStr;
    if (_userInfo.userLevel && _userInfo.userLevel <= 5) {
        levelImgStr = [NSString stringWithFormat:@"usercenter_level%@", @(_userInfo.userLevel)];
    } else {
        levelImgStr = @"usercenter_level1";
    }
    levelImage.image = [UIImage imageNamed:levelImgStr];
    nickNameLabel.text = _userInfo.userNickName;
    walletLabel.text = [NSString stringWithFormat:@"%@\n我的钱包", [GlobalFile stringFromeFloat:_userInfo.userFees decimalPlacesCount:2]];
    pointsLabel.text = [NSString stringWithFormat:@"%@\n我的金币", @(_userInfo.userPoints)];
    
    return _headerView;
}

#pragma mark --- 等级点击事件
- (void)tapLevelImageViewClick {
    WKWebViewController *wkWebViewController = [[WKWebViewController alloc] initWithUrl:@"" WkWebType:WKWebTypeWithLevel MessageTitle:@"等级规则"];
    wkWebViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:wkWebViewController animated:YES];
}

#pragma mark --- 头像点击事件
- (void)tapHeadImageViewClick {
    UserInfoViewController *userInfoViewController = [[UserInfoViewController alloc] init];
    userInfoViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userInfoViewController animated:YES];
}

#pragma mark --- UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return buttonWidth*3+2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"UserCenterInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [GlobalFile backgroundColor];
        NSMutableArray *arr0 = _arrData[0];
        for (NSInteger i = 0; i < arr0.count; i ++) {
            MenuInfo *menuInfo = arr0[i];
            HHSoftButton *menuButton = [HHSoftButton buttonWithType:UIButtonTypeCustom frame:CGRectMake((buttonWidth + 1)*i, 0, buttonWidth, buttonWidth) titleColor:[HHSoftAppInfo defaultLightSystemColor] titleSize:13.0];
            menuButton.backgroundColor = [UIColor whiteColor];
            [menuButton setTitle:menuInfo.menuName forState:UIControlStateNormal];
            [menuButton setImage:[UIImage imageNamed:menuInfo.menuIcon] forState:UIControlStateNormal];
            [menuButton verticalImageAndTitle:10.0];
            menuButton.tag = 800 + menuInfo.menuID;
            [menuButton addTarget:self action:@selector(menuButtonPress:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:menuButton];
        }
        
        NSMutableArray *arr1 = _arrData[1];
        for (NSInteger i = 0; i < arr1.count; i ++) {
            MenuInfo *menuInfo = arr1[i];
            switch (i) {
                case 0: {
                    HHSoftButton *menuButton = [HHSoftButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(0, buttonWidth+1, buttonWidth, buttonWidth) titleColor:[HHSoftAppInfo defaultLightSystemColor] titleSize:13.0];
                    menuButton.backgroundColor = [UIColor whiteColor];
                    [menuButton setTitle:menuInfo.menuName forState:UIControlStateNormal];
                    [menuButton setImage:[UIImage imageNamed:menuInfo.menuIcon] forState:UIControlStateNormal];
                    [menuButton verticalImageAndTitle:10.0];
                    menuButton.tag = 800 + menuInfo.menuID;
                    [menuButton addTarget:self action:@selector(menuButtonPress:) forControlEvents:UIControlEventTouchUpInside];
                    [cell addSubview:menuButton];
                }
                    break;
                    
                case 1: {
                    HHSoftButton *menuButton = [HHSoftButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(buttonWidth+1, buttonWidth+1, [HHSoftAppInfo AppScreen].width-2*(buttonWidth+1), buttonWidth) titleColor:[HHSoftAppInfo defaultLightSystemColor] titleSize:13.0];
                    menuButton.backgroundColor = [UIColor whiteColor];
//                    [menuButton setTitle:menuInfo.menuName forState:UIControlStateNormal];
                    [menuButton setBackgroundImage:[UIImage imageNamed:menuInfo.menuIcon] forState:UIControlStateNormal];
//                    [menuButton verticalImageAndTitle:10.0];
                    menuButton.tag = 800 + menuInfo.menuID;
                    [menuButton addTarget:self action:@selector(menuButtonPress:) forControlEvents:UIControlEventTouchUpInside];
                    [cell addSubview:menuButton];
                }
                    break;
                    
                case 2: {
                    HHSoftButton *menuButton = [HHSoftButton buttonWithType:UIButtonTypeCustom frame:CGRectMake([HHSoftAppInfo AppScreen].width-buttonWidth, buttonWidth+1, buttonWidth, buttonWidth) titleColor:[HHSoftAppInfo defaultLightSystemColor] titleSize:13.0];
                    menuButton.backgroundColor = [UIColor whiteColor];
                    [menuButton setTitle:menuInfo.menuName forState:UIControlStateNormal];
                    [menuButton setImage:[UIImage imageNamed:menuInfo.menuIcon] forState:UIControlStateNormal];
                    [menuButton verticalImageAndTitle:10.0];
                    menuButton.tag = 800 + menuInfo.menuID;
                    [menuButton addTarget:self action:@selector(menuButtonPress:) forControlEvents:UIControlEventTouchUpInside];
                    [cell addSubview:menuButton];
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        NSMutableArray *arr2 = _arrData[2];
        for (NSInteger i = 0; i < arr2.count; i ++) {
            MenuInfo *menuInfo = arr2[i];
            HHSoftButton *menuButton = [HHSoftButton buttonWithType:UIButtonTypeCustom frame:CGRectMake((buttonWidth + 1)*i, (buttonWidth+1)*2, buttonWidth, buttonWidth) titleColor:[HHSoftAppInfo defaultLightSystemColor] titleSize:13.0];
            menuButton.backgroundColor = [UIColor whiteColor];
            [menuButton setTitle:menuInfo.menuName forState:UIControlStateNormal];
            [menuButton setImage:[UIImage imageNamed:menuInfo.menuIcon] forState:UIControlStateNormal];
            [menuButton verticalImageAndTitle:10.0];
            menuButton.tag = 800 + menuInfo.menuID;
            [menuButton addTarget:self action:@selector(menuButtonPress:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:menuButton];
        }
    }
    //申请打赏或设置赏金
    NSMutableArray *arr2 = _arrData[2];
    MenuInfo *menuInfo = arr2[2];
    HHSoftButton *menuButton = (HHSoftButton *)[cell viewWithTag:800 + menuInfo.menuID];
    [menuButton setTitle:menuInfo.menuName forState:UIControlStateNormal];
    return cell;
}

#pragma mark --- 菜单按钮点击
- (void)menuButtonPress:(HHSoftButton *)sender {
    NSInteger menuID = sender.tag - 800;
    switch (menuID) {
        case 0: {//我的钱包
            MyWalletViewController *myWalletViewController = [[MyWalletViewController alloc] init];
            myWalletViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myWalletViewController animated:YES];
        }
            break;
            
        case 1: {//我的发布
            MyPublishViewController *myPublishViewController = [[MyPublishViewController alloc] init];
            myPublishViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myPublishViewController animated:YES];
        }
            break;
            
        case 2: {//我的关注
            MyAttentionViewController *myAttentionViewController = [[MyAttentionViewController alloc] init];
            myAttentionViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myAttentionViewController animated:YES];
        }
            break;
            
        case 3: {//我的金币
            PointsViewController *pointsViewController = [[PointsViewController alloc] init];
            pointsViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:pointsViewController animated:YES];
        }
            break;
            
        case 4: {//咨询记录
            ConsultingRecordsViewController *consultingRecordsViewController = [[ConsultingRecordsViewController alloc] init];
            consultingRecordsViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:consultingRecordsViewController animated:YES];
        }
            break;
            
        case 5: {//热门推荐
            HotRedPacketListViewController *hotRedPacketListViewController = [[HotRedPacketListViewController alloc] init];
            hotRedPacketListViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hotRedPacketListViewController animated:YES];
        }
            break;
            
        case 6: {//系统消息
            SystemMassageViewController *systemMassageViewController = [[SystemMassageViewController alloc] init];
            systemMassageViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:systemMassageViewController animated:YES];
        }
            break;
            
        case 7: {//系统设置
            SettingsViewController *settingsViewController = [[SettingsViewController alloc] init];
            settingsViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:settingsViewController animated:YES];
        }
            break;
            
        case 8: {//关于我们
            AboutUsViewController *aboutUsViewController = [[AboutUsViewController alloc] init];
            aboutUsViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutUsViewController animated:YES];
        }
            break;
            
        case 9: {//预设打赏金
            if (_userInfo.userType == 2) {
                RedViewType redViewType;
                if (_userInfo.userIsOpenRed) {
                    redViewType = SetRedViewType;
                } else {
                    redViewType = OpenRedViewType;
                }
                ApplyRedViewController *applyRedViewController = [[ApplyRedViewController alloc] initWithUserApplyOpenRedBlock:nil viewType:redViewType];
                applyRedViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:applyRedViewController animated:YES];
            }
        }
            break;
            
        case 10: {//我的广告
            if (_userInfo.userType == 2) {
                MyAdvertViewController *myAdvertViewController = [[MyAdvertViewController alloc] init];
                myAdvertViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:myAdvertViewController animated:YES];
            }
        }
            break;
            
        default:
            break;
    }
}

/**
 获取菜单数据

 @param userInfo 用户信息

 @return arr
 */
- (NSMutableArray *)getArrMenuDataWith:(UserInfo *)userInfo {
    NSString *icon9, *icon10;
    NSString *menuName9;
    if (userInfo.userType == 2) {
        icon9 = @"usercenter_exceptional";
        icon10 = @"usercenter_advert";
    } else {
        icon9 = @"usercenter_grayexceptional";
        icon10 = @"usercenter_grayadvert";
    }
    if (userInfo.userIsOpenRed && userInfo.userType == 2) {
        menuName9 = @"设置赏金";
    } else {
        menuName9 = @"申请打赏";
    }
    MenuInfo *menuInfo0 = [[MenuInfo alloc] initWithMenuID:0 menuName:@"我的钱包" menuIcon:@"usercenter_wallet"];
    MenuInfo *menuInfo1 = [[MenuInfo alloc] initWithMenuID:1 menuName:@"我的发布" menuIcon:@"usercenter_publish"];
    MenuInfo *menuInfo2 = [[MenuInfo alloc] initWithMenuID:2 menuName:@"我的关注" menuIcon:@"usercenter_attention"];
    MenuInfo *menuInfo3 = [[MenuInfo alloc] initWithMenuID:3 menuName:@"我的金币" menuIcon:@"usercenter_gold"];
    NSMutableArray *arr0 = [NSMutableArray arrayWithObjects:menuInfo0, menuInfo1, menuInfo2, menuInfo3, nil];
    
    MenuInfo *menuInfo4 = [[MenuInfo alloc] initWithMenuID:4 menuName:@"咨询记录" menuIcon:@"usercenter_record"];
    MenuInfo *menuInfo5 = [[MenuInfo alloc] initWithMenuID:5 menuName:@"" menuIcon:@"usercenter_hotrecommand"];
    MenuInfo *menuInfo6 = [[MenuInfo alloc] initWithMenuID:6 menuName:@"系统消息" menuIcon:@"usercenter_message"];
    NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:menuInfo4, menuInfo5, menuInfo6, nil];
    
    MenuInfo *menuInfo7 = [[MenuInfo alloc] initWithMenuID:7 menuName:@"系统设置" menuIcon:@"usercenter_setting"];
    MenuInfo *menuInfo8 = [[MenuInfo alloc] initWithMenuID:8 menuName:@"关于我们" menuIcon:@"usercenter_about"];
    MenuInfo *menuInfo9 = [[MenuInfo alloc] initWithMenuID:9 menuName:menuName9 menuIcon:icon9];
    MenuInfo *menuInfo10 = [[MenuInfo alloc] initWithMenuID:10 menuName:@"我的广告" menuIcon:icon10];
    NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:menuInfo7, menuInfo8, menuInfo9, menuInfo10, nil];
    
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:arr0, arr1, arr2, nil];
    return arr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
