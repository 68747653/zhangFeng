//
//  SearchHistoryViewController.m
//  FullHelp
//
//  Created by hhsoft on 17/2/14.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "SearchHistoryViewController.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/UINavigationItem+HHSoft.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import <HHSoftFrameWorkKit/HHSoftDefaults.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import "GlobalFile.h"
#import "RedPacketAdvertLabelInfo.h"
#import "HHSoftCustomFlowLayout.h"
#import "SearchResultsViewController.h"

@interface SearchHistoryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>
@property (nonatomic,strong) UICollectionView *dataCollectionView;
@property (nonatomic,strong) HHSoftCustomFlowLayout *layout;
@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,strong) NSMutableArray *arrHistory;
@property (nonatomic,strong) HHSoftDefaults *hhosftDefaults;

@end

@implementation SearchHistoryViewController
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setBackBarButtonItemTitle:@""];
    self.view.backgroundColor = [GlobalFile backgroundColor];
    self.navigationItem.titleView = [self titleView];
    //获取历史搜索纪录
    _hhosftDefaults = [[HHSoftDefaults alloc] init];
    _arrHistory = [[NSMutableArray alloc] init];
    NSArray *tempArr = [_hhosftDefaults objectForKey:@"HomeSearchHistory"];
    for (NSString *keyWords in tempArr) {
        [_arrHistory addObject:keyWords];
    }
    [self.view addSubview:self.dataCollectionView];
}
#pragma mark -- 初始化搜索
-(UIView *)titleView{
    if (_titleView == nil) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width-80, 30)];
        _titleView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
        _titleView.layer.cornerRadius = 3.0;
        //输入框
        UITextField *searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width-80, 30)];
        searchTextField.placeholder = @"搜索广告、供应商、关键词";
        searchTextField.delegate = self;
        searchTextField.font = [UIFont systemFontOfSize:14.0];
        searchTextField.returnKeyType =UIReturnKeySearch;
        searchTextField.clearButtonMode = UITextFieldViewModeAlways;
        searchTextField.tintColor = [UIColor lightGrayColor];
        searchTextField.tag = 333;
        [_titleView addSubview:searchTextField];
        UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7.5, 30, 15)];
        searchImageView.image = [UIImage imageNamed:@"search.png"];
        searchImageView.contentMode = UIViewContentModeCenter;
        searchTextField.leftViewMode = UITextFieldViewModeAlways;
        searchTextField.leftView = searchImageView;
    }
    return _titleView;
}
#pragma mark -- 初始化dataCollectionView
-(UICollectionView *)dataCollectionView{
    if (_dataCollectionView == nil) {
        _layout = [[HHSoftCustomFlowLayout alloc] init];
        _dataCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, [HHSoftAppInfo AppScreen].height-64) collectionViewLayout:_layout];
        _dataCollectionView.delegate = self;
        _dataCollectionView.dataSource = self;
        _dataCollectionView.backgroundColor = [UIColor whiteColor];
        _dataCollectionView.showsHorizontalScrollIndicator = YES;
        [_dataCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"SearchHistoryViewCell"];
    }
    return _dataCollectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//每个section有多少个元素
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrHistory.count+1;
}
//定义每个UICollectionView 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == _arrHistory.count) {
        return CGSizeMake([HHSoftAppInfo AppScreen].width-30, 30);
    }
    NSString *str = _arrHistory[indexPath.row];
    CGSize size = [str boundingRectWithfont:[UIFont systemFontOfSize:14.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-30, 30)];
    return CGSizeMake(size.width+10, 30);
}
//定义每个UICollectionView 的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake (10, 0, 10, 0);
}
//每个单元格的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //初始化每个单元格
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchHistoryViewCell" forIndexPath:indexPath];
    for (UIView *vie in cell.contentView.subviews) {
        [vie removeFromSuperview];
    }
    if (indexPath.row == _arrHistory.count) {
        HHSoftLabel *clearLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width-30, 30) fontSize:14.0 text:(_arrHistory.count==0?(@"暂无历史记录"):(@"清除历史记录")) textColor:[GlobalFile themeColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
        [cell.contentView addSubview:clearLabel];
        
        return cell;
    }
    NSString *str = _arrHistory[indexPath.row];
    CGSize size = [str boundingRectWithfont:[UIFont systemFontOfSize:14.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-30, 30)];
    HHSoftLabel *historyLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(0, 0, size.width+10, 30) fontSize:14.0 text:str textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
    historyLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    historyLabel.layer.borderWidth = 1.0;
    historyLabel.layer.cornerRadius = 4.0;
    historyLabel.layer.masksToBounds = YES;
    [cell.contentView addSubview:historyLabel];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == _arrHistory.count) {
        //清除历史记录
        if (_arrHistory.count) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定清空历史纪录？" preferredStyle: UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //确认清除搜索历史
                [_arrHistory removeAllObjects];
                [_hhosftDefaults saveObject:_arrHistory forKey:@"HomeSearchHistory"];
                [self.dataCollectionView reloadData];
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }else{
        NSString *str = _arrHistory[indexPath.row];
        [self pushSearchResultControllerWithKey:@"HomeSearchHistory" KeyWords:str ArrHistory:_arrHistory];
    }
}
#pragma mark -- 键盘搜索按钮监听
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    textField.text = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (textField.text.length) {
        if (![_arrHistory containsObject:textField.text]) {
            [_arrHistory insertObject:textField.text atIndex:0];
            [_hhosftDefaults saveObject:_arrHistory forKey:@"HomeSearchHistory"];
        }
        [self pushSearchResultControllerWithKey:@"HomeSearchHistory" KeyWords:textField.text ArrHistory:_arrHistory];
    }else {
        [self showErrorView:@"请输入搜索内容"];
        return NO;
    }
    return YES;
}
#pragma mark ------ 跳转搜索界面控制器
- (void)pushSearchResultControllerWithKey:(NSString *)key KeyWords:(NSString *)keyWords ArrHistory:(NSMutableArray *)arrHistory{
    SearchResultsViewController *searchResultsViewController = [[SearchResultsViewController alloc] initWithKey:key KeyWord:keyWords ArrHistory:arrHistory];
    [self.navigationController pushViewController:searchResultsViewController animated:NO];
}
@end
