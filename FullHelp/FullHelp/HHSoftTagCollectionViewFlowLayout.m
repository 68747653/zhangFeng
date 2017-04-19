//
//  HHSoftTagCollectionViewFlowLayout.m
//  CollectionView
//
//  Created by hhsoft on 2016/12/26.
//  Copyright © 2016年 ZZUn. All rights reserved.
//

#import "HHSoftTagCollectionViewFlowLayout.h"

@interface HHSoftTagCollectionViewFlowLayout ()

@property (nonatomic, assign) CGPoint endTagPoint;
@property (nonatomic, assign) CGFloat itemHeight;
/**
 列间距
 */
@property (nonatomic, assign) CGFloat columnSpacing;

/**
 行间距
 */
@property (nonatomic, assign) CGFloat rowSpacing;

@end

@implementation HHSoftTagCollectionViewFlowLayout

+(instancetype)hhsoftFlowLayoutWithColumnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing itemHeight:(CGFloat)itemHeight sectionInsets:(UIEdgeInsets)sectionInsets {
    return  [[HHSoftTagCollectionViewFlowLayout alloc] initWithColumnSpacing:columnSpacing rowSpacing:rowSpacing itemHeight:itemHeight sectionInsets:sectionInsets];
}
- (instancetype)initWithColumnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing itemHeight:(CGFloat)itemHeight sectionInsets:(UIEdgeInsets)sectionInsets {
    self = [super init];
    if (self) {
//        CGFloat margin = columnSpacing;
//        CGFloat itemW = (([UIScreen mainScreen].bounds.size.width-margin*(columnCount-1))-sectionInsets.left-sectionInsets.right)/columnCount;
//        self.itemSize = CGSizeMake(itemW, itemHeight);
        self.itemHeight = itemHeight;
        self.columnSpacing = columnSpacing;
        self.rowSpacing = rowSpacing;
        self.sectionInset = sectionInsets;
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
    }
    return self;
}
- (void)prepareLayout
{
    [super prepareLayout];    
    self.endTagPoint = CGPointZero;
    
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray * attrsArray = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger j = 0; j < count; j++) {
        UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:j inSection:0]];
        [attrsArray addObject:attrs];
    }
    return  attrsArray;
}
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat width = 0.0;
    CGFloat x = 0.0;
    CGFloat y = 0.0;
    width = [self sizeWithString:self.arrTag[indexPath.row] fontSize:14].width+21;
    CGFloat judge = self.endTagPoint.x + width + self.columnSpacing + self.sectionInset.right;
    if (judge > CGRectGetWidth(self.collectionView.frame)) {
        x = self.sectionInset.left;
        y = self.endTagPoint.y + self.rowSpacing;
    }else{
        if (indexPath.item == 0) {
            x = self.sectionInset.left;
            y = self.sectionInset.top;
        }else{
            x = self.endTagPoint.x + self.columnSpacing;
            y = self.endTagPoint.y - self.itemHeight;
        }
        
    }
    //更新结束位置
    self.endTagPoint = CGPointMake(x + width, y + self.itemHeight);
    
    
    attr.frame = CGRectMake(x, y, width, self.itemHeight);
    return attr;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
- (CGSize)collectionViewContentSize
{
    CGSize contentSize;
    contentSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame), self.endTagPoint.y);
    return contentSize;
}
- (CGSize)sizeWithString:(NSString *)str fontSize:(float)fontSize
{
    CGSize constraint = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, fontSize + 1);
    
    CGSize tempSize;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize retSize = [str boundingRectWithSize:constraint
                                       options:
                      NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attribute
                                       context:nil].size;
    tempSize = retSize;
    
    return tempSize ;
}
@end

