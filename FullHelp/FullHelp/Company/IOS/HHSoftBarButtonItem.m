//
//  HHSoftBarButtonItem.m
//  MedicalCareFreeDoctor
//
//  Created by hhsoft on 2016/11/3.
//  Copyright © 2016年 www.huahansoft.com. All rights reserved.
//

#import "HHSoftBarButtonItem.h"

@interface HHSoftBarButtonItem ()
@property (nonatomic, copy) ItemClickBlock itemClickBlock;
@end

@implementation HHSoftBarButtonItem
-(instancetype)initBackButtonWithBackBlock:(ItemClickBlock)itemClickBlock{
    if (self = [super initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(itemClickEvent)]) {
        _itemClickBlock  = itemClickBlock;
        self.imageInsets = UIEdgeInsetsMake(1, -8, -1, 8);
    }
    return self;
}
- (instancetype)initBackButtonWithWhiteBackBlock:(ItemClickBlock)itemClickBlock{
    if (self = [super initWithImage:[[UIImage imageNamed:@"back_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(itemClickEvent)]) {
        _itemClickBlock  = itemClickBlock;
        self.imageInsets = UIEdgeInsetsMake(1, -8, -1, 8);
    }
    return self;
}
- (instancetype)initBackButtonWithWhiteImgStr:(NSString *)backImgStr backBlock:(ItemClickBlock)itemClickBlock{
    if (self = [super initWithImage:[[UIImage imageNamed:backImgStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(itemClickEvent)]) {
        _itemClickBlock  = itemClickBlock;
        self.imageInsets = UIEdgeInsetsMake(1, -8, -1, 8);
    }
    return self;
}
- (void)itemClickEvent {
    if (_itemClickBlock) {
        _itemClickBlock();
    }
}
- (instancetype)initWithitemTitle:(NSString *)title itemClickBlock:(ItemClickBlock)itemClickBlock{
    _itemClickBlock  = itemClickBlock;
    self = [super initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(itemClickEvent)];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithImageStr:(NSString *)imageStr itemClickBlock:(ItemClickBlock)itemClickBlock {
    _itemClickBlock  = itemClickBlock;
    UIImage *image = [[UIImage imageNamed:imageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self = [super initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(itemClickEvent)];
    if (self) {
        
    }
    return self;
}
@end
