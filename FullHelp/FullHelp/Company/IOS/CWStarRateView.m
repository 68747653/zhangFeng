//
//  CWStarRateView.m
//  StarRateDemo
//
//  Created by WANGCHAO on 14/11/4.
//  Copyright (c) 2014年 wangchao. All rights reserved.
//

#import "CWStarRateView.h"

#define FOREGROUND_STAR_IMAGE_NAME @"star_select"
#define BACKGROUND_STAR_IMAGE_NAME @"star_unselect"
#define DEFALUT_STAR_NUMBER 5
#define ANIMATION_TIME_INTERVAL 0.2

@interface CWStarRateView ()

@property (nonatomic, strong) UIView *foregroundStarView;
@property (nonatomic, strong) UIView *backgroundStarView;

@property (nonatomic, assign) NSInteger numberOfStars;

@end

@implementation CWStarRateView

#pragma mark - Init Methods
- (instancetype)init {
    NSAssert(NO, @"You should never call this method in this class. Use initWithFrame: instead!");
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame numberOfStars:DEFALUT_STAR_NUMBER];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _numberOfStars = DEFALUT_STAR_NUMBER;
        [self buildDataAndUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars {
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
        [self buildDataAndUI];
    }
    return self;
}

#pragma mark - Private Methods

- (void)buildDataAndUI {
    _scorePercent = 1;//默认为1
    _hasAnimation = NO;//默认为NO
    _allowIncompleteStar = NO;//默认为NO

    self.foregroundStarView = [self createStarViewWithImage:FOREGROUND_STAR_IMAGE_NAME];
    self.backgroundStarView = [self createStarViewWithImage:BACKGROUND_STAR_IMAGE_NAME];
    
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.foregroundStarView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapRateView:)];
        tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];
}
- (void)userTapRateView:(UITapGestureRecognizer *)gesture {
    CGPoint tapPoint = [gesture locationInView:self];
    CGFloat offset = tapPoint.x;

    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    if (_starRateType==StarRateViewTypeComment) {
        if (0<realStarScore&&realStarScore<=0.5) {
            realStarScore=0.5;
        }else if (0.5<realStarScore&&realStarScore<=1){
            realStarScore=1;
        }else if (1<realStarScore&&realStarScore<=1.5){
            realStarScore=1.5;
        }else if (1.5<realStarScore&&realStarScore<=2){
            realStarScore=2;
        }else if (2<realStarScore&&realStarScore<=2.5){
            realStarScore=2.5;
        }else if (2.5<realStarScore&&realStarScore<=3){
            realStarScore=3;
        }else if (3<realStarScore&&realStarScore<=3.5){
            realStarScore=3.5;
        }else if (3.5<realStarScore&&realStarScore<=4){
            realStarScore=4;
        }else if (4<realStarScore&&realStarScore<=4.5){
            realStarScore=4.5;
        }else if (4.5<realStarScore&&realStarScore<=5){
            realStarScore=5;
        }else if (realStarScore==0){
            realStarScore=0;
        }else{
            realStarScore=5;
        }
    }
    CGFloat starScore = self.allowIncompleteStar ? realStarScore : ceilf(realStarScore);
    self.scorePercent = starScore / self.numberOfStars;

}
- (UIView *)createStarViewWithImage:(NSString *)imageName {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < self.numberOfStars; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * (self.bounds.size.width) / self.numberOfStars, 0, self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        if ([imageName isEqualToString:FOREGROUND_STAR_IMAGE_NAME]) {
            imageView.tag=1000+i;
        }
        [view addSubview:imageView];
    }
    return view;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    __weak CWStarRateView *weakSelf = self;
    CGFloat animationTimeInterval = self.hasAnimation ? ANIMATION_TIME_INTERVAL : 0;
    
    CGFloat width=0;
    CGFloat score=self.scorePercent * _numberOfStars;
    if ((NSInteger)score < _numberOfStars && self.scorePercent) {
        CGRect nextStarFrame=((UIImageView *)[self viewWithTag:(1000+(NSInteger)score)]).frame;
        width=nextStarFrame.origin.x + nextStarFrame.size.width *(score-(NSInteger)score);
    }else{
        width=weakSelf.bounds.size.width * weakSelf.scorePercent;
    }
    
    [UIView animateWithDuration:animationTimeInterval animations:^{
            //weakSelf.foregroundStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.scorePercent, weakSelf.bounds.size.height);
        
        weakSelf.foregroundStarView.frame = CGRectMake(0, 0, width, weakSelf.bounds.size.height);
    }];
}

#pragma mark - Get and Set Methods

- (void)setScorePercent:(CGFloat)scroePercent {
    if (_scorePercent == scroePercent) {
        return;
    }
    if (scroePercent < 0) {
        _scorePercent = 0;
    } else if (scroePercent > 1) {
        _scorePercent = 1;
    } else {
        _scorePercent = scroePercent;
    }
    if ([self.delegate respondsToSelector:@selector(starRateView:scroePercentDidChange:)]) {
        [self.delegate starRateView:self scroePercentDidChange:scroePercent];
    }
    
    [self setNeedsLayout];
}

@end
