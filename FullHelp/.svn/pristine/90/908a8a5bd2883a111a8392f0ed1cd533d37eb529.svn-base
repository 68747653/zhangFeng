//
//  CustomServicerViewController.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/9.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "CustomServicerViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftTableView.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import "GlobalFile.h"
#import "UserInfo.h"
#import "UserInfoEngine.h"
#import "UserCenterNetWorkEngine.h"
#import "CustomServicerInfo.h"
#import "CustomServicerTableCell.h"

@interface CustomServicerViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) HHSoftTableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, assign) NSInteger industryID;

@end

@implementation CustomServicerViewController

- (instancetype)initWithIndustryID:(NSInteger)industryID {
    if (self = [super init]) {
        self.industryID = industryID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"联系我们";
    self.view.backgroundColor = [GlobalFile backgroundColor];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
    //调接口
    [self getCustomListWithIndustryID:_industryID];
}

- (void)getCustomListWithIndustryID:(NSInteger)industryID {
    self.op = [[[UserCenterNetWorkEngine alloc] init] getCustomListWithIndustryID:industryID successed:^(NSInteger code, NSMutableArray *arrCustomServicer) {
        [self hideLoadingView];
        switch (code) {
            case 100: {
                _arrData = arrCustomServicer;
                [self.view addSubview:self.dataTableView];
            }
                break;
                
            case 101: {
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadNoDataMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    [self getCustomListWithIndustryID:industryID];
                }];
            }
                break;
                
            default: {
                [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftLoadErrorMessage] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
                    [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
                    [self getCustomListWithIndustryID:industryID];
                }];
            }
                break;
        }
    } failed:^(NSError *error) {
        [self hideLoadingView];
        [self showLoadDataFailViewInView:self.view WithText:[GlobalFile HHSoftUnableLinkNetWork] failImage:[GlobalFile HHSoftLoadNoDataImage] failTouch:^{
            [self showLoadingViewWithText:[GlobalFile HHSoftLoadingWaitMessage] animationImages:[GlobalFile HHSoftLoadingAnimationImages] animationDuration:[GlobalFile HHSoftLoadingAnimationDuration]];
            [self getCustomListWithIndustryID:industryID];
        }];
    }];
}
#pragma mark --- 初始化dataTableView
- (HHSoftTableView *)dataTableView {
    if (_dataTableView == nil) {
        _dataTableView = [[HHSoftTableView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height - 64) dataSource:self delegate:self style:UITableViewStylePlain separatorColor:[UIColor clearColor]];
    }
    return _dataTableView;
}

#pragma mark --- TableView的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomServicerInfo *customServicerInfo = _arrData[indexPath.row];
    return [CustomServicerTableCell getCellHeightWith:customServicerInfo];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomServicerInfo *customServicerInfo = _arrData[indexPath.row];
    static NSString *strCell = @"CustomServicerInfoCell";
    
    CustomServicerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if(cell == nil){
        cell = [[CustomServicerTableCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.customServicerInfo = customServicerInfo;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
