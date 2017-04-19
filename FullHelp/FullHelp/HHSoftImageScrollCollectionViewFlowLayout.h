//
//  HHSoftImageScrollCollectionViewFlowLayout.h
//  FullHelp
//
//  Created by hhsoft on 17/2/9.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    HHSoftScaleLayout,
    HHSoftRotationLayout1,
    HHSoftRotationLayout2,
    HHSoftRotationLayout3
}HHSoftLayoutType;

@interface HHSoftImageScrollCollectionViewFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, assign) HHSoftLayoutType type;

+ (HHSoftImageScrollCollectionViewFlowLayout *)createHHSoftLayout;
@end
