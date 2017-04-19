//
//  AdvertCommentViewCell.m
//  FullHelp
//
//  Created by hhsoft on 17/2/8.
//  Copyright © 2017年 hhsoft. All rights reserved.
//

#import "AdvertCommentViewCell.h"
#import "AdvertCommentCollectionViewCell.h"
#import <HHSoftFrameWorkKit/UIImageView+HHSoftWebCache.h>
#import <HHSoftFrameWorkKit/HHSoftLabel.h>
#import <HHSoftFrameWorkKit/HHSoftAppInfo.h>
#import <HHSoftFrameWorkKit/HHSoftButton.h>
#import <HHSoftFrameWorkKit/NSString+HHSoftAddition.h>
#import "CommentInfo.h"
#import "UserInfo.h"
#import "GlobalFile.h"
#import "ImageInfo.h"
#import "CWStarRateView.h"

#define itemW ([HHSoftAppInfo AppScreen].width-30-5*2)/3.0

@interface AdvertCommentViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *commentCollectView;
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) HHSoftLabel *nameLabel,*contentLabel,*timeLabel;
@property (nonatomic,strong) CWStarRateView *commentStarView;


- (instancetype)initImageCellReuseIdentifier:(NSString *)reuseIdentifier;
- (instancetype)initNoImageCellReuseIdentifier:(NSString *)reuseIdentifier;

@end

@implementation AdvertCommentViewCell

#pragma mark -- 初始化cell
+(id)AdvertCommentViewCellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier{
    static NSString *listImageCell = @"listImageCell";
    static NSString *listNoImageCell = @"listNoImageCell";
    AdvertCommentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        if ([identifier isEqualToString:listImageCell]) {
            cell = [[self alloc] initImageCellReuseIdentifier:listImageCell];
        }else
            cell = [[self alloc] initNoImageCellReuseIdentifier:listNoImageCell];
    }
    return cell;
}
#pragma mark -- 初始化有图片的cell
- (instancetype)initImageCellReuseIdentifier:(NSString *)reuseIdentifier{
    self = [self initNoImageCellReuseIdentifier:reuseIdentifier];
    [self.commentCollectView reloadData];
    return self;
}
#pragma mark -- 初始化没有图片的cell
-(instancetype)initNoImageCellReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        //头像
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 40, 40)];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_headImageView];
        //昵称
        _nameLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(65, 20, [HHSoftAppInfo AppScreen].width-65-100-10, 20) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
        [self.contentView addSubview:_nameLabel];
        //星星
        _commentStarView = [[CWStarRateView alloc] initWithFrame:CGRectMake([HHSoftAppInfo AppScreen].width-100-15, 22.5, 100, 15) numberOfStars:5];
        _commentStarView.userInteractionEnabled=NO;//是否支持点击,(只是展示的时候不让点击),默认为NO(既不可以点击)
        _commentStarView.allowIncompleteStar = YES;//是否允许不是整星，默认为NO(即不允许)
        _commentStarView.hasAnimation = NO;//是否允许动画,默认是NO(即不允许)
        _commentStarView.starRateType=StarRateViewTypeShow;//如果是评论的时候,starRateType=StarRateViewTypeComment;如果是在页面显示的时候starRateType=StarRateViewTypeShow;
        [self.contentView addSubview:_commentStarView];
        //内容
        _contentLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 60, [HHSoftAppInfo AppScreen].width-30, 30) fontSize:14.0 text:@"" textColor:[HHSoftAppInfo defaultDeepSystemColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
        [self.contentView addSubview:_contentLabel];
        //时间
        _timeLabel = [[HHSoftLabel alloc] initWithFrame:CGRectMake(15, 95, [HHSoftAppInfo AppScreen].width-30, 30) fontSize:12.0 text:@"" textColor:[UIColor grayColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
        [self.contentView addSubview:_timeLabel];
    }
    return self;
}
-(void)setCommentInfo:(CommentInfo *)commentInfo{
    _commentInfo = commentInfo;
    //头像
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:_commentInfo.userInfo.userHeadImg] placeholderImage:[GlobalFile HHSoftDefaultImg1_1]];
    //昵称
    _nameLabel.text = [NSString stringByReplaceNullString:_commentInfo.userInfo.userNickName];
    //星星
    _commentStarView.scorePercent = _commentInfo.commentScore/5.0;
    //内容
    _contentLabel.text = _commentInfo.commentContent;
    //时间
    _timeLabel.text = _commentInfo.commentAddTime;
    
    if (self.commentCollectView) {
        [self.commentCollectView reloadData];
    }
}
#pragma mark -- 动态计算高度
+ (CGFloat)cellHeightWithCommentInfo:(CommentInfo *)commentInfo{
    //内容
    CGSize contentSize =  [commentInfo.commentContent boundingRectWithfont:[UIFont systemFontOfSize:14.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-30,CGFLOAT_MAX)];
    if (commentInfo.arrCommentGallery.count) {
        CGFloat height;
        //行
        NSInteger row = commentInfo.arrCommentGallery.count/3;
        //列
        NSInteger column = commentInfo.arrCommentGallery.count%3;
        if (column) {
            //行没有排满
            height = (row+1)*(itemW+5);
        }else{
            //行正好排满
            height = row*(itemW+5);
        }
        //间隔：10+头像：40+间隔：10+内容：contentHeight+间隔:5+图片:height+间隔:5
        return 10+40+10+contentSize.height+5+height+5+20+3;
    }else{
        return 10+40+10+contentSize.height+5+20+8;
    }
}
#pragma mark -- 初始化UICollectionView
- (UICollectionView *) commentCollectView {
    if (_commentCollectView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 5;
        flowLayout.minimumInteritemSpacing = 0;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.itemSize = CGSizeMake(itemW, itemW);
        _commentCollectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _commentCollectView.dataSource = self;
        _commentCollectView.delegate = self;
        _commentCollectView.showsVerticalScrollIndicator = NO;
        [_commentCollectView registerClass:[AdvertCommentCollectionViewCell class] forCellWithReuseIdentifier:@"ImgTopicCell"];
        _commentCollectView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_commentCollectView];
    }
    return _commentCollectView;
}
#pragma mark -- UICollectionView的代理
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _commentInfo.arrCommentGallery.count;
}
- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"ImgTopicCell";
    AdvertCommentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ident forIndexPath:indexPath];
    ImageInfo *imageInfo = [_commentInfo.arrCommentGallery objectAtIndex:indexPath.row];
    cell.imageInfo = imageInfo;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *arrImgList = [NSMutableArray arrayWithCapacity:0];
    
    for (ImageInfo *imgModel in _commentInfo.arrCommentGallery) {
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
    
    if (_seeImgViewBlock) {
        _seeImgViewBlock(arrImgList,indexPath.row);
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //内容
    CGSize contentSize =  [_commentInfo.commentContent boundingRectWithfont:[UIFont systemFontOfSize:14.0] maxTextSize:CGSizeMake([HHSoftAppInfo AppScreen].width-30,CGFLOAT_MAX)];
    _contentLabel.frame = CGRectMake(15, 60, [HHSoftAppInfo AppScreen].width-30, contentSize.height);
    if (_commentInfo.arrCommentGallery.count) {
        CGFloat height;
        //行
        NSInteger row = _commentInfo.arrCommentGallery.count/3;
        //列
        NSInteger column = _commentInfo.arrCommentGallery.count%3;
        
        if (column) {
            //没有排满
            height = (row+1)*(itemW+5);
        }else{
            //正好排满
            height = row*(itemW+5);
        }
        _commentCollectView.frame = CGRectMake(15, 60+_contentLabel.frame.size.height+5, itemW*3+5*2, height);
        //时间
        _timeLabel.frame = CGRectMake(15, 60+_contentLabel.frame.size.height+5+height, [HHSoftAppInfo AppScreen].width-30, 20);
    }else{
        //时间
        _timeLabel.frame = CGRectMake(15, 60+_contentLabel.frame.size.height+5, [HHSoftAppInfo AppScreen].width-30, 20);
    }
}

@end
