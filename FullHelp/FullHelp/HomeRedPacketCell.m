//
//  HomeRedPacketCell.m
//  FullHelp
//
//  Created by hhsoft on 2017/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "HomeRedPacketCell.h"
#import "HomeRedPacketView.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
@interface HomeRedPacketCell ()


@end

@implementation HomeRedPacketCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}
- (void)setUI {
    
    self.backgroundColor = [UIColor clearColor];
    
    for (NSInteger i = 0; i < 2; i++) {
        
        HomeRedPacketView *advertView = [[HomeRedPacketView alloc] initWithFrame:CGRectZero];
        advertView.tag = 1000+i;
        advertView.hidden = YES;
        [self addSubview:advertView];
        if (i==0) {
            self.firstView = advertView;
        }
        else {
            self.secondView = advertView;
        }
    }
}
- (void)setArrAdvert:(NSMutableArray *)arrAdvert {
    _arrAdvert = arrAdvert;
    if (_arrAdvert.count==0) {
        self.firstView.hidden = NO;
        self.firstView.advertInfo = _arrAdvert[0];
        self.secondView.hidden = YES;
    }
    else {
        self.firstView.hidden = NO;
        self.firstView.advertInfo = _arrAdvert[0];
        self.secondView.hidden = NO;
        self.secondView.advertInfo = _arrAdvert[1];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = ([HHSoftAppInfo AppScreen].width-30)/2;
    for (NSInteger i = 0; i < 2; i++) {
        HomeRedPacketView *advertView = [self viewWithTag:1000+i];
        advertView.frame = CGRectMake(10+(width+10)*i, 5, width, self.frame.size.height-10);
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
