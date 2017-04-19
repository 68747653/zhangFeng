//
//  ProductLabelViewCell.m
//  FullHelp
//
//  Created by hhsoft on 17/2/8.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "ProductLabelViewCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "RedPacketAdvertLabelInfo.h"
#import "ProductLabelCollectionViewCell.h"
#import "HHSoftCustomFlowLayout.h"

@interface ProductLabelViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *dataCollectionView;
@property (nonatomic,strong) HHSoftCustomFlowLayout *layout;
@property (nonatomic,assign) CGFloat cellHeight;
@end

@implementation ProductLabelViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ArrProductLabel:(NSMutableArray *)arrProductLabel CellHeight:(CGFloat)cellHeight{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _arrProductLabel = arrProductLabel;
        _cellHeight = cellHeight;
        [self initProductLabelViewCell];
    }
    return self;
}
-(void)initProductLabelViewCell{
    [self addSubview:self.dataCollectionView];
}
//-(void)setArrProductLabel:(NSMutableArray *)arrProductLabel{
//    _arrProductLabel = arrProductLabel;
//    [self.dataCollectionView reloadData];
//}
#pragma mark -- 初始化dataCollectionView
-(UICollectionView *)dataCollectionView{
    if (_dataCollectionView == nil) {
        _layout = [[HHSoftCustomFlowLayout alloc] init];
        _dataCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, _cellHeight) collectionViewLayout:_layout];
        _dataCollectionView.delegate = self;
        _dataCollectionView.dataSource = self;
        _dataCollectionView.backgroundColor = [UIColor whiteColor];
        _dataCollectionView.showsHorizontalScrollIndicator = NO;
        [_dataCollectionView registerClass:[ProductLabelCollectionViewCell class] forCellWithReuseIdentifier:@"ProductLabelCollectionViewCell1"];
    }
    return _dataCollectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//每个section有多少个元素
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrProductLabel.count;
}
//定义每个UICollectionView 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    RedPacketAdvertLabelInfo *labelInfo = _arrProductLabel[indexPath.row];
    CGSize size = [labelInfo.redPacketAdvertLabelName boundingRectWithfont:[UIFont systemFontOfSize:14.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-20, 30)];
    return CGSizeMake(size.width+10, 30);
}
//定义每个UICollectionView 的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake (10, 0, 10, 0);
}
//每个单元格的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //初始化每个单元格
    ProductLabelCollectionViewCell *cell = (ProductLabelCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ProductLabelCollectionViewCell1" forIndexPath:indexPath];
    //给单元格上的元素赋值
    cell.productLabelInfo = self.arrProductLabel[indexPath.row];
    
    return cell;
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _dataCollectionView.frame = CGRectMake(0, 0, [HHSoftAppInfo AppScreen].width, _cellHeight);
}
@end
