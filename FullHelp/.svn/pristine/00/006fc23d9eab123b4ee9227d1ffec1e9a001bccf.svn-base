//
//  ImpressCollectionViewCell.m
//  FullHelp
//
//  Created by hhsoft on 17/2/9.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "ImpressCollectionViewCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "GlobalFile.h"

@implementation ImpressCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //印象
        _impressLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
        _impressLabel.layer.borderWidth = 1.0;
        _impressLabel.layer.cornerRadius = 3.0;
        _impressLabel.layer.masksToBounds = YES;
        _impressLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.contentView addSubview:_impressLabel];
    }
    return self;
}
@end
