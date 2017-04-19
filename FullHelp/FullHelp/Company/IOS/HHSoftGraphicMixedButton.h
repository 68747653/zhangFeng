//
//  ClassButton.h
//  MiFenWo
//
//  Created by hhsoft on 15/12/30.
//  Copyright © 2015年 www.huahansoft.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHSoftGraphicMixedButton : UIButton

/**
 图文混排按钮（左右  上下的使用UIButton+HHSoft）
 */
- (instancetype)initWithFrame:(CGRect)frame imgSize:(CGSize)imgSize;
@property (nonatomic, copy) NSString *buttonTitle;
@end
