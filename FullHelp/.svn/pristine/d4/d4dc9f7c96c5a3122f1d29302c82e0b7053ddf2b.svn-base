//
//  AddAdvertCommentViewController.m
//  FullHelp
//
//  Created by hhsoft on 17/2/10.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AddAdvertCommentViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/HHSoftTextView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftMutiPhotoImageCell.h>
#import <HHSoftFrameWorkKit/HHSoftMutiPhotoPickerManager.h>
#import "GlobalFile.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "CWStarRateView.h"
#import "RedPacketAdvertNetWorkEngine.h"

@interface AddAdvertCommentViewController ()<UITableViewDelegate,UITableViewDataSource,CWStarRateViewDelegate>
@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) HHSoftTextView *textView;
@property (nonatomic,strong) CWStarRateView *starRateView;
@property (nonatomic,assign) CGFloat newScoreCount;
@property (nonatomic,assign) NSInteger merchantUserID;
@property (nonatomic,copy) AddCommentSucceedBlock addCommentSucceedBlock;
@property(nonatomic,strong)NSMutableArray *arrImage;//上传的图片

@end

@implementation AddAdvertCommentViewController
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(instancetype)initWithMerchantUserID:(NSInteger)merchantUserID AddCommentSucceedBlock:(AddCommentSucceedBlock)AddCommentSucceedBlock{
    if(self = [super init]){
        _merchantUserID = merchantUserID;
        _addCommentSucceedBlock = AddCommentSucceedBlock;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"评价";
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    _newScoreCount = 5.0;
    [self.view addSubview:self.dataTableView];
}
#pragma mark -- 初始化dataTableView
-(HHSoftTableView *)dataTableView{
    if (_dataTableView == nil) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) dataSource:self delegate:self style:UITableViewStyleGrouped separatorColor:[UIColor clearColor]];
        _dataTableView.tableFooterView = [self footerView];
    }
    return _dataTableView;
}
#pragma mark -- 初始化footerView
-(UIView *)footerView{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, 100)];
        //提交按钮
        UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 40, [HHSoftAppInfo AppScreen].width-30, 40)];
        submitButton.backgroundColor = [GlobalFile themeColor];
        [submitButton setTitle:@"确定" forState:UIControlStateNormal];
        [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        submitButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        submitButton.layer.cornerRadius = 3.0;
        submitButton.layer.masksToBounds = YES;
        [_footerView addSubview:submitButton];
        [submitButton addTarget:self action:@selector(submitCommentButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _footerView;
}
#pragma mark -- TableView的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 2;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 110.0;
        }else{
            return 100.0;
        }
    }else{
        return 44.0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *scoreCell = @"scoreCell";
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:scoreCell];
        if(cell==nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:scoreCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //星星
            self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width-100-15, 14, 100, 16) numberOfStars:5];
            self.starRateView.userInteractionEnabled=YES;//是否支持点击,(只是展示的时候不让点击),默认为NO(既不可以点击)
            self.starRateView.delegate=self;
            self.starRateView.scorePercent = 1.0;//如果是评论的时候初始化的时候设置为零。
            self.starRateView.allowIncompleteStar = NO;//是否允许不是整星，默认为NO(即不允许)
            self.starRateView.hasAnimation = YES;//是否允许动画,默认是NO(即不允许)
            self.starRateView.starRateType=StarRateViewTypeComment;//如果是评论的时候,starRateType=StarRateViewTypeComment;如果是在页面显示的时候starRateType=StarRateViewTypeShow;
            [cell.contentView addSubview:self.starRateView];
        }
        cell.textLabel.text = @"评分：";
        cell.textLabel.textColor = [HHSoftAppInfo defaultDeepSystemColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        
        return cell;
        
    }else{
        if (indexPath.row == 0) {
            static NSString *contentCell = @"contentCell";
            
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:contentCell];
            if(cell==nil){
                cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contentCell];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                //输入框
                _textView = [[HHSoftTextView alloc] initWithFrame:CGRectMake(15, 10, [HHSoftAppInfo AppScreen].width-30, 100) textColor:[HHSoftAppInfo defaultDeepSystemColor] textFont:[UIFont systemFontOfSize:14.0] delegate:self placeHolderString:@"评论生活点滴，评论生活中的美好"];
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
    }
}
-(void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent{
    _newScoreCount=newScorePercent*5;//评分值
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
#pragma mark -- 添加评论按钮点击事件
-(void)submitCommentButtonClick{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (_textView.text.length == 0) {
        [self showErrorView:@"请输入评论内容"];
        return;
    }
    if (_arrImage.count == 0) {
        [self showErrorView:@"请上传图片"];
        return;
    }
    [self showWaitView:@"请稍等..."];
    self.view.userInteractionEnabled = NO;
    //评论接口
    [self addCommentInfoWithUserID:[UserInfoEngine getUserInfo].userID MerchantUserID:_merchantUserID CommentScore:_newScoreCount CommentContent:_textView.text FilePath:[self getTotalImagePathWithImageArray:_arrImage]];
}
#pragma mark -- 评论接口
-(void)addCommentInfoWithUserID:(NSInteger)userID
                 MerchantUserID:(NSInteger)merchantUserID
                   CommentScore:(CGFloat)commentScore
                 CommentContent:(NSString *)commentContent
                       FilePath:(NSMutableArray *)filePath{
    self.op = [[[RedPacketAdvertNetWorkEngine alloc] init] addCommentInfoWithUserID:userID MerchantUserID:merchantUserID CommentScore:commentScore CommentContent:commentContent FilePath:filePath Succeed:^(NSInteger code, CommentInfo *commentInfoModel) {
        self.view.userInteractionEnabled = YES;
        switch (code) {
            case 100:{
                [self showSuccessView:@"评论成功"];
                if (_addCommentSucceedBlock) {
                    _addCommentSucceedBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
                break;
            case 101:{
                [self showErrorView:@"评论失败"];
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
