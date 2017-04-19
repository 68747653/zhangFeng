//
//  BageView.m
//  MedicalCareFree
//
//  Created by hhsoft on 16/9/20.
//  Copyright © 2016年 www.huahansoft.com. All rights reserved.
//

#import "BageView.h"
#import <HHSoftFrameWorkKit/HHSoftButton.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>

@interface BageView ()
@property (nonatomic, strong) HHSoftLabel *messageLabel;
@property (nonatomic, copy) MessageBlock messageBlock;
@end

@implementation BageView
- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image messageBlock:(MessageBlock)messageBlock {
    self = [super initWithFrame:frame];
    if (self) {
        _messageBlock = messageBlock;
        HHSoftButton *messageButton=[HHSoftButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) titleColor:nil titleSize:12];
        [messageButton setImage:image forState:UIControlStateNormal];
        [messageButton addTarget:self action:@selector(messageButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:messageButton];
        
        _messageLabel=[[HHSoftLabel alloc] initWithFrame:CGRectMake(28, 5, 10, 10) fontSize:13 text:@"" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
        _messageLabel.backgroundColor = [UIColor redColor];
        _messageLabel.font=[UIFont boldSystemFontOfSize:13];
        _messageLabel.layer.cornerRadius=_messageLabel.bounds.size.width/2;
        _messageLabel.layer.masksToBounds=YES;
        _messageLabel.hidden = YES;
        [self addSubview:_messageLabel];

    }
    return self;
}
- (void)setBageValue:(NSInteger)bageValue {
    _bageValue = bageValue;
    if (_bageValue > 0) {
        _messageLabel.hidden = NO;
    }else {
        _messageLabel.hidden = YES;
    }
}
- (void)messageButtonPressed {
    if (_messageBlock) {
        _messageBlock();
    }
}
@end
