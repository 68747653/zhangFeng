//
//  ProductLabelCollectionViewCell.m
//  FullHelp
//
//  Created by hhsoft on 17/2/8.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "ProductLabelCollectionViewCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"
#import "RedPacketAdvertLabelInfo.h"

@interface ProductLabelCollectionViewCell ()
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic,strong) HHSoftLabel *label;

@end

@implementation ProductLabelCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //标签背景
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _bgImageView.image = [[UIImage imageNamed:@"advert_label.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
        [self.contentView addSubview:_bgImageView];
        //标签内容
        _label = [[HHSoftLabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) fontSize:14.0 text:@"" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
        [_bgImageView addSubview:_label];
    }
    return self;
}
- (void)setProductLabelInfo:(RedPacketAdvertLabelInfo *)productLabelInfo{
    _productLabelInfo = productLabelInfo;
    _label.text = [NSString stringByReplaceNullString:_productLabelInfo.redPacketAdvertLabelName];
}
@end
