//
//  HHSoftTopMenuView.m
//  MedicalCareFree
//
//  Created by hhsoft on 16/9/29.
//  Copyright © 2016年 www.huahansoft.com. All rights reserved.
//

#import "HHSoftTopMenuView.h"

typedef NS_ENUM(NSInteger , TextLayerState){
    TextLayerStateNormal,
    TextLayerStateHighlight,
};

@interface HHSoftTopMenuView ()
//当前选中的菜单索引
@property (nonatomic, assign) NSInteger currentSelectedMenudIndex;
@property (nonatomic, assign) NSInteger columnsOfMenu;
@property (nonatomic, strong) CALayer *indicatorLayer;
@property (nonatomic, assign) CGFloat indicatorLayerH;
@property (nonatomic, assign) CGFloat menuItemW;
@property (nonatomic, strong) NSMutableArray *arrBackLayer;
@property (nonatomic, strong) NSMutableArray *arrTitle;

@end
@implementation HHSoftTopMenuView
- (UIColor *)highlightedTextColor {
    if (!_highlightedTextColor) {
        _highlightedTextColor = [UIColor blackColor];
    }
    return _highlightedTextColor;
}
- (UIColor *)textColor {
    if (!_textColor) {
        _textColor = [UIColor blackColor];
    }
    return _textColor;
}
- (UIColor *)indicatorColor {
    if (!_indicatorColor) {
        _indicatorColor = [UIColor redColor];
    }
    return _indicatorColor;
}
//-(UIColor *)bgMenuColor {
//    if (!_bgMenuColor) {
//        _bgMenuColor = [UIColor whiteColor];
//    }
//    return _bgMenuColor;
//}
- (CGFloat)fontSize {
    if (!_fontSize) {
        _fontSize = 14;
    }
    return _fontSize;
}
- (CGFloat)highlightFontSize {
    if (!_highlightFontSize) {
        _highlightFontSize = 14;
    }
    return _highlightFontSize;
}
- (instancetype)initWithFrame:(CGRect)frame indicatorLayerSize:(CGSize)indicatorLayerSize{
    self = [super initWithFrame:frame];
    if (self) {
//        _currentSelectedMenudIndex = -1;
        self.showsHorizontalScrollIndicator = NO;
        _indicatorLayer = [CALayer layer];
        _indicatorLayerH = indicatorLayerSize.height;
        _indicatorLayer.bounds = CGRectMake(0, 0, indicatorLayerSize.width, _indicatorLayerH);
        [self.layer addSublayer:_indicatorLayer];
        
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuTapped:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}
#pragma mark - gesture handle
- (void)menuTapped:(UITapGestureRecognizer *)gesture {
    CGPoint touchPoint = [gesture locationInView:self];
    //计算点击的索引
    NSInteger tapIndex = touchPoint.x / _menuItemW;
    if (tapIndex < self.arrTitle.count) {
        if (tapIndex != _currentSelectedMenudIndex) {
            [self animationIndicatorWithTapIndex:tapIndex];
            if (_menuDelegate && [_menuDelegate respondsToSelector:@selector(hhsoftTopMenuView:didSelectMenuIndex:)]) {
                [_menuDelegate hhsoftTopMenuView:self didSelectMenuIndex:tapIndex];
            }
        }
    }
}
- (void)animationIndicatorWithTapIndex:(NSInteger)tapIndex {
    for (CATextLayer *textLayer in self.arrTitle) {
        [self changeStateWithTextLayer:textLayer textLayerState:TextLayerStateNormal];
    }
    
    CGFloat offx = 0.0;
    if (tapIndex > _currentSelectedMenudIndex) {
        offx = _menuItemW*tapIndex;
    }
    else {
        offx = _menuItemW*(tapIndex-1);
    }
    CGRect rect = CGRectMake(offx, 0, 165, self.frame.size.height);
    [UIView animateWithDuration:0.25 animations:^{
        CATextLayer *textLayer = self.arrTitle[tapIndex];
        [self changeStateWithTextLayer:textLayer textLayerState:TextLayerStateHighlight];
        [self scrollRectToVisible:rect animated:YES];
        _indicatorLayer.position = CGPointMake(textLayer.position.x, (self.frame.size.height-_indicatorLayerH/2));

    }];
    _currentSelectedMenudIndex = tapIndex;
}
- (void)reloadData {
    [self setMenuDataSource:_menuDataSource];
}
- (void)reloadDataWithMenuIndex:(NSInteger)index {
    CATextLayer *textLayer = self.arrTitle[index];
    textLayer.string = [_menuDataSource hhsoftTopMenuView:self titleForColumn:index];
    if (index == _currentSelectedMenudIndex) {
        [self changeStateWithTextLayer:textLayer textLayerState:TextLayerStateHighlight];
    }else {
        [self changeStateWithTextLayer:textLayer textLayerState:TextLayerStateNormal];
    }
    
}
- (void) selectMenuIndex:(NSInteger)index {
    [self animationIndicatorWithTapIndex:index];
}
- (void)setMenuDataSource:(id<HHSoftTopMenuViewDataSource>)menuDataSource {
    _menuDataSource = menuDataSource;
    _indicatorLayer.backgroundColor = self.indicatorColor.CGColor;
    for (CATextLayer *textLayer in self.arrTitle) {
        [textLayer removeFromSuperlayer];
    }
    if ([_menuDataSource respondsToSelector:@selector(numberOfcolumsInMenuView:)]) {
        _columnsOfMenu = [_menuDataSource numberOfcolumsInMenuView:self];
    }else {
        _columnsOfMenu = 1;
    }
//    if (_columnsOfMenu <= 5) {
//        self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
//    }
//    else {
        self.contentSize = CGSizeMake(_menuItemWidth*_columnsOfMenu, self.frame.size.height);
        _menuItemW = _menuItemWidth;
//    }
    
    _menuItemW  = self.contentSize.width/_columnsOfMenu;

    NSMutableArray *tempTitles = [NSMutableArray array];
    
    for (NSInteger i=0; i<_columnsOfMenu; i++) {
        
        //标题layer
        CGPoint titleLayerPostion = CGPointMake(_menuItemW*(i+0.5)-5, (self.frame.size.height-_indicatorLayerH*2)/2);
        NSString *title = [_menuDataSource hhsoftTopMenuView:self titleForColumn:i];
        CATextLayer *titleLayer = [self createTextLayerWithstring:title color:self.textColor position:titleLayerPostion textLayerState:TextLayerStateNormal];
        [self.layer addSublayer:titleLayer];
        [tempTitles addObject:titleLayer];

    }
    
    _arrTitle = [tempTitles copy];
    if ([_menuDataSource respondsToSelector:@selector(defaultSelectCoumnsInMenuView:)]) {
        _currentSelectedMenudIndex = [_menuDataSource defaultSelectCoumnsInMenuView:self];
    }
    [self animationIndicatorWithTapIndex:_currentSelectedMenudIndex];
}
#pragma mark ------ 标题layer
- (CATextLayer *)createTextLayerWithstring:(NSString *)string color:(UIColor *)color position:(CGPoint)point textLayerState:(TextLayerState)textLayerState{
    CATextLayer *layer = [CATextLayer new];
    CGSize size = [self calculateTitleSizeWithString:string textLayerState:textLayerState];
    CGFloat sizeWidth = (size.width < _menuItemW - 25) ? size.width : _menuItemW - 25;
    layer.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    layer.string = string;
    layer.fontSize = self.fontSize;
    layer.alignmentMode = kCAAlignmentCenter;
    layer.foregroundColor = color.CGColor;
    layer.contentsScale = [[UIScreen mainScreen] scale];
    layer.position = point;
    return layer;
}
- (void)changeStateWithTextLayer:(CATextLayer *)textLayer textLayerState:(TextLayerState)textLayerState{
    CGSize size = [self calculateTitleSizeWithString:textLayer.string textLayerState:textLayerState];
    CGFloat sizeWidth = (size.width < _menuItemW - 25) ? size.width : _menuItemW - 25;
    textLayer.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    if (textLayerState) {
        textLayer.foregroundColor = self.highlightedTextColor.CGColor;
        textLayer.fontSize = self.highlightFontSize;
    }
    else {
        textLayer.foregroundColor = self.textColor.CGColor;
        textLayer.fontSize = self.fontSize;
    }
}
- (CGSize)calculateTitleSizeWithString:(NSString *)string textLayerState:(TextLayerState)textLayerState
{
    CGFloat fontSize;
    if (!textLayerState) {
        fontSize = self.fontSize;
    }else {
        fontSize = self.highlightFontSize;
    }
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(280, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}
#pragma mark ------ 背景layer
- (CALayer *)createBgLayerWithColor:(UIColor *)color position:(CGPoint)position {
    CALayer *layer = [CALayer layer];
    layer.position = position;
    layer.bounds = CGRectMake(0, 0, _menuItemW, self.frame.size.height);
    layer.backgroundColor = color.CGColor;
    
    return layer;
}
- (void) changeIndicatorLayerX:(CGFloat)x {
    
}
@end
