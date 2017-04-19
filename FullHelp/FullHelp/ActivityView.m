//
//  ActivityView.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/5.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "ActivityView.h"
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import "ActivityInfo.h"
#import "GlobalFile.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>

@interface ActivityView ()
@property (nonatomic, copy) ChooseActivity chooseActivity;
@end

@implementation ActivityView
- (instancetype)initWithFrame:(CGRect)frame chooseActivity:(ChooseActivity)chooseActivity {
    self = [super initWithFrame:frame];
    if (self) {
        self.chooseActivity = chooseActivity;
        _titleLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width-20, 25) fontSize:16 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
        [self addSubview:_titleLabel];
        
        CGFloat imgWidth = self.frame.size.width-20;
        CGFloat imgHeight = imgWidth/5*4;
        CGFloat imgY = 25 + (self.frame.size.height-25-imgHeight)/2;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, imgY, imgWidth, imgHeight)];
        [self addSubview:_imageView];
        
        self.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(categoryTap)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}
#pragma mark ------ 选择类别击事件
- (void) categoryTap {
    if (self.chooseActivity) {
        if (_activityInfo) {
            self.chooseActivity(_activityInfo);
        }
    }
}
- (void)setActivityInfo:(ActivityInfo *)activityInfo {
    _activityInfo = activityInfo;
    _titleLabel.text = _activityInfo.activityTitle;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_activityInfo.activityImg] placeholderImage:[GlobalFile HHSoftDefaultImg5_4]];
    [_titleLabel sizeToFit];
}
@end
