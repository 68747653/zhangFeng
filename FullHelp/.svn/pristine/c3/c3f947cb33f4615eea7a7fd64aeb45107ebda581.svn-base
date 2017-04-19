//
//  SwitchTableViewCell.m
//  PalmShuYang
//
//  Created by hhsoft on 2016/11/22.
//  Copyright © 2016年 www.huahansoft.com. All rights reserved.
//

#import "SwitchTableViewCell.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import "GlobalFile.h"
@implementation SwitchTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}
- (void)setUI {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    self.textLabel.textColor = [HHSoftAppInfo defaultLightSystemColor];
    
    _swich = [[UISwitch alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width-66, 6.5, 51, 31)];
    [_swich setOnTintColor:[GlobalFile themeColor]];
    [self addSubview:_swich];
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
