//
//  AdvertDetailHeaderView.m
//  FullHelp
//
//  Created by hhsoft on 17/2/7.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AdvertDetailHeaderView.h"
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import "GlobalFile.h"
#import "HHSoftImageScrollCollectionViewFlowLayout.h"
#import "AdvertGalleryCollectionViewCell.h"
#import "AdvertInfo.h"
#import "ImageInfo.h"

#define headerWidth [UIScreen mainScreen].bounds.size.width
#define headerHeight [UIScreen mainScreen].bounds.size.height

@interface AdvertDetailHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *dataCollectionView;
@property (nonatomic,strong) AdvertInfo *advertInfo;

@property (nonatomic, copy) NSString *hour;
@property (nonatomic, copy) NSString *minute;
@property (nonatomic, copy) NSString *second;
@property (nonatomic, strong) NSTimer *countDownTimer;
@property (nonatomic, copy) NSString *countDownStr;
@property (nonatomic, strong) HHSoftLabel *countDownLabel;
/**
 活动剩余时间
 */
@property (nonatomic, assign) NSInteger restTime;
@property (nonatomic,copy) AdvertDetailHeaderViewImageBlock imageBlock;

@end

@implementation AdvertDetailHeaderView
-(instancetype)initWithFrame:(CGRect)frame AdvertInfo:(AdvertInfo *)advertInfo AdvertDetailHeaderViewImageBlock:(AdvertDetailHeaderViewImageBlock)imageBlock{
    if(self = [super initWithFrame:frame]){
        _advertInfo = advertInfo;
        _restTime = _advertInfo.countDown;
        _imageBlock = imageBlock;
        [self initAdvertDetailHeaderViewWithFrame:frame];
    }
    return self;
}
-(void)initAdvertDetailHeaderViewWithFrame:(CGRect)frame{
    if (_advertInfo.arrRedAdvertGalleryList.count) {
        [self addSubview:self.dataCollectionView];
    }else{
        UIImageView *defaultImageView = [[UIImageView alloc] initWithFrame:CGRectMake((headerWidth-headerWidth/2.02)/2.0, (headerWidth-headerWidth/2.01*8/5)/2.0, headerWidth/2.02, headerWidth/2.01*8/5)];
        defaultImageView.image = [GlobalFile HHSoftDefaultImg5_8];
        [self addSubview:defaultImageView];
    }
    
    //现金红包不显示倒计时和今日红包显示倒计时
    if (_advertInfo.redAdvertType == 2) {
        if (_restTime > 0) {
            _countDownLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(0, self.frame.size.width, [HHSoftAppInfo AppScreen].width, 50) fontSize:14 text:@"" textColor:[HHSoftAppInfo defaultLightSystemColor] textAlignment:NSTextAlignmentCenter numberOfLines:2];
            [self addSubview:_countDownLabel];
            
            _countDownStr = [NSString stringWithFormat:@"%@",[self timeformatFromSeconds:_restTime]];
            _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startTimeCountDown) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_countDownTimer forMode:UITrackingRunLoopMode];
            [_countDownTimer fire];
        }
    }
}
#pragma mark -- 初始化dataCollectionView
-(UICollectionView *)dataCollectionView{
    if (_dataCollectionView == nil) {
        // 1.初始化 WQLayout
        HHSoftImageScrollCollectionViewFlowLayout *layout = [HHSoftImageScrollCollectionViewFlowLayout createHHSoftLayout];
        // 2.动画选择
        layout.type = HHSoftRotationLayout3;
        // 3.1 动画方向(垂直)
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(headerWidth/2.02, headerWidth/2.01*8/5);
//        layout.minimumLineSpacing = layout.itemSize.width/10;
        
        _dataCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, headerWidth, self.frame.size.width) collectionViewLayout:layout];
        _dataCollectionView.delegate = self;
        _dataCollectionView.dataSource = self;
        _dataCollectionView.backgroundColor = [UIColor whiteColor];
        _dataCollectionView.showsHorizontalScrollIndicator = NO;
        [_dataCollectionView registerClass:[AdvertGalleryCollectionViewCell class] forCellWithReuseIdentifier:@"ImageCollectionViewCell"];
    }
    return _dataCollectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//每个section有多少个元素
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _advertInfo.arrRedAdvertGalleryList.count;
}
//每个单元格的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //初始化每个单元格
    AdvertGalleryCollectionViewCell *cell = (AdvertGalleryCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionViewCell" forIndexPath:indexPath];
    //给单元格上的元素赋值
    cell.imageInfo = _advertInfo.arrRedAdvertGalleryList[indexPath.row];
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *arrImgList = [NSMutableArray arrayWithCapacity:0];
    
    for (ImageInfo *imgModel in _advertInfo.arrRedAdvertGalleryList) {
        if(imgModel.imageSource) {
            [arrImgList addObject:imgModel.imageSource];
        }else if (imgModel.imageBig){
            [arrImgList addObject:imgModel.imageBig];
        }else if (imgModel.imageThumb){
            [arrImgList addObject:imgModel.imageThumb];
        }else{
            [arrImgList addObject:[GlobalFile HHSoftDefaultImg1_1]];
        }
    }
    
    if (_imageBlock) {
        _imageBlock(arrImgList,indexPath.row);
    }
}
#pragma mark ------ 倒计时
- (void)startTimeCountDown {
    if (_restTime>0) {
        _restTime--;
        _countDownStr = [NSString stringWithFormat:@"距离结束还剩\n%@",[self timeformatFromSeconds:_restTime]];
        _countDownLabel.attributedText = [self changeCountDownLabelTextWithStr:_countDownStr];
        if (_restTime == 0) {
            [_countDownTimer invalidate];
            _countDownTimer = nil;
        }
    }else {
        [_countDownTimer invalidate];
        _countDownTimer = nil;
    }
}
#pragma mark ------ 根据秒计算天时分秒
-(NSString*)timeformatFromSeconds:(NSInteger)seconds
{
    _hour = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%02ld",seconds/3600%24]];
    _minute = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%02ld",(seconds%3600)/60]];
    _second = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%02ld",seconds%60]];
    NSString *time = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@ : %@ : %@",_hour,_minute,_second]];
    return time;
}
- (NSMutableAttributedString *)changeCountDownLabelTextWithStr:(NSString *)str {
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange hourRange = NSMakeRange(7, 2);
    NSDictionary *dicHour = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[GlobalFile themeColor],NSBackgroundColorAttributeName, nil];
    [attributed addAttributes:dicHour range:hourRange];
    
    NSRange minuteRange = NSMakeRange(12, 2);
    NSDictionary *minuteHour = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[GlobalFile themeColor],NSBackgroundColorAttributeName, nil];
    [attributed addAttributes:minuteHour range:minuteRange];
    
    NSRange secondRange = NSMakeRange(17, 2);
    NSDictionary *secondHour = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[GlobalFile themeColor],NSBackgroundColorAttributeName, nil];
    [attributed addAttributes:secondHour range:secondRange];
    
    _countDownLabel.attributedText = attributed;
    return  attributed;
}
@end
