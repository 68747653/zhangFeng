//
//  ImpressViewCell.m
//  FullHelp
//
//  Created by hhsoft on 17/2/9.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "ImpressViewCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "HHSoftCustomFlowLayout.h"
#import "ImpressInfo.h"
#import "AdvertInfo.h"
#import "ImpressCollectionViewCell.h"
#import <HHSoftFrameWorkKit/SVProgressHUD.h>

@interface ImpressViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *dataCollectionView;
@property (nonatomic,strong) HHSoftCustomFlowLayout *layout;
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,strong) AdvertInfo *advertInfo;

@end

@implementation ImpressViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier  AdvertInfo:(AdvertInfo *)advertInfo CellHeight:(CGFloat)cellHeight{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _advertInfo = advertInfo;
        _cellHeight = cellHeight;
        [self initImpressViewCell];
    }
    return self;
}
-(void)initImpressViewCell{
    [self addSubview:self.dataCollectionView];
}
#pragma mark -- 初始化dataCollectionView
-(UICollectionView *)dataCollectionView{
    if (_dataCollectionView == nil) {
        _layout = [[HHSoftCustomFlowLayout alloc] init];
        _dataCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, _cellHeight) collectionViewLayout:_layout];
        _dataCollectionView.delegate = self;
        _dataCollectionView.dataSource = self;
        _dataCollectionView.backgroundColor = [UIColor whiteColor];
        _dataCollectionView.showsHorizontalScrollIndicator = NO;
        [_dataCollectionView registerClass:[ImpressCollectionViewCell class] forCellWithReuseIdentifier:@"ImpressCollectionViewCell"];
    }
    return _dataCollectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//每个section有多少个元素
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _advertInfo.arrImpressList.count;
}
//定义每个UICollectionView 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImpressInfo *impressInfo = _advertInfo.arrImpressList[indexPath.row];
    CGSize size = [[NSString stringWithFormat:@"%@(%@)",[NSString stringByReplaceNullString:impressInfo.impressName],[@(impressInfo.impressCommentCount) stringValue]] boundingRectWithfont:[UIFont systemFontOfSize:14.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-20, 30)];
    return CGSizeMake(size.width+10, 30);
}
//定义每个UICollectionView 的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake (10, 0, 10, 0);
}
//每个单元格的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //初始化每个单元格
    ImpressCollectionViewCell *cell = (ImpressCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ImpressCollectionViewCell" forIndexPath:indexPath];
    //给单元格上的元素赋值
    ImpressInfo *impressInfo = _advertInfo.arrImpressList[indexPath.row];
    if (impressInfo.impressIsComment) {
        cell.impressLabel.layer.borderColor = [GlobalFile themeColor].CGColor;
        cell.impressLabel.textColor = [GlobalFile themeColor];
    }else{
        cell.impressLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.impressLabel.textColor = [HHSoftAppInfo defaultDeepSystemColor];
    }
    cell.impressLabel.text = [NSString stringWithFormat:@"%@(%@)",[NSString stringByReplaceNullString:impressInfo.impressName],[@(impressInfo.impressCommentCount) stringValue]];
    
    return cell;
    
}
-(void)collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ImpressInfo *impressInfo = _advertInfo.arrImpressList[indexPath.row];
    if (impressInfo.impressIsComment) {
        [SVProgressHUD showErrorWithStatus:@"已评价"];
        return;
    }
    if (_impressSelectBlock) {
        _impressSelectBlock(indexPath.row);
    }
}
//返回这个UICollectionViewCell是否可以被选择
-(BOOL)collectionView:( UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _dataCollectionView.frame = CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, _cellHeight);
}

@end
