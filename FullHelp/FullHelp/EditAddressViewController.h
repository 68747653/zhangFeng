//
//  EditAddressViewController.h
//  FullHelp
//
//  Created by hhsoft on 2017/2/6.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <HHSoftFrameWorkKit/HHSoftBaseViewController.h>

@class AddressInfo;

typedef NS_ENUM(NSInteger, AddressViewType) {
    EditAddressType,        //修改地址
    SelectAddressType,      //发布需求选择地址
};

typedef void (^EditAddressBlock)(AddressInfo *addressInfo);

@interface EditAddressViewController : HHSoftBaseViewController

- (instancetype)initWithAddressInfo:(AddressInfo *)addressInfo editAddressBlock:(EditAddressBlock)editAddressBlock viewType:(AddressViewType)viewType;

@end
