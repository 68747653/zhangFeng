//
//  PublishNeedsViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/8.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "PublishNeedsViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import "MenuInfo.h"
#import "GlobalFile.h"
#import "HHSoftBarButtonItem.h"
#import "UserInfoEngine.h"
#import "UserInfo.h"
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import "NSMutableAttributedString+hhsoft.h"
#import <objc/runtime.h>
#import <HHSoftFrameWorkKit/HHSoftTextView.h>
#import "DemandNoticeInfo.h"
#import "AddressInfo.h"
#import "EditAddressViewController.h"
#import <HHSoftFrameWorkKit/HHSoftMutiPhotoImageView.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "RedPacketAdvertNetWorkEngine.h"
#import "UIView+HHSoft.h"
#import "HHSoftHeader.h"
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import "RedPacketInfo.h"
#import "RedPacketView.h"
#import "OpenRedPacketInfoViewController.h"
#import "MainTabBarController.h"
#import "MainNavgationController.h"
#import "HHSoftHeader.h"
#import "RedPacketAdvertNetWorkEngine.h"
@interface PublishNeedsViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) HHSoftTableView *dataTableView;
@property (nonatomic, assign) NeedsType needsType;
@property (nonatomic, strong) DemandNoticeInfo *demandInfo;
@property (nonatomic, strong) NSMutableArray *arrImg;
@property (nonatomic, assign) CGFloat addressHeight;
@property (nonatomic, strong) RedPacketView *redPacketView;
@property (nonatomic, assign) NSInteger isEdit;
@property (nonatomic, assign) NSInteger demandID;
    @property (nonatomic, strong) NSMutableArray *arrDeleteImgID;

@end

@implementation PublishNeedsViewController
- (instancetype)initWithDemandID:(NSInteger)demandID {
    self = [self init];
    if (self) {
        self.isEdit = YES;
        self.demandID = demandID;
    }
    return self;
}
- (instancetype) init {
    if (self = [super init]) {
        self.needsType = [UserInfoEngine getUserInfo].userType == 1?NeedsTypeMerchant:NeedsTypeSupplier;
        _demandInfo = [[DemandNoticeInfo alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    if (!self.isEdit) {
        [self.dataTableView reloadData];
    }
    else {
        [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
        [self getDemandInfo];
    }
    
}
- (void)getDemandInfo {
    [[[RedPacketAdvertNetWorkEngine alloc] init] getDemandInfoWithUserID:[UserInfoEngine getUserInfo].userID demandID:self.demandID successed:^(NSInteger code, DemandNoticeInfo *demandInfo) {
        if (code==100) {
            [self hideLoadingView];
            _demandInfo = demandInfo;
            _arrImg = demandInfo.arrImg;
            [self.dataTableView reloadData];
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
- (void)editDemand {
    [self showWaitView:@"请稍候..."];
    self.view.userInteractionEnabled = NO;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [[[RedPacketAdvertNetWorkEngine alloc] init] editDemandWithUserID:[UserInfoEngine getUserInfo].userID demandType:self.needsType deleteImgIDs:[self.arrDeleteImgID componentsJoinedByString:@","] demandInfo:_demandInfo successed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        self.navigationItem.rightBarButtonItem.enabled = YES;
        if (code==100) {
            [self hideWaitView];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if (code == 103) {
            [self showErrorView:@"手机号格式错误"];
        }
        else if (code == 104) {
            [self showErrorView:@"图片上传失败"];
        }
        else {
            [self showErrorView:@"网络异常"];
        }
    } failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        self.navigationItem.rightBarButtonItem.enabled = YES;
        [self showErrorView:@"网络异常"];
    }];
}
- (void)publishDemand {
    [self showWaitView:@"请稍候..."];
    self.view.userInteractionEnabled = NO;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [[[RedPacketAdvertNetWorkEngine alloc] init] publishDemandWithUserID:[UserInfoEngine getUserInfo].userID demandType: self.needsType demandInfo:_demandInfo successed:^(NSInteger code,NSString *demandID, NSString *weekCount, NSString *leaveCount) {
        self.view.userInteractionEnabled = YES;
        self.navigationItem.rightBarButtonItem.enabled = YES;
        switch (code) {
            case 100:
            {
                [self hideWaitView];
                [[NSNotificationCenter defaultCenter]postNotificationName:PublishDemandNotification object:nil];
                    
                NSString *hintStr = [NSString stringWithFormat:@"发布成功,今天还可以发布%@条",leaveCount];
                UIAlertController *alertController =[UIAlertController alertControllerWithTitle:nil message:hintStr preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if (self.needsType == NeedsTypeMerchant) {
                        if ([leaveCount integerValue]>0) {
                            RedPacketInfo *redPacketInfo = [[RedPacketInfo alloc] init];
                            redPacketInfo.sendUserInfo.userHeadImg = @"Icon.png";
                            redPacketInfo.sendUserInfo.userNickName = [HHSoftAppInfo AppName];
                            redPacketInfo.redPacketMemo = @"需求红包";
                            _redPacketView = [[RedPacketView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height) openRedPacket:^(NSString *amount) {
                                _redPacketView.redPacketInfo.redPacketAmount = amount;
                                OpenRedPacketInfoViewController*openRedPacketInfoViewController = [[OpenRedPacketInfoViewController alloc] initWithRedPacketInfo:_redPacketView.redPacketInfo];
                                openRedPacketInfoViewController.hidesBottomBarWhenPushed = YES;
                                MainTabBarController *mainTabBarController = (MainTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                                MainNavgationController *nav = mainTabBarController.viewControllers[mainTabBarController.selectedIndex];
                                [nav pushViewController:openRedPacketInfoViewController animated:YES];
                                [_redPacketView removeFromSuperview];
                                
                            }];
                            _redPacketView.redPacketInfo = redPacketInfo;
                            _redPacketView.demandID = [demandID integerValue];
                            _redPacketView.redPacketType = RedPacketTypePublishDemand;
                            [[UIApplication sharedApplication].keyWindow addSubview:_redPacketView];
                        }

                    }
                    [self dismissViewControllerAnimated:YES completion:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alertController addAction:confirm];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
                break;
            case 103:
            {
                [self showErrorView:@"手机号格式不正确"];
            }
                break;
            case 104:
            {
                [self showErrorView:@"图片上传失败"];
            }
                break;
            case 105:
            {
                [self showErrorView:@"商家不能发布公示公告，供货商不能发布需求"];
            }
                break;
            case 106:
            {
                [self showErrorView:@"一天最多发布三条"];
            }
                break;
            case 107:
            {
                [self showErrorView:@"商家等级小于2不能发布需求"];
            }
                break;
                
            default:
                [self showErrorView:@"网络异常"];
                break;
        }
    } failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        self.navigationItem.rightBarButtonItem.enabled = YES;
        [self showErrorView:@"网络异常"];
    }];
}
- (void)setNavigationBar {
    [self.navigationItem setBackBarButtonItemTitle:@""];
    
    
    self.navigationItem.leftBarButtonItem = [[HHSoftBarButtonItem alloc] initBackButtonWithBackBlock:^{
        UIAlertController *alertController =[UIAlertController alertControllerWithTitle:@"提示" message:@"您确定放弃本次编辑吗?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:confirm];
        [alertController addAction:cancle];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }];
    NSString *rightItemTitle;
    if (self.isEdit) {
        self.navigationItem.title = @"编辑需求";
        rightItemTitle = @"确定";
    }
    else {
        self.navigationItem.title = @"发布需求";
        rightItemTitle = @"发布";
    }
    
    self.navigationItem.rightBarButtonItem = [[HHSoftBarButtonItem alloc] initWithitemTitle:rightItemTitle itemClickBlock:^{
        [self.view endEditing:YES];
        UITextView *contentTextView = [self.dataTableView viewWithTag:8000];
        _demandInfo.demandContent = contentTextView.text;
        if (!_demandInfo.demandNoticeName.length) {
            [self showErrorView:@"请输入需求标题"];
            return ;
        }
        if (!_demandInfo.userInfo.userTelPhone.length) {
            [self showErrorView:@"请输入您的电话号码"];
            return ;
        }
        if (_demandInfo.userInfo.userTelPhone.length!=11) {
            [self showErrorView:@"请核对您的电话号码"];
            return ;
        }
        if (!_demandInfo.addressInfo.addressDetail.length) {
            [self showErrorView:@"请选择联系地址"];
            return;
        }
        if (!_demandInfo.demandContent.length) {
            [self showErrorView:@"请输入详细信息"];
            return;
        }
        _demandInfo.arrImg = [self getTotalImagePathWithImageArray:_arrImg];
        if (!_demandInfo.arrImg.count&&!self.isEdit) {
            [self showErrorView:@"请选择图片"];
            return;
        }
        
        if (self.isEdit) {
            [self editDemand];
        }
        else {
            [self publishDemand];
        }
        
        
    }];
    [self.navigationItem.rightBarButtonItem setTintColor:[GlobalFile themeColor]];
}
#pragma mark ----------------- dataTableView
-(HHSoftTableView *)dataTableView{
    if (_dataTableView==nil) {
        _dataTableView=[[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStyleGrouped];
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
    MenuInfo *menuInfo = self.arrData[section];
    return menuInfo.menuData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuInfo *sectionInfo = self.arrData[indexPath.section];
    MenuInfo *rowInfo = sectionInfo.menuData[indexPath.row];
    if (sectionInfo.menuID == 102) {
        return 80;
    }
    else if (sectionInfo.menuID == 103) {
        CGFloat height = 0.0f;
        if (_arrImg.count<4) {
            height =  ([HHSoftAppInfo AppScreen].width-30)/4+20;
        }else if(_arrImg.count>=4 && _arrImg.count<8){
            height =  (([HHSoftAppInfo AppScreen].width-30)/4)*2+30;
        }else{
            height =  (([HHSoftAppInfo AppScreen].width-30)/4)*3+40;
        }
        return height;
    }
    else {
        if (rowInfo.menuID == 2) {
            NSString *address = [NSString stringWithFormat:@"%@%@",[NSString stringByReplaceNullString:_demandInfo.addressInfo.addressDetail],[NSString stringByReplaceNullString:_demandInfo.addressInfo.addressHouseNumber]];
            _addressHeight = [address boundingRectWithfont:[UIFont systemFontOfSize:12] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-151.5, CGFLOAT_MAX)].height+28;
            return _addressHeight;
            
        }
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    MenuInfo *sectionInfo = self.arrData[section];
    if (sectionInfo.menuID==102) {
        return 45;
    }
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    MenuInfo *sectionInfo = self.arrData[section];
    if (self.needsType==NeedsTypeMerchant&&sectionInfo.menuID == 100) {
        return 20;
    }
    return CGFLOAT_MIN;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MenuInfo *sectionInfo = self.arrData[section];
    if (sectionInfo.menuID==102) {
        NSString *headerViewIdentifier = @"infoIdentifier";
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewIdentifier];
        if (!headerView) {
            headerView = [[UITableViewHeaderFooterView alloc] init];
            HHSoftLabel *label = [[HHSoftLabel alloc] initWithFrame:CGRectMake(0, 15, [HHSoftAppInfo AppScreen].width, 30) fontSize:14 text:@"    详细信息" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
            label.backgroundColor = [UIColor whiteColor];
            [headerView addSubview:label];
        }
        return headerView;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    MenuInfo *sectionInfo = self.arrData[section];
    if (self.needsType==NeedsTypeMerchant&&sectionInfo.menuID == 100) {
        NSString *headerViewIdentifier = @"headerViewIdentifier";
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewIdentifier];
        if (!headerView) {
            headerView = [[UITableViewHeaderFooterView alloc] init];
            HHSoftLabel *hintLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(10, 0, [HHSoftAppInfo AppScreen].width-20, 30) fontSize:12 text:@"" textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentLeft numberOfLines:2];
            [headerView addSubview:hintLabel];
            
            NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] init];
            [attributed attributedStringWithImageStr:@"redPacket_hint.png" imageSize:CGSizeMake(15, 15)];
            [attributed appendAttributedString:[[NSAttributedString alloc] initWithString:@"温馨提示:发布特色需求每周前三条平台会有红包奖励"]];
            hintLabel.attributedText = attributed;
            
        }
        return headerView;
    }
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuInfo *sectionInfo = self.arrData[indexPath.section];
    MenuInfo *rowInfo = sectionInfo.menuData[indexPath.row];
    if (rowInfo.menuID == 4) {
        static NSString *imageCell = @"imagePhotoImageCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imageCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:imageCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            HHSoftMutiPhotoImageView *mutiPhtotImgView = [[HHSoftMutiPhotoImageView alloc] initWithselectPhotoImage:[UIImage imageNamed:@"houses_addimg.png"] selectPhotoImageCorner:1.0 compressImageSize:CGSizeMake(800, 800) showImageSize:CGSizeMake(([HHSoftAppInfo AppScreen].width-30)/4, ([HHSoftAppInfo AppScreen].width-30)/4) maxUploadImageCount:9 targetController:self selectPhotoArrBlock:^(NSMutableArray *arrHHSoftUploadImageInfo) {
                _arrImg= arrHHSoftUploadImageInfo;
                if (self.isEdit) {
                    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
                }
                else {
                    [self.dataTableView reloadData];
                    
                }
                
            } deletePhotoBlock:^(NSInteger uploadImageID, NSInteger imgViewIndex) {
                if (self.isEdit&&uploadImageID) {
                    [self.arrDeleteImgID addObject:[@(uploadImageID) stringValue]];
                    for (HHSoftUploadImageInfo *imageInfo in _demandInfo.arrImg) {
                        if (imageInfo.uploadImageID == uploadImageID) {
                            [_demandInfo.arrImg removeObject:imageInfo];
                        }
                    }
                }
            } selectSinglePhotoBlock:^(HHSoftUploadImageInfo *uploadImageInfo) {
            } singleImageViewPressed:^(NSInteger uploadImageID, NSInteger imgViewIndex) {
            } isShowBigImageView:NO singleRowImageCount:4 compressImageSaveMethod:MethodRealitySize selectUploadImageViewPressed:^{
                [[UIApplication sharedApplication].keyWindow endEditing:YES];
            } alreadySelectImageCount:_arrImg.count];
            mutiPhtotImgView.tag = 888;
            [cell addSubview:mutiPhtotImgView];
        }
        HHSoftMutiPhotoImageView *mutiPhtotImgView = (HHSoftMutiPhotoImageView *)[cell viewWithTag:888];
       
        CGFloat height = 0.0f;
        if (_arrImg.count<4) {
            height =  ([HHSoftAppInfo AppScreen].width-30)/4+20;
        }else if(_arrImg.count>=4 && _arrImg.count<8){
            height =  (([HHSoftAppInfo AppScreen].width-30)/4)*2+30;
        }else{
            height =  (([HHSoftAppInfo AppScreen].width-30)/4)*3+40;
        }
        mutiPhtotImgView.frame = CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, height);
        if (self.isEdit) {
            [mutiPhtotImgView setArrarImage:_arrImg];
        }
        return cell;

    }else if (rowInfo.menuID == 3) {
        
        static NSString *string=@"TextViewIdentifier";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
        if (!cell) {
            
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            HHSoftTextView *textView = [[HHSoftTextView alloc] initWithFrame:CGRectMake(7.5, 5, [HHSoftAppInfo AppScreen].width-15, 70) textColor:[HHSoftAppInfo defaultLightSystemColor] textFont:[UIFont systemFontOfSize:14] delegate:self placeHolderString:@"请输入详细信息" placeHolderColor:[UIColor lightGrayColor]];
            textView.tag = 8000;
            [cell addSubview:textView];
        }
        HHSoftTextView *textView = [cell viewWithTag:8000];
        textView.text = _demandInfo.demandContent;
        return cell;
    }
    else if (rowInfo.menuID == 2) {
        static NSString *string=@"AddressIdentifier";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
            
            HHSoftLabel *label = [[HHSoftLabel alloc] initWithFrame:CGRectMake(17.5, 0, 75, 44) fontSize:14 text:rowInfo.menuName textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
            label.tag = 6002;
            [cell.contentView addSubview:label];
            
            HHSoftLabel *addressLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(91.5, 0, [HHSoftAppInfo AppScreen].width-151.5, 44) fontSize:12 text:@"" textColor:nil textAlignment:NSTextAlignmentLeft numberOfLines:0];
            [cell addSubview:addressLabel];
            addressLabel.tag = 5551;

            cell.selectionStyle = UITableViewCellAccessoryNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UIImageView *addressImageView = [[UIImageView alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width-50, 10, 20, 20/1.08)];
            addressImageView.image = [UIImage imageNamed:@"address.png"];
            addressImageView.tag = 540;
            [cell addSubview:addressImageView];
            
        }
        HHSoftLabel *label = [cell viewWithTag:6002];
        HHSoftLabel *addressLabel = [cell viewWithTag:5551];
        UIImageView *imageView = [cell viewWithTag:540];
        NSString *addressStr = [NSString stringWithFormat:@"%@%@",[NSString stringByReplaceNullString:_demandInfo.addressInfo.addressDetail],[NSString stringByReplaceNullString:_demandInfo.addressInfo.addressHouseNumber]];
        if (addressStr.length) {
            addressLabel.textColor = [HHSoftAppInfo defaultLightSystemColor];
        }
        else {
            addressStr = @"请选择所在地区";
            addressLabel.textColor = [GlobalFile colorWithRed:193 green:192 blue:196 alpha:1];
        }
        addressLabel.text = addressStr;
        label.y = (_addressHeight-44)/2;
        addressLabel.height = _addressHeight;
        imageView.y = (_addressHeight-20/1.08)/2;
        return cell;
    }
    else {
        static NSString *string=@"Identifier";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
            
            HHSoftLabel *label = [[HHSoftLabel alloc] initWithFrame:CGRectMake(17.5, 0, 75, 44) fontSize:14 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
            label.tag = 6001;
            [cell.contentView addSubview:label];
            
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(91.5, 0, [HHSoftAppInfo AppScreen].width-101.5, 44)];
            textField.textColor = [HHSoftAppInfo defaultLightSystemColor];
            textField.delegate = self;
            textField.font = [UIFont systemFontOfSize:12];
            textField.tag = 5550;
            [cell addSubview:textField];
            
            cell.selectionStyle = UITableViewCellAccessoryNone;
        }
        
        HHSoftLabel *label = [cell viewWithTag:6001];
        UITextField *textField = [cell viewWithTag:5550];
        objc_setAssociatedObject(textField, @"textValue", [NSNumber numberWithInteger:rowInfo.menuID], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        switch (rowInfo.menuID) {
            case 0:
            {
                textField.keyboardType = UIKeyboardTypeDefault;
                textField.placeholder = @"请输入需求标题";
                textField.text = _demandInfo.demandNoticeName;
            }
                break;
            case 1:
            {
                textField.keyboardType = UIKeyboardTypeNumberPad;
                textField.placeholder = @"请输入联系电话";
                textField.text = _demandInfo.userInfo.userTelPhone;
            }
                break;
            default:
                break;
        }
        label.text = rowInfo.menuName;
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MenuInfo *sectionInfo = self.arrData[indexPath.section];
    MenuInfo *rowInfo = sectionInfo.menuData[indexPath.row];
    if (rowInfo.menuID == 2) {
        EditAddressViewController*editAddressViewController = [[EditAddressViewController alloc] initWithAddressInfo:_demandInfo.addressInfo editAddressBlock:^(AddressInfo *addressInfo) {
            _demandInfo.addressInfo = addressInfo;
            UITextField *addressTextField = [self.dataTableView viewWithTag:5551];
            addressTextField.text = [NSString stringWithFormat:@"%@%@",[NSString stringByReplaceNullString:_demandInfo.addressInfo.addressDetail],[NSString stringByReplaceNullString:_demandInfo.addressInfo.addressHouseNumber]];
            [self.dataTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
            
        }
        viewType:SelectAddressType];
        [self.navigationController pushViewController:editAddressViewController animated:YES];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSInteger menuID = [objc_getAssociatedObject(textField, @"textValue") integerValue];
    switch (menuID) {
        case 0:
        {
            _demandInfo.demandNoticeName = textField.text;
        }
            break;
        case 1:
        {
            _demandInfo.userInfo.userTelPhone = textField.text;
        }
            break;
        default:
            break;
    }
    
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    _demandInfo.demandContent = textView.text;
}
#pragma mark -- 获取上传的图片
-(NSMutableArray *)getTotalImagePathWithImageArray:(NSMutableArray *)imgArray{
    NSMutableArray *imgPathArray=[[NSMutableArray alloc] init];
    NSString *path=NSHomeDirectory();
    for (HHSoftUploadImageInfo *imageInfo in imgArray) {
        if ([imageInfo.sourceImageFilePath hasPrefix:path]) {
            [imgPathArray addObject:imageInfo.compressImageFilePath];
        }
    }
    return imgPathArray;
}
- (NSMutableArray *)arrData {
    if (!_arrData) {
        _arrData = [NSMutableArray array];

            MenuInfo *section0 = [[MenuInfo alloc] initWithMenuID:100 menuName:nil menuIcon:nil menuDetail:nil menuData:
                                  [@[
                                     [[MenuInfo alloc] initWithMenuID:0 menuName:@"需求标题"]
                                     ]mutableCopy]
                                  ];
            
            MenuInfo *section1 = [[MenuInfo alloc] initWithMenuID:101 menuName:nil menuIcon:nil menuDetail:nil menuData:
                                  [@[
                                     [[MenuInfo alloc] initWithMenuID:1 menuName:@"联系电话"],
                                      [[MenuInfo alloc] initWithMenuID:2 menuName:@"联系地址"]
                                     ]mutableCopy]
                                  ];
            MenuInfo *section2 = [[MenuInfo alloc] initWithMenuID:102 menuName:@"详细信息" menuIcon:nil menuDetail:nil menuData:
                                  [@[
                                     [[MenuInfo alloc] initWithMenuID:3 menuName:@""],
                                     ]mutableCopy]
                                  ];
            MenuInfo *section3 = [[MenuInfo alloc] initWithMenuID:103 menuName:@"" menuIcon:nil menuDetail:nil menuData:
                              [@[
                                 [[MenuInfo alloc] initWithMenuID:4 menuName:@""],
                                 ]mutableCopy]
                              ];
            [_arrData addObjectsFromArray:[NSArray arrayWithObjects:section0,section1,section2,section3, nil]];
   
    }
    return _arrData;
}
- (NSMutableArray *)arrDeleteImgID {
    if (!_arrDeleteImgID) {
        _arrDeleteImgID = [NSMutableArray array];
    }
    return _arrDeleteImgID;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
