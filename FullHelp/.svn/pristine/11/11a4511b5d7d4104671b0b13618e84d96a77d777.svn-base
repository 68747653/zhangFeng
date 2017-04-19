//
//  ImpressLabelView.m
//  FullHelp
//
//  Created by hhsoft on 17/2/9.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "ImpressLabelView.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "ImpressInfo.h"
#import "ImpressCollectionViewCell.h"
#import "HHSoftCustomFlowLayout.h"

@interface ImpressLabelView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *dataCollectionView;
@property (nonatomic,strong) HHSoftCustomFlowLayout *layout;

@end

@implementation ImpressLabelView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initImpressLabelView];
    }
    return self;
}
-(void)initImpressLabelView{
    [self addSubview:self.dataCollectionView];
}
-(void)setArrImpressLabel:(NSMutableArray *)arrImpressLabel{
    _arrImpressLabel = arrImpressLabel;
    [self.dataCollectionView reloadData];
}
#pragma mark -- 初始化dataCollectionView
-(UICollectionView *)dataCollectionView{
    if (_dataCollectionView == nil) {
        _layout = [[HHSoftCustomFlowLayout alloc] init];
        _dataCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
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
    return _arrImpressLabel.count;
}
//定义每个UICollectionView 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImpressInfo *impressInfo = _arrImpressLabel[indexPath.row];
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
    ImpressInfo *impressInfo = _arrImpressLabel[indexPath.row];
    
    cell.impressLabel.text = [NSString stringWithFormat:@"%@(%@)",[NSString stringByReplaceNullString:impressInfo.impressName],[@(impressInfo.impressCommentCount) stringValue]];
    
    return cell;
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _dataCollectionView.frame = CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, _layout.collectionViewContentSize.height);
    self.frame = CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, _layout.collectionViewContentSize.height);
    //添加 字典，将label的值通过key值设置传递
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:[@(_layout.collectionViewContentSize.height) stringValue],@"ImpressLabelHeight", nil];
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"GetImpressLabelHeight" object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
@end
