//
//  HHSoftImageCollectionViewFlowLayout.m
//  CollectionView
//
//  Created by hhsoft on 2016/12/26.
//  Copyright © 2016年 ZZUn. All rights reserved.
//

#import "HHSoftImageCollectionViewFlowLayout.h"

@implementation HHSoftImageCollectionViewFlowLayout
//完成一个过程需要的位移
#define ACTIVE_DISTANCE 200

#define GiveMeHeight(HEIGTH) (HEIGTH*[UIScreen mainScreen].bounds.size.height/736.0)
#define GiveMeWidth(WIDTH) (WIDTH*[UIScreen mainScreen].bounds.size.width/414.0)

//第一个要重写的方法 设置基本的大小
- (void)prepareLayout
{
    self.itemSize = CGSizeMake(GiveMeWidth(300),GiveMeHeight(500));
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(0, 50.0, 0, 50.0);
    self.minimumLineSpacing = 0.0;
}

//允许更新位置
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}

//最大旋转角度
#define rotate 15.0*M_PI/180.0
//返回一个rect位置下所有cell的位置数组
- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes* attributes in array) {
        
        //cell中心离collectionview中心的位移
        //CGRectGetMidX表示得到一个frame中心点的X坐标
        CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
        
        //CGRectIntersectsRect 判断两个矩形是否相交
        //这里判断当前这个cell在不在rect矩形里
        if (CGRectIntersectsRect(attributes.frame, rect))
        {
            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
            
            //如果位移小于一个过程所需的位移
            if (ABS(distance) < ACTIVE_DISTANCE)
            {
                //normalizedDistance 当前位移比上完成一个过程所需位移 得到不完全过程的旋转角度
                CGFloat zoom = rotate*normalizedDistance;
                CATransform3D transfrom = CATransform3DIdentity;
                transfrom.m34 = 1.0 / 400;
                transfrom = CATransform3DRotate(transfrom, -zoom, 0.0f, 1.0f, 0.0f);
                attributes.transform3D = transfrom;
                attributes.zIndex = 1;
                
            }
            else
            {
                CATransform3D transfrom = CATransform3DIdentity;
                transfrom.m34 = 1.0 / 400;
                //向右滑
                if (distance>0)
                {
                    transfrom = CATransform3DRotate(transfrom, -rotate, 0.0f, 1.0f, 0.0f);
                    
                }
                //向左滑
                else
                {
                    transfrom = CATransform3DRotate(transfrom, rotate, 0.0f, 1.0f, 0.0f);
                }
                
                attributes.transform3D = transfrom;
                attributes.zIndex = 1;
            }
            
        }
    }
    return array;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat offsetAdjustment = MAXFLOAT;
    
    //CGRectGetWidth: 返回矩形的宽度
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    
    //当前rect
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    //对当前屏幕中的UICollectionViewLayoutAttributes逐个与屏幕中心进行比较，找出最接近中心的一个
    for (UICollectionViewLayoutAttributes* layoutAttributes in array)
    {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment))
        {
            //与中心的位移差
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    //返回修改后停下的位置
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}
@end
