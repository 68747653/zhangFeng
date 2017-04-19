//
//  FeedbackViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/8.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "FeedbackViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/HHSoftButton.h>
#import <HHSoftFrameWorkKit/HHSoftTextView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/HHSoftMutiPhotoImageCell.h>
#import <HHSoftFrameWorkKit/HHSoftMutiPhotoPickerManager.h>
#import "NSMutableAttributedString+hhsoft.h"
#import "GlobalFile.h"
#import "MenuInfo.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "HHSoftBarButtonItem.h"
#import "UserCenterNetWorkEngine.h"

@interface FeedbackViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property(nonatomic,strong) NSMutableArray *arrData;
@property (nonatomic,strong) HHSoftTextView *textView;
@property(nonatomic,strong)NSMutableArray *arrImage;//上传的图片
@property (nonatomic,strong) UITextField *telTextField;
@property (nonatomic,strong) MenuInfo *selectMenuInfo;

@end

@implementation FeedbackViewController
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.navigationItem.title = @"意见反馈";
    self.navigationItem.leftBarButtonItem = [[HHSoftBarButtonItem alloc] initBackButtonWithBackBlock:^{
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.navigationItem .rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(combitFeedbackBarButtonAction)];
    _arrData = [self getMutableArray];
    [self.view addSubview:self.dataTableView];
}
#pragma mark -- 初始化dataTableView
-(HHSoftTableView *)dataTableView{
    if (_dataTableView == nil) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStyleGrouped separatorColor:[GlobalFile backgroundColor]];
    }
    return _dataTableView;
}
#pragma mark -- TableView的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _arrData.count;
    }else if (section == 1) {
        return 2;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44.0;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 120.0;
        }else{
            return 100.0;
        }
    }else{
        return 44.0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 10.0;
    }else{
        return 50.0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 10.0;
    }else{
        return CGFLOAT_MIN;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *problemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 50)];
        HHSoftLabel *impressStrLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(10, 15, [HHSoftAppInfo AppScreen].width-20, 20) fontSize:14 text:@"•  问题类型  •" textColor:[GlobalFile themeColor] textAlignment:1 numberOfLines:1];
        [problemView addSubview:impressStrLabel];
        NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:@"•  问题类型  •"];
        [attributed changeStr:@"问题类型" changeFont:impressStrLabel.font changeColor:[HHSoftAppInfo defaultDeepSystemColor]];
        impressStrLabel.attributedText = attributed;
        return problemView;
    }else if (section == 1){
        UIView *descView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 50)];
        HHSoftLabel *impressStrLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(10, 15, [HHSoftAppInfo AppScreen].width-20, 20) fontSize:14 text:@"•  详细描述  •" textColor:[GlobalFile themeColor] textAlignment:1 numberOfLines:1];
        [descView addSubview:impressStrLabel];
        NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:@"•  详细描述  •"];
        [attributed changeStr:@"详细描述" changeFont:impressStrLabel.font changeColor:[HHSoftAppInfo defaultDeepSystemColor]];
        impressStrLabel.attributedText = attributed;
        return descView;
    }else{
        UIView *telView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 10)];
        return telView;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *strCell = @"strCell";
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:strCell];
        if(cell==nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            //按钮
            HHSoftButton *button = [[HHSoftButton alloc] initWithFrame:CGRectMake(85, 0, [HHSoftAppInfo AppScreen].width-85-15, 44) innerImage:[UIImage imageNamed:@"feedback_unselect.png"] innerImageRect:CGRectMake([HHSoftAppInfo AppScreen].width-85-15-20, 12, 20, 20) descTextRect:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width-85-15-25, 44.0) descText:@"" textColor:[UIColor lightGrayColor] textFont:[UIFont systemFontOfSize:14.0] textAligment:NSTextAlignmentLeft];
            button.tag = 456;
            [cell.contentView addSubview:button];
            [button addTarget:self action:@selector(feedBackProblemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        MenuInfo *menuInfo = _arrData[indexPath.row];
        cell.textLabel.text = menuInfo.menuName;
        cell.textLabel.textColor = [HHSoftAppInfo defaultDeepSystemColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        //按钮
        HHSoftButton *button = (HHSoftButton *)[cell.contentView viewWithTag:456];
        [button.layer setValue:indexPath forKey:@"indexPathKey"];
        if (menuInfo.menuIsSelect == YES) {
            _selectMenuInfo = menuInfo;
            [button setSelectImage:[UIImage imageNamed:@"feedback_select.png"] descText:menuInfo.menuDetail textColor:[UIColor lightGrayColor] textFont:[UIFont systemFontOfSize:14.0]];
        }else{
            [button setSelectImage:[UIImage imageNamed:@"feedback_unselect.png"] descText:menuInfo.menuDetail textColor:[UIColor lightGrayColor] textFont:[UIFont systemFontOfSize:14.0]];
        }
        
        return cell;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            static NSString *contentCell = @"contentCell";
            
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:contentCell];
            if(cell==nil){
                cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contentCell];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                //输入框
                _textView = [[HHSoftTextView alloc] initWithFrame:CGRectMake(15, 10, [HHSoftAppInfo AppScreen].width-30, 100) textColor:[HHSoftAppInfo defaultDeepSystemColor] textFont:[UIFont systemFontOfSize:14.0] delegate:self placeHolderString:@"请输入详细描述"];
                _textView.layer.borderWidth = 1.0;
                _textView.layer.cornerRadius = 3.0;
                _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
                _textView.layer.masksToBounds = YES;
                [cell.contentView addSubview:_textView];
            }
            
            return cell;
        }else{
            static NSString *imageCell = @"imageCell";
            
            HHSoftMutiPhotoImageCell *photoImgCell = [tableView dequeueReusableCellWithIdentifier:imageCell];
            if (photoImgCell == nil) {
                photoImgCell = [[HHSoftMutiPhotoImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imageCell selectPhotoImage:[UIImage imageNamed:@"houses_addimg"] selectPhotoImageCorner:1 compressImageSize:CGSizeMake(800, 800) showImageSize:CGSizeMake(80, 80) maxUploadImageCount:9 targetController:self selectPhotoArrBlock:^(NSMutableArray *arrHHSoftUploadImageInfo) {
                    _arrImage = arrHHSoftUploadImageInfo;
                } deletePhotoBlock:^(NSInteger uploadImageID, NSInteger imgViewIndex) {
                    
                } selectSinglePhotoBlock:^(HHSoftUploadImageInfo *uploadImageInfo) {
                    
                } singleImageViewPressed:^(NSInteger uploadImageID, NSInteger imgViewIndex) {
                    
                } isShowBigImageView:NO compressImageSaveMethod:MethodTargetSize selectImageViewPressed:^{
                    [[UIApplication sharedApplication].keyWindow endEditing:YES];
                } alreadySelectImageCount:0];
            }
            return photoImgCell;
        }
    }else{
        static NSString *strCell = @"telCell";
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:strCell];
        if(cell==nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            //电话输入框
            _telTextField = [[UITextField alloc] initWithFrame:CGRectMake(85, 0, [HHSoftAppInfo AppScreen].width-85-15, 44.0)];
            _telTextField.placeholder = @"方便我们更快的向您联系哦！";
            _telTextField.textColor = [HHSoftAppInfo defaultDeepSystemColor];
            _telTextField.font = [UIFont systemFontOfSize:14.0];
            _telTextField.keyboardType = UIKeyboardTypeNumberPad;
            _telTextField.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:_telTextField];
        }
        cell.textLabel.text = @"手机号码";
        cell.textLabel.textColor = [HHSoftAppInfo defaultDeepSystemColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        
        
        return cell;
    }
}
#pragma mark -- 问题按钮点击事件
-(void)feedBackProblemButtonClick:(HHSoftButton *)button{
    NSIndexPath *indexPath = [button.layer valueForKey:@"indexPathKey"];
    for (MenuInfo *menuInfo in _arrData) {
        menuInfo.menuIsSelect = NO;
    }
    MenuInfo *menuInfoModel = _arrData[indexPath.row];
    menuInfoModel.menuIsSelect = YES;
    [_dataTableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma mark -- 初始化数据
-(NSMutableArray *)getMutableArray{
    MenuInfo *menuInfo = [[MenuInfo alloc] initWithMenuID:1 menuName:@"功能异常" menuDetail:@"您发现功能异常问题" menuIsSelect:YES];
    MenuInfo *menuInfo1 = [[MenuInfo alloc] initWithMenuID:2 menuName:@"使用建议" menuDetail:@"给出您的好建议" menuIsSelect:NO];
    MenuInfo *menuInfo2 = [[MenuInfo alloc] initWithMenuID:3 menuName:@"功能需求" menuDetail:@"您让我们为您做的功能" menuIsSelect:NO];
    MenuInfo *menuInfo3 = [[MenuInfo alloc] initWithMenuID:4 menuName:@"系统闪退" menuDetail:@"APP意外退出" menuIsSelect:NO];
    MenuInfo *menuInfo4 = [[MenuInfo alloc] initWithMenuID:5 menuName:@"检举投诉" menuDetail:@"投诉商家或供应商" menuIsSelect:NO];
    
    return [NSMutableArray arrayWithObjects:menuInfo,menuInfo1,menuInfo2,menuInfo3,menuInfo4, nil];
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
#pragma mark -- 提交按钮点击事件
-(void)combitFeedbackBarButtonAction{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (_textView.text.length == 0) {
        [self showErrorView:@"请输入详细描述"];
        return;
    }
    [self showWaitView:@"请稍等..."];
    self.view.userInteractionEnabled = NO;
    [self addFeedBackWithUserID:[UserInfoEngine getUserInfo].userID FeedBackType:_selectMenuInfo.menuID TelPhone:_telTextField.text FeedBackContent:_textView.text FilePath:[self getTotalImagePathWithImageArray:_arrImage]];
}
#pragma mark -- 意见反馈的接口
-(void)addFeedBackWithUserID:(NSInteger)userID
                FeedBackType:(NSInteger)feedBackType
                    TelPhone:(NSString *)telPhone
             FeedBackContent:(NSString *)feedBackContent
                    FilePath:(NSMutableArray *)filePath{
    self.op = [[[UserCenterNetWorkEngine alloc] init] addFeedBackWithUserID:userID FeedBackType:feedBackType TelPhone:telPhone FeedBackContent:feedBackContent FilePath:filePath Succeed:^(NSInteger code) {
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100:{
                [self showSuccessView:@"反馈成功"];
                [self dismissViewControllerAnimated:YES completion:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }
                break;
            case 101:{
                [self showErrorView:@"反馈失败"];
            }
                break;
            case 103:{
                [self showErrorView:@"图片上传失败"];
            }
                break;
            default:
                [self showErrorView:@"网络接连异常,请稍后重试"];
                break;
        }
    } Failed:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        [self showErrorView:@"网络接连异常,请稍后重试"];
    }];
}
@end
