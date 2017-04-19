//
//  DemandInfoViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/9.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "DemandInfoViewController.h"
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import "GlobalFile.h"
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "MenuInfo.h"
#import "DemandNoticeInfo.h"
#import "RedPacketAdvertNetWorkEngine.h"
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "ImageInfo.h"
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import "UIView+HHSoft.h"
#import "NSMutableAttributedString+hhsoft.h"
#import "UserInfo.h"
#import "AddressInfo.h"
#import "RedPacketAdvertNetWorkEngine.h"
#import "UserInfoEngine.h"
#import "AdvertDetailLocationViewController.h"
#import "LocationInfo.h"
#import <HHSoftFrameWorkKit/UIDevice+DeviceInfo.h>
#import "HHSoftBarButtonItem.h"
#import "AttentionNetWorkEngine.h"
@interface DemandInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) DemandNoticeInfo *demandInfo;
@property (nonatomic, assign) NSInteger demandID;
@end

@implementation DemandInfoViewController
- (instancetype)initWithDemandID:(NSInteger)demandID {
    self = [super init];
    if (self) {
        self.demandID = demandID;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    [self getDemandInfo];
}
- (void)getDemandInfo {
    [[[RedPacketAdvertNetWorkEngine alloc] init] getDemandInfoWithUserID:[UserInfoEngine getUserInfo].userID demandID:self.demandID successed:^(NSInteger code, DemandNoticeInfo *demandInfo) {
        if (code==100) {
            [self hideLoadingView];
            _demandInfo = demandInfo;
            MenuInfo *menuInfo = [[MenuInfo alloc] initWithMenuID:1002 menuName:nil menuIcon:nil menuDetail:nil menuData:demandInfo.arrShowImg];
            [self.arrData addObject:menuInfo];
            [self.dataTableView reloadData];
            NSString *collectStr = _demandInfo.isCollect==YES?@"collection_select.png":@"collection_unselect.png";
            self.navigationItem.rightBarButtonItem = [[HHSoftBarButtonItem alloc] initWithImageStr:collectStr itemClickBlock:^{
                [self addOrCancelCollectInfoWithUserID:[UserInfoEngine getUserInfo].userID CollectType:1 KeyID:_demandInfo.demandNoticeID];
            }];
        }
        else {
            [self hideLoadingView];
            [self showLoadDataFailViewInView:self.view WithText:@"网络异常" failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                [self hideLoadingView];
                [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                [self getDemandInfo];
            }];
        }
    } failed:^(NSError *error) {
        [self hideLoadingView];
        [self showLoadDataFailViewInView:self.view WithText:@"网络异常" failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
            [self hideLoadingView];
            [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
            [self getDemandInfo];
        }];
    }];
}
#pragma mark --- 收藏接口
- (void)addOrCancelCollectInfoWithUserID:(NSInteger)userID
                             CollectType:(NSInteger)collectType
                                   KeyID:(NSInteger)keyID {
    [self showWaitView:@"请稍候..."];
    self.view.userInteractionEnabled = NO;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.op = [[[AttentionNetWorkEngine alloc] init] addCollectOrCancelCollectWithUserID:userID collectType:collectType keyID:keyID successed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        self.navigationItem.rightBarButtonItem.enabled = YES;
        switch (code) {
            case 100: {
                [self showSuccessView:@"关注成功"];
                self.navigationItem.rightBarButtonItem.image = [[UIImage imageNamed:@"collection_select.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
            }
                break;
                
            case 101: {
                [self showErrorView:@"关注失败"];
            }
                break;
                
            case 103: {
                [self showSuccessView:@"取消关注成功"];
                self.navigationItem.rightBarButtonItem.image = [[UIImage imageNamed:@"collection_unselect.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            }
                break;
                
            case 104: {
                [self showErrorView:@"取消收藏失败"];
            }
                break;
                
            default: {
                [self showErrorView:@"网络连接异常，请稍后重试"];
            }
                break;
        }
    } failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        self.navigationItem.rightBarButtonItem.enabled = YES;
        [self showErrorView:@"网络连接失败，请稍后重试"];
    }];
}

- (void)setNavigationBar {
    self.navigationItem.title = @"需求详情";
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
}
#pragma mark ----------------- dataTableView
-(HHSoftTableView *)dataTableView{
    if (_dataTableView==nil) {
        _dataTableView=[[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStyleGrouped separatorColor:[UIColor clearColor]];
        [self.view addSubview:_dataTableView];
    }
    return _dataTableView;
}
#pragma mark--UITableViewDelegate
#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrData.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    MenuInfo *sectionInfo = self.arrData[section];
    return sectionInfo.menuData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    MenuInfo *sectionInfo = self.arrData[section];
    if (sectionInfo.menuID == 1002) {
        return CGFLOAT_MIN;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuInfo *sectionInfo = self.arrData[indexPath.section];
    if (sectionInfo.menuID == 1002) {
        //图集
        ImageInfo *imageInfo = _demandInfo.arrShowImg[indexPath.row];
        return imageInfo.imageHeight+10;
    }
    else {
        MenuInfo *rowInfo = sectionInfo.menuData[indexPath.row];
        if (rowInfo.menuID == 0) {
            //标题
            return _demandInfo.nameSize.height+20;
        }
        else if (rowInfo.menuID == 1) {
            //商家名称
            return 25;
        }
        else if (rowInfo.menuID == 2) {
            //地址
            return _demandInfo.addressInfo.addressSize.height+20;
        }
        else if (rowInfo.menuID == 3) {
            //介绍
            return _demandInfo.contentSize.height+20;
        }
    }
    return CGFLOAT_MIN;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuInfo *sectionInfo = self.arrData[indexPath.section];
    if (sectionInfo.menuID == 1002) {
        static NSString *imgIndentifier = @"imgIndentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imgIndentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imgIndentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, [HHSoftAppInfo AppScreen].width-20, 150)];
            imageView.tag = 1000;
            [cell addSubview:imageView];
            imageView.layer.masksToBounds = YES;
            cell.selectionStyle = UITableViewCellAccessoryNone;
        }
        ImageInfo *imageInfo = _demandInfo.arrShowImg[indexPath.row];
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:1000];
        imageView.height = imageInfo.imageHeight;
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageInfo.imageBig] placeholderImage:[GlobalFile HHSoftDefaultImg5_4]];
        return cell;
    }
    else {
        MenuInfo *rowInfo = sectionInfo.menuData[indexPath.row];
        switch (rowInfo.menuID) {
            case 0:
            {
                //标题
                static NSString *string=@"NameIdentifier";
                UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
                if (!cell) {
                    cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
                    HHSoftLabel *nameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 10, _demandInfo.nameSize.width, _demandInfo.nameSize.height) fontSize:16 text:_demandInfo.demandNoticeName textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
                    nameLabel.font = _demandInfo.nameFont;
                    [cell addSubview:nameLabel];
                    cell.selectionStyle = UITableViewCellAccessoryNone;
                }
                return cell;
            }
                break;
            case 1:
            {
                //商家名称
                static NSString *string=@"MerchantIdentifier";
                UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
                if (!cell) {
                    cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:string];
                    cell.textLabel.font = [UIFont systemFontOfSize:14];
                    cell.textLabel.textColor = [UIColor lightGrayColor];
                    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
                    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
                    
                    cell.textLabel.text = [NSString stringWithFormat:@"%@%@",[NSString stringByReplaceNullString:_demandInfo.userInfo.userMerchantName],[NSString stringByReplaceNullString:_demandInfo.userInfo.userTelPhone]];
                    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:cell.textLabel.text];
                    [attributed changeStr:_demandInfo.userInfo.userTelPhone changeFont:cell.textLabel.font changeColor:[GlobalFile themeColor]];
                    cell.textLabel.attributedText = attributed;
                    cell.detailTextLabel.text = _demandInfo.demandNoticeAddTime;
                    cell.selectionStyle = UITableViewCellAccessoryNone;
                }
                return cell;
            }
                break;
            case 2:
            {
                static NSString *string=@"AddressIdentifier";
                UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
                if (!cell) {
                    cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
                    
                    CALayer *line = [CALayer layer];
                    line.backgroundColor = [GlobalFile backgroundColor].CGColor;
                    line.frame = CGRectMake(15, 0, [HHSoftAppInfo AppScreen].width-30, 1);
                    [cell.layer addSublayer:line];
                    
                    UIImageView *addressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, ((_demandInfo.addressInfo.addressSize.height+20)-(20/1.08))/2, 20, 20/1.08)];
                    addressImageView.image = [UIImage imageNamed:@"address.png"];
//                    addressImageView.tag = 540;
                    [cell addSubview:addressImageView];
                    
                    HHSoftLabel *addressLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(40, 10, [HHSoftAppInfo AppScreen].width-50, _demandInfo.addressInfo.addressSize.height) fontSize:12 text:_demandInfo.addressInfo.address textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
                    addressLabel.font = _demandInfo.addressInfo.addressFont;
                    [cell addSubview:addressLabel];
                    cell.selectionStyle = UITableViewCellAccessoryNone;
//                    addressLabel.tag = 5551;
                }
                return cell;
            }
                break;
            case 3:
            {
                static NSString *string=@"ContentIdentifier";
                UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
                if (!cell) {
                    cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
                    HHSoftLabel *contentLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 10, _demandInfo.contentSize.width, _demandInfo.contentSize.height) fontSize:16 text:_demandInfo.demandContent textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
                    contentLabel.font = _demandInfo.contentFont;
                    [cell addSubview:contentLabel];
                    cell.selectionStyle = UITableViewCellAccessoryNone;
                }
                return cell;
            }
                break;
                
            default:
                break;
        }
    }
    static NSString *string=@"Identifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MenuInfo *sectionInfo = self.arrData[indexPath.section];
    if (sectionInfo.menuID == 1000) {
        MenuInfo *rowInfo = sectionInfo.menuData[indexPath.row];
        if (rowInfo.menuID == 1&&![_demandInfo.userInfo.userTelPhone containsString:@"*"]) {
            [UIDevice callUp:_demandInfo.userInfo.userTelPhone];
        }else  if (rowInfo.menuID == 2) {
            AdvertDetailLocationViewController *advertDetailLocationViewController = [[AdvertDetailLocationViewController alloc] initWithLatitude:_demandInfo.addressInfo.addressLatitude Longitude:_demandInfo.addressInfo.addressLongitude];
            [self.navigationController pushViewController:advertDetailLocationViewController animated:YES];
        }
    }
    
}
- (NSMutableArray *)arrData {
    if (!_arrData) {
        
        MenuInfo *sectionInfo0 = [[MenuInfo alloc] initWithMenuID:1000 menuName:nil menuIcon:nil menuDetail:nil menuData:
                                 [@[
                                    [[MenuInfo alloc] initWithMenuID:0 menuName:nil],
                                    [[MenuInfo alloc] initWithMenuID:1 menuName:nil],
                                    [[MenuInfo alloc] initWithMenuID:2 menuName:nil],
                                   ]mutableCopy]];
        MenuInfo *sectionInfo1 = [[MenuInfo alloc] initWithMenuID:1001 menuName:nil menuIcon:nil menuDetail:nil menuData:
                                  [@[
                                     [[MenuInfo alloc] initWithMenuID:3 menuName:nil],
                                     ]mutableCopy]];
        _arrData = [NSMutableArray arrayWithObjects:sectionInfo0,sectionInfo1, nil];
    }
    return _arrData;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
