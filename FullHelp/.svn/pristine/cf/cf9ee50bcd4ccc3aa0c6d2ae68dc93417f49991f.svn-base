//
//  DefaultCollectionViewFlowLayout.m
//  CollectionView
//
//  Created by hhsoft on 2016/12/22.
//  Copyright © 2016年 ZZUn. All rights reserved.
//

#import "DefaultCollectionViewFlowLayout.h"


@interface DefaultCollectionViewFlowLayout ()
/**
 列数
 */
@property (nonatomic, assign) NSInteger columnCount;

/**
 列间距
 */
@property (nonatomic, assign) CGFloat columnSpacing;

/**
 行间距
 */
@property (nonatomic, assign) CGFloat rowSpacing;

@end

@implementation DefaultCollectionViewFlowLayout

+(instancetype)hhsoftFlowLayoutWithColumnCount:(NSInteger)columnCount columnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing itemHeight:(CGFloat)itemHeight sectionInsets:(UIEdgeInsets)sectionInsets {
    return  [[DefaultCollectionViewFlowLayout alloc] initWithColumnCount:columnCount columnSpacing:columnSpacing rowSpacing:rowSpacing itemHeight:itemHeight sectionInsets:sectionInsets];
    
}
- (instancetype)initWithColumnCount:(NSInteger)columnCount columnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing itemHeight:(CGFloat)itemHeight sectionInsets:(UIEdgeInsets)sectionInsets {
    self = [super init];
    if (self) {
        CGFloat margin = columnSpacing;
        CGFloat itemW = (([UIScreen mainScreen].bounds.size.width-margin*(columnCount-1))-sectionInsets.left-sectionInsets.right)/columnCount;
        if (itemHeight == 0) {
            itemHeight = itemW;
        }
        self.itemSize = CGSizeMake(itemW, itemHeight);
        self.sectionInset = sectionInsets;
        self.minimumLineSpacing = rowSpacing;
        self.minimumInteritemSpacing = 1;
    }
    return self;
}
@end
